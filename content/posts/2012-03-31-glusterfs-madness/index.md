---
title: GlusterFS Madness
author: jdieter
description: Lessons learned from an attempt to switch from DRBD+btrfs to GlusterFS
type: post
date: 2012-03-31T11:49:12+00:00
url: /posts/2012/03/31/glusterfs-madness
categories:
  - Computers
tags:
  - btrfs
  - drbd
  - ext4
  - glusterfs
  - linux
  - ssd

---
{{< imgproc "nuclear_explosion" Resize "300x" />}}

**Background**
  
As mentioned in [Btrfs on the server][2], we have been using btrfs as our primary filesystem for our servers for the last year and a half or so, and, for the most part, it&#8217;s been great. There have only been a few times that we&#8217;ve needed the snapshots that btrfs gives us for free, but when we did, we _really_ needed them.

At the end of the last school year, we had a bit of a problem with the servers and came close to losing most of our shared data, despite using [DRBD][3] as a network mirror. In response to that, we set up a backup server which has the sole job of rsyncing the data from our primary servers nightly. The backup server is also using btrfs and doing nightly snapshots, so one of the major use-cases behind putting btrfs on our file servers has become redundant.

The one major problem we&#8217;ve had with our file servers is that, as the number of systems on the network has increased, our user data server can&#8217;t handle the load. The [configuration caching filesystem (CCFS)][4] I wrote has helped, but even with CCFS, our server was regularly hitting a load of 10 during breaks and occasionally getting as high as 20.

**Switching to GlusterFS**
  
With all this in mind, I decided to do some experimenting with [GlusterFS][5]. While we may have had high load on user data server, our local mirror and shared data servers both had consistently low loads, and I was hoping that GlusterFS would help me spread the load between the three servers.

The initial testing was very promising. When using GlusterFS over ext4 partitions using SSD journaling on just one server, the speed was just a bit below NFS over btrfs over DRBD. Given the distributed nature of GlusterFS, adding more servers should increase the speed linearly.

So I went ahead and broke the DRBD mirroring for our eight 2TB drives and used the four secondary DRBD drives to set up a production GlusterFS volume. Our data was migrated over, and we used GlusterFS for a week without any problems. Last Friday, we declared the transition to GlusterFS a success, wiped the four remaining DRBD drives, and added them to the GlusterFS volume.

I started the rebalance process for our GlusterFS volume Friday after school, and it continued to rebalance over the weekend and through Monday. On Monday night, one of the servers crashed. I went over to the school to power cycle the server, and, when it came back up, continued the rebalance.

**Disaster!**
  
Tuesday morning, when I checked on the server, I realized that, as a result of the crash, the rebalance wasn&#8217;t working the way it should. Files were being removed from the original drives but not being moved to the new drives, so we were losing files all over the place.

After an emergency meeting with the principal (who used to be the school&#8217;s sysadmin before becoming principal), we decided do ditch GlusterFS and go back to NFS over ext4 over DRBD. We copied over the files from the GlusterFS partitions, and then filled in the gaps from our backup server. Twenty-four sleepless hours later, the user data was back up and the shared data was up twenty-four sleepless hours after that.

**Lessons learned**

  1. _Keep good backups._ Our backups allowed us to restore almost all of the files that the GlusterFS rebalance had deleted. The only files lost were the ones created on Monday.
  2. _Be conservative about what you put into production._ I&#8217;m really not good at this. I like to try new things and to experiment with new ideas. The problem is that I can sometimes put things into production without enough testing, and this is one result.
  3. _Have a fallback plan._ In this case, our fallback was to wipe the server and restore all the data from the backup. It didn&#8217;t quite come to that as we were able to recover most of the data off of GlusterFS, but we did have a plan if it did.
  4. _Avoid GlusterFS._ Okay, maybe this isn&#8217;t what I should have learned, but I&#8217;ve already had one bad experience with GlusterFS a couple of years ago where its performance just wasn&#8217;t up to scratch. For software that&#8217;s supposedly at a 3.x.x release, it still seems very beta-quality.

The irony of this whole experience is that by switching the server filesystems from btrfs to ext4 with SSD journals, the load on our user data server has dropped to below 1.0. If I&#8217;d just made that switch, I could have avoided two days of downtime and a few sleepless nights.

_Nuclear explosion credit &#8211; [Licorne][6] by [Pierre J.][7] Used under the [CC-BY-NC 2.0][8] license._

 [2]: /posts/2010/08/25/btrfs-on-the-server
 [3]: http://www.drbd.org
 [4]: /posts/2011/01/10/config-caching-filesystem-ccfs
 [5]: http://www.gluster.org/
 [6]: https://secure.flickr.com/photos/7969902@N07/510672745
 [7]: https://secure.flickr.com/photos/7969902@N07/
 [8]: http://creativecommons.org/licenses/by-nc-sa/2.0/
