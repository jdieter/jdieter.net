---
title: Catalyst vs. Mesa (round 2)
author: jdieter
description: More problems with AMD's binary Catalyst drivers and the open source Mesa drivers
type: post
date: 2010-12-30T16:10:31+00:00
url: /posts/2010/12/30/catalyst-vs-mesa-round-2
categories:
  - Computers
tags:
  - amd
  - ati
  - catalyst
  - fedora
  - fedora 14
  - gallium 3d
  - xbmc

---
{{< imgproc "boxing_at_the_2000_olympic_games-cropped-small" Resize "300x" />}}

In February, [I wrote about my frustration][2] with AMD&#8217;s binary Catalyst drivers and my switch to the free Mesa drivers for my media/gaming system. During the summer, I updated to Fedora 13 and continued to enjoy the reliability of free drivers.

Then, a problem. Sometime in September, some of the rendering in [XBMC][3] started to be corrupted. Movies played fine and the picture slideshow continued to work correctly, but any controls rendered on top of the Movie or slideshow seemed to be missing the background texture and instead rendered as a very light grey. With white text rendered on top of it, it made the controls pretty unreadable.

Upgrading mesa didn&#8217;t work. Neither did upgrading the kernel or XBMC. And a full upgrade to Fedora 14 didn&#8217;t help either. Given the insanity of getting everything else up and running at the beginning of the school year, this was the point that I stopped. After all, our main use of the system is to watch movies or the pictures slideshow, and, though annoying, the bug wasn&#8217;t a show stopper.

With some of the free time we had for Christmas, I decided to try to tackle the bug. I figured the easiest way would be to go back to the Catalyst drivers and see if the rendering was still screwed up. Sure enough, the Catalyst drivers fixed the rendering. I then tried to open Nexuiz full-screen over XBMC. The display froze. One reboot later I tried again. And the display froze again.

After several hours of trying different kernel and xorg.conf options, I was ready to put the computer in the middle of the Damascus highway during rush-hour traffic.

Then I had an epiphany. In Fedora 15, the r600 driver will switch from the standard Mesa driver to the new Gallium3D driver. So I installed fedora-release-rawhide and then did a:

```
yum update mesa-* libdrm-* xorg-x11-* gdm-*
```

One reboot later and XBMC is rendered correctly in all of its glory, all of my games run correctly over it, and I still don&#8217;t have to worry about keeping Catalyst up to date.

Closed drivers: 0
  
Open drivers: 2

_Note:_ Some may wonder why I updated gdm. For some reason, the old version interacts with X in such a way that X crashes and I&#8217;m left with the boot screen and can only ssh into the system. It seems to be somewhat related to [this bug][4], and updating gdm fixes it.

 [2]: /posts/2010/02/19/f11-catalyst-vs-f12-mesa-drivers-experimental
 [3]: http://xbmc.org
 [4]: https://bugzilla.redhat.com/show_bug.cgi?id=577896
