---
title: F11 Catalyst vs. F12 mesa-drivers-experimental
author: jdieter
type: post
date: 2010-02-19T06:50:52+00:00
url: /posts/2010/02/19/f11-catalyst-vs-f12-mesa-drivers-experimental
categories:
  - Computers
tags:
  - amd
  - ati
  - catalyst
  - fedora
  - linux
  - radeon
  - xbmc

---
Last May I bought an ATI Radeon HD4830 video card for my music/gaming system. I would have gone with nVidia, but my last laptop had an nVidia graphics driver and I got quite frustrated with trying to keep the binary drivers up-to-date on it (even using RPM Fusion, I would run into odd problems every now and then).

I wanted a card that would have open drivers. Now, I knew when I bought the 4830 that it wasn&#8217;t supported by the open radeon driver, but I also knew it would be ready soon, and I figured I could use the closed drivers until then.

And that&#8217;s when I found out that ATI&#8217;s closed-source binary Catalyst driver is so poorly maintained, it makes Windows 95 look up-to-date. It took several months for AMD/ATI to put out a Catalyst driver that would support Fedora 11, and they still haven&#8217;t put out a Catalyst driver that supports Fedora 12.

The driver also is extremely buggy. Any release after 9.8 wouldn&#8217;t work with my original motherboard (see [this bug][1]), and after upgrading to a new Intel motherboard and processor a couple of weeks ago, I had random crashes that ranged from once every couple of days to once every fifteen minutes.

If I could ssh into the computer (which was only about half of the time), I&#8217;d see some message about an &#8220;ASIC hang&#8221;. Googling it didn&#8217;t give much information. I originally thought it had something to do with the power supply, but even a brand name power supply didn&#8217;t fix the problem.

Yesterday, I finally had enough. I wiped the hard drive and did a clean install of Fedora 12. Yeah, Catalyst won&#8217;t work, but I&#8217;d been hearing good things about mesa-drivers-experimental, so I decided to give it a go.

So, first the down side to switching:

  * **Nexuiz runs much slower.** With the binary drivers, I was able to run the game at 1920&#215;1080 ultimate quality at 50-60 fps. With the experimental driver, it&#8217;s down to 3-4 fps (though medium quality works great at 50-60 fps).
  * **XBMC ProjectM visualizations are slow.** Again, with the binary drivers, the ProjectM visualizations ran at full speed, while with the experimental drivers, they run at 5-6 fps.

But, the good news is:

  * **I can play my 3D games just fine.** Even though I can&#8217;t run them at full quality, I can still play my games.
  * **XBMC movies run at full speed.** Even with the cool effects that XBMC uses for its controls, movies work perfectly.
  * **XBMC slideshows work fine, with panning and zooming.** The slideshow work the way they are supposed to with no delays at all. In fact, I may be imagining it, but I think there was the occasional slight delay in catalyst that _isn&#8217;t_ there now
  * **THE SYSTEM DOESN&#8217;T HANG/CRASH.** I haven&#8217;t had a single system hang since switching. And that is worth far more to me than the best Nexuiz framerate ever.

Using the open experimental drivers brings me back to the reason I bought ATI in the first place, and I can finally say that I&#8217;m glad I bought ATI. Binary drivers are a pain to keep up with, and I&#8217;m so glad I don&#8217;t have to deal with that any more. I&#8217;m hoping to see things running even better in Fedora 13.

_Update_: The story [continues here][2].

 [1]: http://bugzilla.rpmfusion.org/show_bug.cgi?id=900
 [2]: /posts/2010/12/30/catalyst-vs-mesa-round-2
