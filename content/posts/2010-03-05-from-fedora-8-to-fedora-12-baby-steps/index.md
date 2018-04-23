---
title: From Fedora 8 to Fedora 12… baby steps
author: jdieter
description: I updated from Fedora 8 to Fedora 12 on a system that only provided me with SSH access
type: post
date: 2010-03-05T18:35:40+00:00
url: /posts/2010/03/05/from-fedora-8-to-fedora-12-baby-steps
categories:
  - Computers
tags:
  - fedora

---
{{< imgproc "juggler" Resize "200x" />}}

Yesterday, I realized that I hadn&#8217;t upgraded the server that runs <http://lesloueizeh.com> for a _long_ time. It was still running Fedora 8, which has obviously been without updates for a while. So in between my other work today, I did a step-by-step upgrade from Fedora 8 to Fedora 12.

The problem is that the server is located in the States somewhere, I&#8217;m located in Beirut, and the only access I have to it is via ssh. If I screw something up badly enough that the server won&#8217;t boot, I can&#8217;t just go to runlevel 1 to fix it.

[This page][2] was a great help! It took a number of hours (mainly because of delays on my side), but I finally got there this afternoon. Yay for Yum upgrades!

**Fire juggler credit: [Fire juggling][3] by [Felixe][4] under [CC BY-SA 2.0][5]**

 [2]: http://fedoraproject.org/wiki/YumUpgradeFaq
 [3]: http://www.flickr.com/photos/44136594@N00/874736642
 [4]: http://www.flickr.com/photos/loauc/
 [5]: http://creativecommons.org/licenses/by-sa/2.0/deed.en
