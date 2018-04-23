---
title: From NFS to LizardFS
author: jdieter
description: We're switching from NFS on ZFS to LizardFS for better performance
type: post
date: 2016-09-30T20:59:26+00:00
url: /posts/2016/09/30/from-nfs-to-lizardfs
categories:
  - Computers
tags:
  - centos
  - fedora
  - lesbg
  - lizardfs
  - nfs

---
If you&#8217;ve been following me for a while, you&#8217;ll know that we started our data servers out using [NFS on ext4 mirrored over DRBD][1], hit some load problems, [switched to btrfs][2], hit load problems again, tried [a hacky workaround][3], ran into problems, [dropped DRBD for glusterfs, had a major disaster, switched back to NFS on ext4 mirrored over DRBD][4], hit more load problems, and [finally dropped DRBD for ZFS][5].

As of March 2016, our network looked something like this:

{{< imgproc "201609-old-servers" Resize "500x" none >}}Old server layout{{< /imgproc >}}

Our NFS over ZFS system worked great for three years, especially after we added SSD cache and log devices to our ZFS pools, but we were starting to overload our ZFS servers and I realized that we didn&#8217;t really have any way of scaling up.

This pushed me to investigate distributed filesystems yet again. As I mentioned [here][5], distributed filesystems have been a holy grail for me, but I never found one that would work for us. Our problem is that our home directories (including config directories) are stored on our data servers, and there might be over one hundred users logged in simultaneously. Linux desktops tend to do a lot of small reads and writes to the config directories, and any latency bottlenecks tend to cascade. This leads to an unresponsive network, which then leads to students acting out the Old Testament practice of stoning the computer. GlusterFS was too slow (and [almost lost all our data][4]), CephFS still seems too experimental (especially [for the features I want][7]), and there didn&#8217;t seem to be any other reasonable alternatives&#8230; until I looked at LizardFS.

[LizardFS][8] (a completely open source fork of [MooseFS][9]) is a distributed filesystem that has one fascinating twist: All the metadata is stored in RAM. It gets written out to the hard drive regularly, but all of the metadata must fit into the RAM. The main result is that metadata lookups are rocket-fast. Add to that the ability to direct different paths (say, perhaps, config directories) to different storage types (say, perhaps, SSDs), and you have a filesystem that is scalable and fast.

LizardFS does have its drawbacks. You can run hot backups of your metadata servers, but only one will ever be the active master at any one time. If it goes down, you have to manually switch one of the replicas into master mode. LizardFS also has a very complicated upgrade procedure. First the metadata replicas must be upgraded, then the master and finally the clients. And finally, there are some [corner][10] [cases][11] where replication is not as robust as I would like it to be, but they seem to be well understood and really only seem to affect very new blocks.

So, given the potential benefits and drawbacks, we decided to run some tests. The results were instant&#8230; and impressive. A single user&#8217;s login time on a server with no load&#8230; doubled. Instead of five seconds, it took ten for them to log in. Not good. But when a whole class logged in simultaneously, it took only 15 seconds for them to all log in, down from three to five minutes. We decided that a massive speed gain in the multiple user scenario was well worth the speed sacrifice in the single-user scenario.

Another bonus is that we&#8217;ve gone from two separate data servers with two completely different filesystems (only one which ever had high load) to five data servers sharing the load while serving out one massive filesystem, giving us a system that now looks like this:

{{< imgproc "201609-new-servers" Resize "500x" none >}}New server layout{{< /imgproc >}}

So, six months on, LizardFS has served us well, and will hopefully continue to serve us for the next (few? many?) years. The main downside is that Fedora doesn&#8217;t have LizardFS in its repositories, but I&#8217;m thinking about cleaning up my spec and putting in a review request.

_Updated to add graphics of old and new server layouts, info about Fedora packaging status, LizardFS bug links, and remove some grammatical errors_

_Updated 12 April 2017_ I&#8217;ve just packaged up LizardFS to follow Fedora&#8217;s guidelines and the [review request is here][13].

 [1]: /posts/2009/10/25/i-hate-nfs/
 [2]: /posts/2010/08/25/btrfs-on-the-server/
 [3]: /posts/2011/01/10/config-caching-filesystem-ccfs/
 [4]: /posts/2012/03/31/glusterfs-madness/
 [5]: /posts/2012/09/12/under-the-hood/
 [7]: http://docs.ceph.com/docs/master/cephfs/experimental-features/
 [8]: https://lizardfs.com/
 [9]: http://moosefs.org/
 [10]: https://github.com/lizardfs/lizardfs/issues/252
 [11]: https://github.com/lizardfs/lizardfs/issues/227
 [13]: https://bugzilla.redhat.com/show_bug.cgi?id=1441729
