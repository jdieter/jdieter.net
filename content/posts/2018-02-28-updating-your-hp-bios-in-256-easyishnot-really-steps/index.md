---
title: Updating your HP BIOS in 256 easy(ish)(not really) steps
author: jdieter
description: Updating your HP laptop's BIOS is ridiculously complicated in Linux
type: post
url: /posts/2018/02/28/updating-your-hp-bios-in-256-easyishnot-really-steps
date: 2018-02-28T19:22:38+00:00
timeline_notification:
  - 1519845768
categories:
  - Computers
tags:
  - bios
  - efi
  - fail
  - fedora
  - hp
  - linux
  - uefi
  - windows

---

{{< imgproc "burning_laptop" Resize "300x" >}}Have you tried turning it off and on again?{{< /imgproc >}}

In case you can&#8217;t tell by the title of this post, I&#8217;m&#8230; mildly&#8230; annoyed with HP right now. The story starts with my just-over-a-year-old HP Pavilion laptop that has been having problems with its power brick.

While I was at work on Monday, the laptop started running on batter power even when it was plugged in, but when I got home, everything worked perfectly. I assumed it had something to do with the power at work, and wondered whether it might even be firmware related. I looked through the newest BIOS&#8217;s changelog, and, sure enough there was something mentioned about power and charging, so I downloaded it and updated my BIOS.

At least, that&#8217;s what I would have done if I was running Windows. Unfortunately for me, I&#8217;m not. I don&#8217;t even have a dual-boot system because I haven&#8217;t really needed Windows for years, and, when I do, a VM does the job just fine.

The only BIOS update HP offers is a Windows exe file, so I downloaded it, and ran cabextract to get the files off it. The tool lshw told me that my motherboard was an 0820D, and the zip contained a file called 0820DF45.bin (the BIOS revision is F.45), so I had everything I needed. I put the bin file on a USB, rebooted into HP&#8217;s recovery tools, and then went to firmware management, selected the bin file&#8230; and fail! It sat there telling me that I need a signature file for the firmware.

So I searched for the signature file, but it wasn&#8217;t in the exe. I googled for it, and found a lot of people who seem to be in the same boat. One suggestion was to run the exe on a Windows system and select the &#8220;Put BIOS update on USB&#8221; option. Sounded easy enough, so I booted my Windows VM, ran the exe, accepted the stupid EULA (I&#8217;m pretty sure I saw something in the forty-third paragraph about dancing on one leg while balancing a cupcake on my nose), installed the BIOS updater, and&#8230; nothing. After twenty seconds or so, a message popped up, &#8220;This program might not have installed correctly. Install using compatibility settings?&#8221; Yeah, thanks. After multiple attempts at different compatibility settings&#8230; still nothing.

I googled around a bit more, and found a 2GB HP USB image that you can use to recover your BIOS if it gets corrupted. Sweet! I downloaded it, and several hours later, I found out it only has the original BIOS revision (complete with a signature file!), but not my latest update!

At this point, I was desperate. My final hope was to figure out some way to boot my laptop into Windows. I have an 500GB SSD with a grand total of 30GB free, so that wasn&#8217;t an option. What about a Live USB? I mean, Linux distributions have had Live CDs and USBs forever, so it must just work in Windows, right?

Nope. Not unless you have Windows 10 Enterprise with it&#8217;s Windows-to-go feature. Luckily, the guys over at Hasleo software have created a nifty little tool called [WinToUSB][2] that does the same thing. I copied my VM image over to a USB, booted from it, and ran the BIOS update.

It worked perfectly and even offered to put the BIOS update on a USB! It seems that HP, in their infinite wisdom, have designed the updater so it refuses to start unless you&#8217;re on an HP machine.

To add insult to injury, all the updater does is copy the BIOS bin file and its signature onto the EFI partition, where it gets updated after a reboot. As far as I can tell, the signature file is generated on the fly by the updater, which begs the question&#8230; Why? Why generate the signature on the fly, rather than just stick it in the embedded CAB file with the BIOS images? Why require an HP system to generate a USB image containing the BIOS update? Why require your users to dance on one foot while balancing a cupcake on their nose?

And, as further insult (or maybe we&#8217;re back to injury), the BIOS update didn&#8217;t fix my charging problem, and it turns out that my just-out-of-warranty power brick is dying. Thanks, HP. You guys rock! After three HPs laptops in a row, I think it may be time for a change.

_Picture of [burning laptop][3] by secumem, used under a [CC BY-SA 3.0][4] license_

 [2]: https://www.easyuefi.com/wintousb/
 [3]: https://commons.wikimedia.org/wiki/File:Burned_laptop_secumem_11.jpg
 [4]: https://creativecommons.org/licenses/by-sa/3.0/deed.en
