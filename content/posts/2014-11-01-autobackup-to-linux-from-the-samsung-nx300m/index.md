---
title: Autobackup to Linux from the Samsung NX300M
author: jdieter
description: How to automatically backup your photos from a Samsmung NX300M to a Linux server
type: post
date: 2014-11-01T20:16:58+00:00
url: /posts/2014/11/01/autobackup-to-linux-from-the-samsung-nx300m
categories:
  - Computers
tags:
  - automatic backup
  - embedded
  - nx300m
  - samsung
  - samsung nx300m
  - tizen
  - ubifs

---
{{< imgproc "nx300m" Resize "300x" >}}Samsung NX300M{{< /imgproc >}}

While we were on vacation back in the States during the summer, our camera started doing strange things with the flash, so we decided it was time to get a new one. After much reading and debating, we settled on the [Samsung NX300M][2]. It&#8217;s been a major step up from our old point and click, and we&#8217;ve enjoyed the quality of the shots a lot.

Being the nerd that I am, I started wondering what OS powered the camera and whether it was hackable. After doing some in-depth research (typing &#8220;hack NX300M&#8221; in Google), I came across [these two][3] [fascinating articles][4] about the NX300. Basically, any code that you put in `autoexec.sh` in the root directory of your SD card will be run as root during camera bootup. I immediately tried to make my own `autoexec.sh` on my NX300M, but, unfortunately, it didn&#8217;t work. After some experimentation, I found that the initial firmware for the camera (1.10) does run `autoexec.sh`, so I downgraded my firmware and got to work.

I decided to make the killer app for a Wifi-enabled camera (at least, I think it&#8217;s a killer app). The NX300M can do some pretty cool things with its built-in Wifi like acting as a hotspot so it can send pictures to your phone. It can also do some form of automatic backup to your Windows desktop, but, as we don&#8217;t have any Windows systems in our house, I was unable to try it. The annoying thing about the Windows automatic backup feature, though, is that you have to manually switch to the Wifi setting and choose &#8220;Auto Backup&#8221; to run it. If I&#8217;m going to be doing automatic backups from my camera, I want it to be truly automatic, oddly enough. And I want it to backup to my wife&#8217;s laptop, which is running Fedora, preferrably using a secure copy method like rsync over ssh or scp.

I spent several days trying to work out how to make this all work, and here are some notes from my attempt:

  * There is one root filesystem and two support filesystems, all running ubifs.
  * The root filesystem is read-only, and, though I can remount it as rw, any writes seem to go to `/dev/null`. I don&#8217;t understand ubifs enough to know whether this is expected behavior.
  * The NX300M seems to be running the same ancient version of Tizen that the NX300 is, with a couple of proprietary binaries that do all the heavy lifting. Pretty much everything that Georg wrote about the NX300 in the above pages applied to the NX300M.
  * Working out how to start Wifi from `autoexec.sh` was very difficult. The NX300M uses a very old version of connman plus a funky daemon called net-config to actually power up and down the Wifi card. Neither has a cli tool available on the NX300M to control it, and each can only be controlled via dbus. Running dbus introspection on net-config causes the camera to reboot. Who knew?
  * `/dev/log_main` has a log of pretty much everything, including dbus commands. This is what I used to figure out what commands I needed to use to get the Wifi up.
  * The NX300M comes bundled with an SSH client (though no SSH server), which makes the backup method pretty simple.
  * Tizen has a power manager that&#8217;s run by the NX300M, but I&#8217;m not sure whether it&#8217;s actually being used. It appeared to me from the logs that the proprietary UI app was turning off the display and then the camera. To keep the camera from shutting off during the automatic backup, I ended up using `xdotool` to send keypresses to the UI. Yes, that&#8217;s ugly.
  * The UI understands the concept of time zones, but everything at the OS level is in UTC, and, at least as far as I can tell, the camera treats the UTC time as if it&#8217;s the current time zone.
  * There is a rtc on the camera, but it doesn&#8217;t seem to support wakeup events. 🙁

So, in the end I was able to put together a script that runs on boot that checks for any new pictures and, if there are any, connects to our Wifi and scp&#8217;s them to my wife&#8217;s laptop. It then appends the filename to a hidden file in the DCIM directory on the SD card that keeps track of which files have been copied across. If my wife decides to rename the file or the folder it&#8217;s in, I don&#8217;t really want to send the picture across again.

I&#8217;m releasing my code under the GPLv2+, and it&#8217;s available on [GitHub][5]. I hope somebody finds it useful.

 [2]: http://www.samsung.com/sg/consumer/smart-camera-camcorder/smart-nx/smart-nx/EV-NX300MDUTSG
 [3]: http://op-co.de/blog/posts/hacking_the_nx300/
 [4]: http://op-co.de/blog/posts/rooting_the_nx300/
 [5]: https://github.com/jdieter/nx300m-autobackup
