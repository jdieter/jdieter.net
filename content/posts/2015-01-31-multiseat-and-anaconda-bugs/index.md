---
title: Multiseat and anaconda bugs
author: jdieter
description: Multiple bugs when dealing with multiseat systems in Fedora 21
type: post
date: 2015-01-31T21:43:31+00:00
url: /posts/2015/01/31/multiseat-and-anaconda-bugs
categories:
  - Computers
tags:
  - anaconda
  - fedora
  - fedora 21
  - lesbg
  - lightdm
  - multiseat
  - xorg

---
{{< imgproc "sam_1692" Resize "300x" >}}Those look like storm clouds&#8230;{{< /imgproc >}}

A year ago, I put together [a post][2] about the multiseat Fedora systems we&#8217;re using in our school. Over the past month, I&#8217;ve been putting together an upgrade from our Fedora 19 image to Fedora 21.

While doing the upgrade, I ran into a few bugs, and the first one was a doozy! Roughly half the time our multiseat systems started, the login screen would only show on two or three of the four seats. The only way to fix it was to restart the display manager, and even that only had a 50% chance of success.

At first I tried bodging around the bug by staggering the timing of Xorg&#8217;s startup, but that only made things worse. So I started looking at the logs and then looking at the Xorg code. It became obvious that the problem was that the first seat (seat0) would try to claim all the GPUs on the system. If it beat the other seats to their GPUs, they would, oddly enough, refuse to start. I put together [a patch][3], filed [a bug][4], and watched as those who know a lot more about Xorg&#8217;s internals take my ugly patch and make it beautiful. [This patch][5] has been merged into Xorg 1.17 and I&#8217;m hoping we&#8217;ll get it backported for F20 and F21 as I really don&#8217;t want to have to maintain internal Xorg packages until we switch to F22.

There do seem to be a couple of other bugs related to lightdm/xorg, but they&#8217;re far rarer and I haven&#8217;t spent much time on tracking them down, much less filing bugs. Occasionally lightdm starts the X server, but never gets a signal back saying that it&#8217;s ready, so they both sit there waiting for the other process. And far more rarely, the greeter crashes, which causes lightdm to shut down the seat. I think lightdm should retry a few times, but either it doesn&#8217;t or I haven&#8217;t found the right config option yet.

We did run into one interesting race condition in anaconda when we started mass-installing F21 on our systems. We use iPXE and Fedora&#8217;s PXE network install images with a custom kickstart to do the install (in graphical mode, because pretty installs make it less likely that a student will press the reset button while the install is progressing). On some systems, I&#8217;d get an error message that basically said that a repository that was supposed to be enabled had disappeared, which would crash anaconda.

Thanks to anaconda&#8217;s wonderful debugging tools, I was able to work out what list was being emptied and finally tracked it down to a race between the backend filling the frontend with its list of repositories and the frontend telling the backend to remove any repositories that aren&#8217;t in its list of repositories. Another [ugly patch][6] attached to [the bug report][7], and we&#8217;ll see what happens with this one. At least I&#8217;m able to rebuild the squashfs installer image so the bug is fixed for us internally.

So most of our computers have now been upgraded to Fedora 21 and the reaction from our students has been positive. Now to get some Fedora 22 test systems built&#8230;

 [2]: /posts/2013/12/02/setting-up-a-multiseat-system/
 [3]: https://bugzilla.redhat.com/attachment.cgi?id=981504
 [4]: https://bugzilla.redhat.com/show_bug.cgi?id=1183654
 [5]: http://lists.x.org/archives/xorg-devel/2015-January/045485.html
 [6]: https://bugzilla.redhat.com/attachment.cgi?id=985017
 [7]: https://bugzilla.redhat.com/show_bug.cgi?id=1185793
