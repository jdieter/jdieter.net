---
title: Odds and ends
author: jdieter
description: A collection of short notes about FOSDEM, OpenWRT, LizardFS and history
type: post
date: 2017-03-31T18:25:15+00:00
url: /posts/2017/03/31/odds-and-ends
categories:
  - Computers
tags:
  - fosdem
  - history
  - kernel
  - linux
  - lizardfs
  - nahr el kalb
  - openwrt
  - tp-link
  - usbip

---
{{< imgproc "nahrelkalb" Resize "300x" />}}

Since I last posted, there have been a number of small updates, but nothing that seemed big enough to write about. So I figured it might be worth posting a short summary of what I&#8217;ve been up to over the last couple of months.

In no particular order:

**FOSDEM**
  
I had the opportunity to visit [FOSDEM][2] for the first time last month. Saw lots of cool things, met lots of cool people and even managed to bag a LibreOffice hoodie. Most importantly, it was a chance to build friendships, which have a far higher value than any code ever will.

**Wireless access points**
  
I should probably write a proper post about this sometime, but a number of years ago we bought about 30 [TP-LINK WR741ND][3] wireless APs and slapped a custom build of OpenWRT on them. We installed the last spare a couple of months ago and ran into problems finding a decent replacement (specific hardware revisions can be quite difficult to find in Lebanon). After much searching, we managed to get ahold of a [TP-LINK WR1043ND][4] for testing and our OpenWRT build works great on it. Even better, it has a four-port gigabit switch which will give us much better performance than the old 100Mbps ones.

**LizardFS patches**
  
I ran into a couple of performance issues that I wrote some patches to fix. [One][5] is in the process of being accepted upsteam, while [the other][6] has been deemed too invasive, given that upstream would like to deal with the problem in a different way. For the moment, I&#8217;m using both on the school system, and they&#8217;re working great.

**Kernel patch (tools count, right?)**
  
After the F26 mass rebuild, I ran into problems building the [USB/IP][7] userspace tools with GCC 7. Fixing the bugs was relatively simple, and, since the userspace tools are part of the kernel git repository, I got to submit my [first][8] [patches][9] to the [LKML][10]. The difference between a working kernel patch and a good kernel patch can be compared to the difference between a Volkswagen Beetle and the Starship Enterprise. I really enjoyed the iterative process, and, after four releases, we finally had something good enough to go into the kernel. A huge thank you goes out to Peter Senna, who looked over my code before I posted it and made sure I didn&#8217;t completely embarrass myself. (Peter&#8217;s just a great guy anyway. If you ever get the chance to buy him a drink, definitely do so.)

**Ancient history**
  
As of about three weeks ago, I am teaching history. Long story as to how it happened, but I&#8217;m enjoying a few extra hours per week with my students, and history, especially ancient history, is a subject that I love. To top it off, there aren&#8217;t many places in the world where you can take your students on a field trip to visit the things you&#8217;re studying. On Wednesday, we did a trip to Nahr el-Kalb (the Dog River) where [there are stone monuments][11] erected by the ancient Assyrian, Egyptian, and Babylonian kings among others. I love Lebanon.

 [2]: https://fosdem.org/2017/
 [3]: http://www.tp-link.com.au/products/details/TL-WR741ND.html
 [4]: http://www.tp-link.com.au/products/details/cat-9_TL-WR1043ND.html
 [5]: https://github.com/lizardfs/lizardfs/pull/523
 [6]: https://github.com/lizardfs/lizardfs/pull/525
 [7]: https://github.com/torvalds/linux/tree/master/tools/usb/usbip
 [8]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=e5dfa3f902b9a642ae8c6997d57d7c41e384a90b
 [9]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=cfd6ed4537a9e938fa76facecd4b9cd65b6d1563
 [10]: https://lkml.org/
 [11]: https://en.wikipedia.org/wiki/Commemorative_stelae_of_Nahr_el-Kalb
