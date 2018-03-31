---
title: Slipping over the edge
author: jdieter
type: post
date: 2011-03-29T18:48:22+00:00
url: /?p=327
categories:
  - Computers
tags:
  - btrfs
  - fedora
  - fedora 15
  - luks

---
<figure id="attachment_329" style="max-width: 300px" class="wp-caption alignright">[<img class="size-medium wp-image-329" title="Cliff" src="http://cedarandthistle.files.wordpress.com/2011/03/cliff1.jpg?w=300" alt="Man on edge of cliff" width="300" height="199" srcset="/images/2011/03/cliff1.jpg 640w, /images/2011/03/cliff1-300x200.jpg 300w" sizes="(max-width: 300px) 100vw, 300px" />][1]<figcaption class="wp-caption-text"> </figcaption></figure> 

On a Sunday a few weeks ago, I finally decided to take the plunge and install the Fedora 15 Alpha on my primary workstation. I&#8217;ve been using GNOME Shell pretty much exclusively since Fedora 13, and I was looking forward to an even cleaner setup as it got closer to its first official release. The installation went smoothly, and, soon enough, I had the new interface up and running, and, I have to say, it&#8217;s looking great!

Just a quick aside to say that I really appreciate where GNOME Shell is going. I love the favorite apps/running apps on the left, desktops on the right concept. I do miss having persistent desktops (Firefox is always alone in the first desktop, and it&#8217;s a bit of a pain to get it back there when I restart Firefox). It&#8217;s also much harder to get to my files since the recent documents list on the left has gone. But though it&#8217;s taken some getting used to, the notifications menu on the bottom has ended up being really nice.

Anyhow, on Monday after the installation, I brought my laptop to my office in the morning, booted it up, and then went off to teach my first two classes. When I returned to my office, my screen had a nice kernel panic on it saying something about sda write errors, unable to write to disk, the end of the world, etc.

Being the incredibly sophisticated hacker (read &#8220;complete idiot&#8221;) that I am, I proceeded to do a hard reboot of the laptop without taking a picture of the screen. Oops. Then, on the reboot, the system ran into a small problem. It wasn&#8217;t able to mount any of my filesystems. A quick reboot into my livecd and one e2fsck later, and my system partition was back up again (apparently with no major errors). Unfortunately, that wasn&#8217;t the end of the story.

I should probably take this opportunity to explain my incredibly cunning partition setup here. You see, I have a boot partition, two 20GB system partitions that I switch between every time I update my system, and a swap partition. I then have a 400+GB encrypted home partition, a btrfs encrypted home partition, created back in the F13 days. This home partition contains all of my data. In the world. Everything.

So I booted from my now repaired system partition and&#8230; my home partition refused to mount. It said the filesystem was unrecognizable. Oookay. How about a btrfsck /dev/sda5. &#8220;No valid Btrfs on /dev/sda5.&#8221; That can&#8217;t be good. Ok, I&#8217;m a system administrator, I should have a good backup somewhere. Check around, and there it is, dated&#8230; May 8, 2010. Well, that sucks.

This was the point where I started to get slightly worried. I hopped onto the #btrfs IRC channel on freenode and that&#8217;s where my bacon was saved. Apparently whatever caused the kernel panic also caused some major problems when btrfs was writing its metadata. Unfortunately, since I had no record of the panic except my spotty memory, we weren&#8217;t able to track down the cause. All we knew was that the primary superblock had been corrupted, and that was why none of the tools could read it.

At this point, Chris Mason (the creator of btrfs) walked me through compiling btrfs-progs from the &#8220;next&#8221; branch in [git][2], and then compiling [btrfs-select-super][3] (which isn&#8217;t built using the normal Makefile). I used btrfs-select-super to switch to the second superblock, and _voilà_, I was able to mount the filesystem (read-only, of course)! Some of the metadata was pointing to junk, and I ended up losing all my files that had been changed in the last few days, but most of them were emails, which I _did_ have backed up elsewhere.

I still don&#8217;t know what caused the problem. There were some SMART errors on the drive, but repeated extended offline scans found no errors, and manually overwriting the entire partition using dd and then reading it found nothing amiss. There was some talk of it possibly being related to luks, but no evidence pointing in that direction.

So, now I&#8217;m running Fedora 15 Alpha, with a newly created encrypted btrfs filesystem as my home partition&#8230; and daily backups. A huge thank you to Chris and the others on #btrfs on freenode who gave me such great help!

_Steep cliff credit: [Steep cliff][4] by [Rob Lee][5]. Used under [CC BY-ND][6]_

 [1]: http://cedarandthistle.files.wordpress.com/2011/03/cliff1.jpg
 [2]: https://btrfs.wiki.kernel.org/index.php/Btrfs_source_repositories#btrfs-progs_Git_Repository
 [3]: http://git.kernel.org/?p=linux/kernel/git/mason/btrfs-progs-unstable.git;a=blob;f=btrfs-select-super.c;h=f12f36ce29f5060ebcfc9ae5268f70ea85ee7e5b;hb=refs/heads/next
 [4]: http://www.flickr.com/photos/roblee/7093383/
 [5]: http://www.flickr.com/photos/roblee/
 [6]: http://creativecommons.org/licenses/by-nd/2.0/deed.en