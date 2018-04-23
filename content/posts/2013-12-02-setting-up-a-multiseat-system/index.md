---
title: Setting up a multiseat system
author: jdieter
description: The hardware and software required to setup multiseat systems in Fedora
type: post
date: 2013-12-02T12:31:40+00:00
url: /posts/2013/12/02/setting-up-a-multiseat-system
categories:
  - Computers
tags:
  - amd
  - ati
  - fedora
  - multiseat

---
{{< imgproc "scc" Resize "300x" >}}Multiseat computer center{{< /imgproc >}}

On Saturday, [I described][2] the new multiseat systems that we&#8217;re using at [the school][3] here. A number of people asked for some more details, so here they are.

First, the hardware for a multiseat system (and the price at time of order from our [local supplier][4]):

  * 1 x Intel G2020 &#8211; 2.90 GHz &#8211; $65
  * 1 x Kingston DDR3-1600 8G &#8211; $65
  * 1 x MSI Z77A-G45 motherboard &#8211; $155
  * 1 x Kingston SSDNow V300 60GB &#8211; $70
  * 3 x Sapphire Radeon HD6450 &#8211; $50
  * 1 x Generic case &#8211; $20
  * 4 x 4 Port USB hub &#8211; $5
  * Tax &#8211; 10%

The final price is somewhere between $600 and $610, depending on the motherboard.

Once you have the hardware built, make sure the onboard video is enabled in the BIOS and is set to be the primary display. Plug the USB hubs into the computer. Make sure you don&#8217;t swap ports after they&#8217;ve been plugged in. Then, install the standard Fedora 19 GNOME desktop and install the latest version of the [_lesbg-multiseat_][5] package from the school&#8217;s repositories. Enable the multiseat service (`systemctl enable prepare-multiseat`).

Make sure [GDM][6] is installed and that you&#8217;re using it as your display manager. You can use any desktop environment you&#8217;d like but you must use GDM (or LightDM with some patches) as other display managers don&#8217;t recognize systemd&#8217;s seat management. Reboot the computer.

When the computer comes up, there should be a login screen on each monitor. Each USB hub should automatically match _a_ monitor, but you may have to swap ports so the hubs match the _right_ monitor. _lesbg-multiseat_ will always try to match the USB hubs to the video cards in order, so the first usb port will match the first video card, and so on.

Congratulations, you now have a multiseat system. Note that the configuration is designed to be minimal. We use the same OS image for single-seat or multiseat systems.

 [2]: /posts/2013/11/30/multiseat-in-fedora-19
 [3]: http://www.lesbg.com
 [4]: http://pcandparts.com/price.htm
 [5]: http://koji.lesbg.com/koji/packageinfo?packageID=64
 [6]: http://projects.gnome.org/gdm/
