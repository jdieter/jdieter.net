---
title: The Paddy's Day bug
author: jdieter
description: Bug causes Fedora to fail to boot due to DST in Ireland
type: post
date: 2021-03-28T22:07:12+01:00
url: /posts/2021/03/28/the-paddys-day-bug
categories:
  - Computers
tags:
  - fedora
  - systemd
  - dst
---

{{<imgproc "paddys-day-in-skibbereen" Resize "x300" />}}

Last Sunday, I got a message from a coworker and a good friend, Dhaval, that his Fedora laptop was stuck during the boot process.  His work laptop, also running Fedora, also failed to boot.  I checked my work laptop and personal laptop, and both of them rebooted just fine, so we then started going through the normal troubleshooting process on his work laptop.  There were no error messages on the screen, just a hang after `Update mlocate database every day`.  We booted a live environment, mounted the laptop's filesystem there, and checked the journal, and, again, nothing to see there.  Google didn't turn anything up either.  There wasn't much installed on his personal laptop, so Dhaval suggested re-installing Fedora on that laptop.  Booting into the live USB worked perfectly and the reinstall happened without a hitch.  We then rebooted into the newly installed system and... it hung.  Again.

What?  This was a completely clean install!  Was it possible that Dhaval's laptops both had some kind of boot sector virus?  But his work laptop had secure boot on, which is supposed to protect against that kind of attack.   I decided to compare the startup systemd services in my laptop compared to his.  After going through multiple services, I noticed that `raid-check.timer` was set to start on Dhaval's laptop, but wasn't setup on mine.  I started the service on my laptop... and the system immediately became unresponsive!  Using the live environment, I then disabled the service on Dhaval's laptop.  One reboot later... and his system booted perfectly!

Neither of our laptops have RAID and manually starting the `raid-check.service` didn't kill the system, so the problem seemed to be in `systemd` itself rather than the RAID service.  What really concerned me, though, was that the problem occurred on a fresh install of Fedora.  It turns out that, on F33, `raid-check.timer` is enabled by default.  My laptops had both been upgraded from previous Fedora releases where this wasn't the case, but Dhaval had performed fresh installs on his systems.  Further testing confirmed that the bug only affected systems running `raid-check.timer` after 1:00PM on Mar 21st.

As far as I could see, this was going to affect everyone when they booted Fedora, and this had me worried.  I figured the best place to start getting the word out was to open [a bug report](https://bugzilla.redhat.com/show_bug.cgi?id=1941335), and I then left messages in both #fedora-devel on IRC and the Fedora development mailing list.  `tomhughes` was the first to respond on IRC with a handy kernel command line option I'd never seen before to temporarily mask the timer in systemd (`systemd.mask=raid-check.timer`).  `cmurf` and `nirik` then started trying to work out where the bug was coming from.  `nirik` was the first one to realize that daylight savings might be the problem, since after 1:00AM on the 21st, the next trigger would be after the clocks change here in Ireland.  But it was `chrisawi` who gave us the first ray of hope when they pointed out that the bug was only triggered if you were in the "Europe/Dublin" time zone.

This was the first indication I had that the bug wasn't affecting everyone, and that was a huge relief.  I had feared that everyone who had installed Fedora 33 was going to have to work around this bug, but this dropped the number of affected people down to the Fedora users in Ireland.  `tomhughes` pointed out that Ireland is unique in the world in that summer time is "normal" and going back during the winter is the "savings" time.  Apparently systemd was having problems with the negative time offset, though it's unclear to me why this hadn't been triggered in previous years.

Once it was clear that the bug was related to DST in Ireland, `zbyszek` was able to figure out that the problem involved an infinite loop and he created a fix.  After an initial test update that caused major networking problems, we now have `systemd-246.13` pushed to stable that fully resolves the problem.

One of the things I realized when I was doing the initial troubleshooting is how long it's been since I've seen this kind of bug in Fedora.  I think the last time I saw a bug of this severity was somewhere around ten years ago, though before that these kinds of bugs seemed to show up annually.  It's a tribute to the QA team and to the processes that have been established around creating and pushing updates that these kind of show-stopping bugs are so rare.  This bug is a reminder, though, that no matter how good your testing is, there will always be some that fall through the cracks.

I would like to say a huge thank you again to `zbyszek` for fixing the bug and `adamw` for stopping the broken systemd update before it made it to stable.

If you're in Ireland and doing a clean install of Fedora 33, you'll need to work around the bug as follows:
 * In grub, type `e` to edit the current boot entry
 * Move the cursor to the line that starts with `linux` or `linuxefi` and type `systemd.mask=raid-check.timer` at the end of the line
 * Press Ctrl+X to boot
 * Once the system has booted, update systemd to 246.13 (or later)
