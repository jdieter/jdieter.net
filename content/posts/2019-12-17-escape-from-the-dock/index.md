---
title: Escape from the dock(er)
author: jdieter
description: Using podman to replace docker for day-to-day usage
type: post
date: 2019-12-17T15:43:20+00:00
url: /posts/2019/12/17/escape-from-the-dock
categories:
  - Computers
tags:
  - fedora
  - docker
  - podman

---

{{<imgproc "dock" Resize "300x" />}}

I've been using Docker (packaged as `moby-engine` in Fedora) on my home server for quite a while now to run [Nextcloud](https://nextcloud.com/), [Home Assistant](https://www.home-assistant.io/), and a few other services.

When I upgraded to Fedora 31, I ran into quite the surprise when I realized that, because of its inability to handle cgroupsv2, Docker [is no longer supported out of the box](https://fedoraproject.org/wiki/Common_F31_bugs#Docker_package_no_longer_available_and_will_not_run_by_default_.28due_to_switch_to_cgroups_v2.29).  The fix is easy enough, but I took this as the kick in the pants I needed to switch over to [podman](https://podman.io).

The process was fairly straightforward, but there were a couple of gotchas that I wanted to document and a couple of podman features that I wanted to take advantage of.

#### No more daemon

This is both a feature and a gotcha when switching from Docker to podman.  The docker daemon, which has traditionally run as root, is an obvious attack vector, and its removal can be seen as nothing other than a pretty compelling feature, but without a daemon, containers will no longer automatically start on boot.

The (maybe not-so) obvious workaround is to treat each container as a service and use an obscure tool called `systemd` to manage the container lifecycle.  Podman will even go to the trouble of [generating a systemd service for you](https://www.mankier.com/1/podman-generate-systemd), if that's what you want.

Unfortunately, there were a couple of things I was looking for that podman's auto-generated services just didn't cover.  The first was container creation; I wanted a service that would create the container if it didn't exist.  The second was auto-updates.  I wanted my containers to automatically update to the latest version on boot.

Just yesterday, Valentin Rothberg [published a post on how to do the first](https://www.redhat.com/sysadmin/podman-shareable-systemd-services), but, unfortunately, his post didn't exist when I was trying to do this a month ago, so I had to wing it. I have shamelessly stolen a few of his ideas, though, to simplify my services.

#### Rootless

The one other major feature I wanted was rootless containers, specifically containers that would be started by root, but would immediately drop privileges so root in the container is not the same as root on the host.

The systemd file I came up with looks something like this:

```
[Unit]
Description=Nextcloud
Wants=mariadb.service network-online.target
After=mariadb.service network-online.target

[Service]
Restart=on-failure
ExecStartPre=-/usr/bin/podman pull docker.io/library/nextcloud:stable
ExecStartPre=-/usr/bin/podman rm -f nextcloud
ExecStart=/usr/bin/podman run \
    --name nextcloud \
    --uidmap 0:110000:4999 \
    --gidmap 0:110000:4999 \
    --uidmap 65534:114999:1 \
    --gidmap 65534:114999:1 \
    --add-host mariadb:10.88.1.2 \
    --hostname nextcloud \
    --conmon-pidfile=/run/nextcloud.pid \
    --tty \
    -p 127.0.0.1:8888:80 \
    -v /var/lib/nextcloud/data:/var/www/html:Z \
    docker.io/library/nextcloud:stable
ExecStop=/usr/bin/podman rm -f nextcloud
KillMode=none
PIDFile=/run/nextcloud.pid

[Install]
WantedBy=multi-user.target
```

Most of this is pretty similar to what Valentin posted, but I want to highlight a few changes that are specific to my goals:

* I'm pulling the image before starting the service.  The `-` at the beginning of the `ExecStartPre` lines means that, if the pull fails for whatever reason, we will still start the service.

* If there's a container called nextcloud running before the service starts, we stop and remove it.  [There can be only one](https://www.youtube.com/watch?&v=sqcLjcSloXs).

* When we actually run `podman run`, we don't use the `-d` (detached) flag and this is a simple service rather than forking.  The reason for this is that I want my container logs to be in the journal, tied to their service, and I haven't worked out how to do that with a forking service.

* The `--uidmap` and `--gidmap` flags are used to map the uids and gids from 0-4998 in the container to 110000-114998 on the host.  Because a number of containers have `nobody` mapped to uid/gid 65534, I then specially map that uid/gid to 114999 on the host.  Using these flags allows my containers to think they're running as root when they're not, and should hopefully help protect my system in the off chance that an attacker were able to break out of the container.

* The `tty` flag is used because we get read/write problems with `/dev/stdin`, `/dev/stdout`, and `/dev/stderr` when using `--uidmap 0` without this flag.

#### Runtime path bug

After running the above setup a few weeks, I noticed that I kept losing the container state.  I found a [related bug report](https://bugzilla.redhat.com/show_bug.cgi?id=1758648), investigated further, and realized that the container state for a system service should be in `/run/crun` rather than `/run/user/0/crun`, and that the latter directory was getting wiped when I'd log out after logging into my server as root (because [root *is* my own account](https://www.theregister.co.uk/2006/02/24/bofh_2006_episode_8/)).

I [submitted a fix](https://github.com/containers/libpod/pull/4657) and it's been [merged upstream](https://github.com/containers/libpod/commit/7287f69b52e5bcb59f9977b261ee488942465ecb), so now we just need to wait for the fix to make it back downstream.  In the meantime, I've made a [scratch build](https://koji.fedoraproject.org/koji/taskinfo?taskID=39686406) with the fix applied.

#### Conclusion

With the podman fix described in the last section, my containers are now working to my satisfaction.

The real joy is when I run the following:

```shell
# podman exec nextcloud ps ax -o user,pid,stat,start,time,command
USER         PID STAT  STARTED     TIME COMMAND
root           1 Ss+  11:57:10 00:00:00 apache2 -DFOREGROUND
www-data      23 S+   11:57:11 00:00:06 apache2 -DFOREGROUND
www-data      24 S+   11:57:11 00:00:04 apache2 -DFOREGROUND
www-data      25 S+   11:57:11 00:00:03 apache2 -DFOREGROUND
www-data      26 S+   11:57:11 00:00:04 apache2 -DFOREGROUND
www-data      27 S+   11:57:11 00:00:02 apache2 -DFOREGROUND
www-data      28 S+   11:57:16 00:00:03 apache2 -DFOREGROUND
www-data      29 S+   11:58:18 00:00:02 apache2 -DFOREGROUND
www-data      34 S+   12:01:07 00:00:05 apache2 -DFOREGROUND
# ps ax -o user,pid,stat,start,time,command
USER         PID STAT  STARTED     TIME COMMAND
...
110000     64235 Ss+  11:57:10 00:00:00 apache2 -DFOREGROUND
110033     64336 S+   11:57:11 00:00:06 apache2 -DFOREGROUND
110033     64337 S+   11:57:11 00:00:04 apache2 -DFOREGROUND
110033     64338 S+   11:57:11 00:00:03 apache2 -DFOREGROUND
110033     64339 S+   11:57:11 00:00:04 apache2 -DFOREGROUND
110033     64340 S+   11:57:11 00:00:02 apache2 -DFOREGROUND
110033     64343 S+   11:57:16 00:00:03 apache2 -DFOREGROUND
110033     64359 S+   11:58:18 00:00:02 apache2 -DFOREGROUND
110033     64402 S+   12:01:07 00:00:05 apache2 -DFOREGROUND
...
```

Seeing both the `root` and `www-data` uids mapped to something with more restricted access makes me a very happy sysadmin.
