---
title: Solving the mystery of the disappearing bluetooth device
author: jdieter
description: When the bluetooth module is put into low-power mode, bad things happen
type: post
date: 2015-08-23T22:00:20+00:00
url: /posts/2015/08/24/solving-the-mystery-of-the-disappearing-bluetooth-device
categories:
  - Computers
tags:
  - atheros
  - bluetooth
  - fedora
  - laptop
  - power saving
  - powertop
  - ralink
  - wifi

---
{{< imgproc "wifi" Resize "300x" >}}This is a true<a href="#footnote">[1]</a> story{{< /imgproc >}}

One of the features my laptop comes with is Bluetooth, which I&#8217;ve found to be quite handy considering all the highly important uses I have for Bluetooth (using Bluetooth tethering on my phone when traveling, controlling my presentations with my phone, using a <del datetime="2015-08-23T19:38:45+00:00">Wii-mote for playing SuperTuxKart</del> portable Bluetooth controller with built-in accelerometer to analyze the consistency of the matrices used when rendering three-dimensional objects onto a two-dimensional field).

About three months ago, I started to run into problems. Not the easy kind of problem where &#8220;`BUG: unable to handle kernel paging request at 0000ffffd15ea5e`&#8221; brings the laptop to an abrupt stop, but instead the kind of problem that causes real trouble.

My Bluetooth module starts to randomly reset itself. I&#8217;ll be working merrily, trying to connect my phone or the&#8230; portable Bluetooth controller&#8230; and, halfway through the process, it will hang. Kernel logs show that the Bluetooth module has been unplugged from the USB bus and then reconnected. Which, when you think about it, makes a whole lot of sense, given that the Bluetooth module is **built into the WiFi card** which is **screwed onto the motherboard**.

When faced with kernel logs that boggle the mind, the most logical thing to do is downgrade the kernel. I know that I was able to successfully&#8230; analyze the matrices used for, oh, whatever it was&#8230; back at the beginning of June, which means I had working Bluetooth on June 1. Let&#8217;s see what kernel was latest then, download and install it, boot from it, and&#8230;

```
kernel: usb 8-4: USB disconnect, device number 3
kernel: usb 8-4: new full-speed USB device number 4 using ohci-pci
```

#$@&%*!

Ok, the hardware must be dying.  Stupid Atheros card.  No idea why it&#8217;s just the Bluetooth and not the WiFi as well, but we&#8217;re in Ireland and I&#8217;m on eBay, so I&#8217;ll just order another one.  Made by a different company.  A week later, a slightly used Ralink combo card shows up. I plug it in, fire her up, and&#8230;

```
kernel: usb 8-4: USB disconnect, device number 3
kernel: ohci-pci 0000:00:13.0: HC died; cleaning up
kernel: ohci-pci 0000:00:13.0: frame counter not updating; disabled
```

Double #$@&%*! Now the Bluetooth module is completely gone and the only way to get it back is to reboot. _Grrrrr._

At this point I&#8217;ve got a hammer in my hand, my laptop in front of me, and the only thing keeping me from [submitting a video for a new OnePlus One][3] is my wife warning me that we&#8217;re _not_ going to be buying me a new laptop any time this decade.

So I take a deep breath, calmly return the hammer to the toolbox (no, dear, I have no idea how that dent got on the toolbox), and decide to instead go down the road less traveled. I open up Fedora&#8217;s bugzilla and start preparing my bug report, taking special care to only use words that I&#8217;d be willing to say in front of my children. &#8220;&#8230;so the Bluetooth module keeps getting disconnected. It&#8217;s almost like the USB bus is cutting its power for some stupid&#8230;&#8221;

Wait a minute! Just before we traveled to Ireland, I remember experimenting with [PowerTOP][4]. And PowerTOP has this cool feature that allows you to automatically [enable all power saving options on boot][5]. And I might have enabled it. So I check, and, yes I have turned on autosuspend for my Bluetooth module. I turn it off, try to connect my&#8230; portable Bluetooth controller&#8230; and it works, first time. I do some&#8230; matrix analysis&#8230; with it and everything continues to work perfectly.

So I am an idiot. I close the page with the half-finished bug report and go to admit to my wife that I just wasted €20 on a WiFi card that I didn&#8217;t really need.  And, uh, if any Atheros or Ralink people read this, well, I&#8217;m sorry for any negative thoughts I may have had about your WiFi cards.

<a id="footnote">[1]</a> Well, mostly true, anyway. Some of the details might be mildly exaggerated.

 [3]: https://web.archive.org/web/20140427023346/http://oneplus.net/smash#close
 [4]: https://01.org/powertop
 [5]: http://fedoramagazine.org/saving-laptop-power-with-powertop/
