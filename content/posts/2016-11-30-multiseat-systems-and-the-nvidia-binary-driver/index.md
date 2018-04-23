---
title: Multiseat systems and the NVIDIA binary driver
author: jdieter
description: How libglvnd allows us to setup multiseat systems with a mixture of open and proprietary drivers
type: post
date: 2016-11-30T19:37:15+00:00
url: /posts/2016/11/30/multiseat-systems-and-the-nvidia-binary-driver
categories:
  - Computers
tags:
  - amd
  - ati
  - blender
  - fedora
  - gallium
  - intel
  - libglvnd
  - linux
  - mesa
  - multiseat
  - nvidia

---
{{< imgproc "screenshot-from-2016-11-30-21-24-39" Resize "300x" >}}Building mesa{{< /imgproc >}}

Ever since our school switched to Fedora on the desktop, I&#8217;ve either used the onboard Intel graphics or AMD Radeon cards, since both are supported out of the box in Fedora. With our multiseat systems, we now need three external video cards on top of the onboard graphics on each system, so we&#8217;ve bought a large number of Radeon cards over the last few years.

Unfortunately, our [local supplier][2] has greatly reduced the number of AMD cards that they stock. In their latest price lists, they have a grand total of two Radeon cards in our price range, and one of them is [almost seven years old][3]!

This has led me to take a second look at NVIDIA cards, and I&#8217;m slowly coming back around to the concept of buying them and _maybe_ even using their binary drivers. Our needs have changed since we first started using Linux, and NVIDIA&#8217;s binary driver does offer some unique benefits.

As we&#8217;ve started teaching 3D modeling using Blender, render time has become a real bottleneck for some of our students. We allow students to use the computers before and after school, but some of them don&#8217;t have much flexibility in their transportation and need to get their rendering done during the school breaks. Having two or three students all trying to render at the same time on a single multiseat system can lead to a sluggish system and very slow rendering. The easiest way to fix this is to do the rendering in the GPU, which Blender does support, but only using NVIDIA&#8217;s binary driver.

So about a month ago, I ordered [a cheap NVIDIA card][4] for testing purposes. I swapped it with an AMD card on one of our multiseat systems and powered it up. Fedora recognized the card using the open-source nouveau driver and everything just worked. Beautiful!

Then, a few hours later, I noticed the system had frozen. I rebooted it, and, after a few hours, it had frozen again. I moved the NVIDIA card into a different system, and, after a few hours, it froze while the original system just kept running.

Some [research][5] showed that the nouveau driver sometimes has issues with multiple video cards on the same system. There was [some talk][6] about extracting the binary driver&#8217;s firmware and using it in nouveau, but I decided to see if I could get the binary driver working without breaking our other Intel and AMD seats.

The first thing I did was upgrade the test system to Fedora 25 in hopes of taking advantage of the [work done to make mesa and the NVIDIA binary driver coexist][7]. I then installed the binary NVIDIA drivers from [this repository][8] (mainly because his version of blender already has the CUDA kernels compiled in). The NVIDIA seat came up just fine, but I quickly found that mesa in Fedora 25 isn&#8217;t built with libglvnd (a shim between either the mesa or NVIDIA OpenGL implementation, depending on which card you&#8217;re using and your applications) enabled, so all of the seats based on open drivers didn&#8217;t come up. But, even when it was enabled, I ran into [this bug][9], so I ended up extending [this patch][10] so it would also work with Gallium drivers and applying it.

This took me several steps closer, but apparently the X11 GLX module is not part of libglvnd and NVIDIA sets the Files section in xorg.conf to use it&#8217;s own GLX module (which, oddly enough, doesn&#8217;t work with the open drivers). I finally worked around this via the ugly hack of creating two different xorg.conf.d directories and telling lightdm to use the NVIDIA one when loading the NVIDIA seat.

Voilà! We now have a multiseat system with one Intel built-in card using the mesa driver, two AMD cards using the mesa Gallium driver, and one NVIDIA card using the NVIDIA binary driver. And it only cost me eight hours and my sanity.

So what needs to happen to make this Just Work™? Either libglvnd needs to also include the X11 GLX module or we need a different shim to accomplish the same thing. And Fedora needs to build mesa with libglvnd enabled (but not until this bug is fixed!)

My [mesa build][11] is here and the [source rpm][12] is here. There is a manual &#8220;Provides: libGL.so.1()(64bit)&#8221; in there that isn&#8217;t technically correct, but I really didn&#8217;t want to recompile negativo17&#8217;s libglvnd to add it in and my mesa build requires that libglvnd implementation.

My [xorg configs][13] are here and my [lightdm configuration][14] is here. Please note that the xorg configs have my specific PCI paths; yours may differ.

And I do plan to write a script to automate the xorg and lightdm configs. I&#8217;ll update this post when I&#8217;ve done so.

_Sidenote:_ As I was looking through my old posts to see if I had anything on NVIDIA, I came across a comment by Seth Vidal. He was an excellent example of what the Fedora community is all about, and I really miss him.

**_Update:_ Configuration has become much simpler. An [updated post is here][15]**.

 [2]: http://pcandparts.com/price.htm
 [3]: https://en.wikipedia.org/wiki/Radeon_HD_5000_Series#Radeon_HD_5400
 [4]: https://www.zotac.com/us/product/graphics_card/gt-730-2gb-zone-edition
 [5]: https://itfknworks.wordpress.com/2015/06/21/ubuntu-dual-seat-setup/
 [6]: https://bugs.freedesktop.org/show_bug.cgi?id=72180#c5
 [7]: https://blogs.gnome.org/uraeus/2016/11/01/discrete-graphics-and-fedora-workstation-25/
 [8]: http://negativo17.org/repos/multimedia/fedora-25/
 [9]: https://bugs.freedesktop.org/show_bug.cgi?id=98428
 [10]: https://bugs.freedesktop.org/attachment.cgi?id=127532
 [11]: http://lesloueizeh.com/jdieter/mesa-x86_64/
 [12]: http://lesloueizeh.com/jdieter/mesa-12.0.4-3.fc25.src.rpm
 [13]: http://lesloueizeh.com/jdieter/xorg-configs/
 [14]: http://lesloueizeh.com/jdieter/lightdm.conf
 [15]: /posts/2016/12/31/multiseat-systems-and-the-nvidia-binary-driver-update/
