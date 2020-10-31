---
title: Switching to OSTree
author: jdieter
description: Why we're switching from CentOS 6 to an OSTree distribution
type: post
date: 2020-10-31T21:38:45+00:00
url: /posts/2020/10/31/switching-to-ostree
categories:
  - Computers
tags:
  - centos
  - ostree
---

{{<imgproc "trees" Resize "300x" />}}

At my current day job at [Spearline](https://www.spearline.com), we have call servers set up in data centers around the world.  When I started back at Spearline in January, all of these servers were running [CentOS](https://www.centos.org) 6, so one of my first tasks was to figure out a plan for upgrading the servers to something more recent.  The most obvious answer would be to set them up with CentOS 8, but we were also running into issues where different call servers might have different versions of certain packages, depending on how often they were updated.

One of the other changes we made was to move the telephony software into a container so we could have an easy split between the OS management (which is my team's responsibility) and the telephony management (which belongs to another team that we work closely with).  This change meant that we were able to look into some alternate OS solutions.

Given our shift towards containers, the most obvious solution would have been to switch to [Fedora CoreOS](https://getfedora.org/coreos), but a number of our call servers have Sangoma telephony cards with kernel drivers that are, unfortunately, out-of-tree.  While there are some elegant ways to load custom kernel modules into Fedora CoreOS, we needed a more stable kernel, due to the (lack of) speed in which these modules are updated to build with new kernels.

So we decided to go with a custom [OSTree](https://en.wikipedia.org/wiki/OSTree) distribution (surprisingly named SpearlineOS), built using `rpm-ostree` and CentOS 8.  SpearlineOS has two streams, `staging` and `production`.  At the moment, we're manually building each new release, pushing it to `staging`, running it through some smoke tests, and, then, finally, pushing it to `production`.  We are in the process of setting up a full staging environment with automatic builds and automatic promotion to production once a build has been functioning correctly for set period of time.  We've also setup [greenboot](https://github.com/fedora-iot/greenboot) in SpearlineOS so that our servers are able to fail back to an older release if the current one fails for any reason.

We are using podman for container management because we're using rootless containers pretty much everywhere.  We have had some issues with the versions of podman in CentOS, so I've been [rebuilding](https://copr.fedorainfracloud.org/coprs/jdieter/podman-el8) Fedora's podman for SpearlineOS.

SpearlineOS has served us very well for new installations, with a quick installation time (about 45 minutes including all initial configuration) and minimal maintenance problems.  In my next post, I'll discuss how we're going about upgrading our current servers from CentOS 6 to SpearlineOS.

