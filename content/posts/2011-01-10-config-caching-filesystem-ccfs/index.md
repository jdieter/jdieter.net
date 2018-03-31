---
title: Config Caching Filesystem (ccfs)
author: jdieter
type: post
date: 2011-01-10T19:19:18+00:00
url: /?p=303
categories:
  - Computers
tags:
  - btrfs
  - ccfs
  - fedora
  - lesbg
  - linux
  - nfs

---
<figure id="attachment_304" style="max-width: 197px" class="wp-caption alignright">[<img src="http://cedarandthistle.files.wordpress.com/2011/01/jetpack.jpg?w=197" alt="Man with Jetpack" title="Jetpack" width="197" height="300" class="size-medium wp-image-304" srcset="/images/2011/01/jetpack.jpg 432w, /images/2011/01/jetpack-197x300.jpg 197w" sizes="(max-width: 197px) 100vw, 197px" />][1]<figcaption class="wp-caption-text"> </figcaption></figure> 

One of the problems we&#8217;ve had to deal with on our [servers][2] is high load on the fileserver that holds the user directories. I haven&#8217;t worked out if it&#8217;s because we&#8217;re using standard workstation hardware for our servers, or if it&#8217;s a btrfs problem.

The strange thing is that the load will shoot up at random times when the network shouldn&#8217;t be that taxed, and then be fine when every computer in the school has someone logged into it.

Anyhow, we hit a point where the load on the server hit something like 60 and the workstations would lock for sixty seconds (or more) while waiting the the NFS server to respond again. This seemed to happen most often when all of the students in the computer room opened Firefox at the same time.

In a fit of desperation, I threw together a python fuse filesystem that I have cunningly called the Config Caching Filesystem (or ccfs for short). The concept is simple. A user&#8217;s home directory at `/netshare/users/[username]` is essentially bind-mounted to `/home/[username]` using ccfs.

The thing that separates ccfs from a simple fuse bind-mount is that every time a configuration file (one that starts with a &#8220;.&#8221;) is opened for writing, it is copied to a per-user cache directory in `/tmp` and opened for writing there. When the user logs out, `/home/[username]` is unmounted, and all of the files in the cache are copied back to `/netshare/users/[username]` using rsync. Any normal files are written directly to `/netshare/users/[username]`, bypassing the cache.

Now the only time the server is being written to is when someone actually saves a file or when they log out. The load on the server rarely goes above five, and even then it&#8217;s only when everyone is logging out simultaneously, and the server recovers quickly.

A few bugs have cropped up, but I think I&#8217;ve got the main ones. The biggest bug was that some students were resetting their desktops when the system didn&#8217;t log out quickly enough and were getting corrupted configuration directories, mainly for Firefox. I fixed that by using &#8211;delay-updates with rsync so you either get the fully updated configuration files or you&#8217;re left with the configuration files were there when you logged in.

I do think this solution is a bit hacky, but it&#8217;s had a great effect on the responsiveness of our workstations, so I&#8217;ll just have to live with it.

Ccfs is available [here][3] for those interested, but if it breaks, you get to keep both pieces.

_Jetpack credit: [Fly with U.S. poster][4] by [Tom Whalen][5]. Used under [CC BY-NC-ND][6]_

 [1]: http://cedarandthistle.files.wordpress.com/2011/01/jetpack.jpg
 [2]: /2010/08/25/btrfs-on-the-server/
 [3]: http://koji.lesbg.com/koji/packageinfo?packageID=46
 [4]: http://www.behance.net/Gallery/fly-with-U_S_-poster/331768
 [5]: http://www.behance.net/strongstuff
 [6]: http://creativecommons.org/licenses/by-nc-nd/3.0/