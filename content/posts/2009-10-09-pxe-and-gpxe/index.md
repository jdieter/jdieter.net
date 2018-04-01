---
title: PXE and gPXE
author: jdieter
type: post
date: 2009-10-09T09:35:32+00:00
url: /posts/2009/10/09/pxe-and-gpxe
categories:
  - Computers
tags:
  - lesbg
  - linux
  - pxe

---
{{< imgproc "boot-menu" Resize "300x" >}}Boot menu{{< /imgproc >}}

So we&#8217;ve been using PXE booting on our network for the last couple of years and it has made life much easier.  We use pxelinux and vesamenu.c32 to have a pretty boot menu show up (specific to the system&#8217;s ip address).  Any school computers only see &#8220;Boot from hard drive&#8221; and &#8220;Administrative tools&#8221; (and choose the first option after five seconds).  An unknown computer (or a new computer) will get the menu on the right.  Administrative tools is password-locked so students/teachers can&#8217;t reinstall the operating system.

This system is incredibly efficient when it comes to imaging a new system (I go to &#8220;Administrative tools&#8221;, type the password, and then choose &#8220;Image system&#8221; and walk away).

We have run into several problems, though.  The main one was that several of our newer Intel motherboards have odd BIOS bugs that can occasionally be tripped up by PXE booting.  My favorite was the systems that completely froze when you chose &#8220;Boot from hard drive&#8221;.  We bought twenty of them.  My theory is that pxelinux is overwriting the RAM that contains the BIOS code for booting off of the hard drive.  And then there were the computers that would hang when trying to access &#8220;Administrative tools&#8221;.  The worst part is that I couldn&#8217;t replace the network boot rom with something from etherboot because I couldn&#8217;t find any tools that would allow me to modify Intel BIOSes this way.

It finally got to the point where half of our computers had PXE booting turned off by default, which made life fun when I needed to re-image one of those systems.  Enter gPXE.  [gPXE][1] is an open source network bootloader, and is the successor to etherboot.

I was playing around with it one day and came across [this page][2].  I realized that I could cunningly have PXE load the gPXE boot rom over the network, and then replace the manufacturer&#8217;s PXE code in memory with gPXE code, which seems to be far more robust.

So, now all of our systems can boot off of the network, and then boot from the hard drive without hanging.  All of our systems can access Administrative tools.  And we even get a few bonuses (data gets loaded over http rather than tftp).

 [1]: http://etherboot.org/wiki/index.php
 [2]: http://etherboot.org/wiki/pxechaining
