---
title: Virtualizing Windows (and simplifying my life)
author: jdieter
type: post
date: 2015-12-31T20:36:16+00:00
url: /posts/2015/12/31/virtualizing-windows-and-simplifying-my-life
categories:
  - Computers
tags:
  - fedora
  - kvm
  - qemu
  - qemu-kvm
  - virtualbox
  - virtualization
  - windows
  - windows 7

---
{{< imgproc "fireworks" Resize "300x" >}}Freedom{{< /imgproc >}}

At our school, we&#8217;ve been running Fedora on most of the desktops since Fedora 8, but the one department that&#8217;s stuck with Windows is the accounting department, mainly because their software is Windows-only.  This has long been a problem because most of our infrastructure is built around Linux and we haven&#8217;t put nearly as much energy into making sure Windows systems are maintained properly.

Obviously, this led to problems that started out small, but grew until the systems were bordering on unusable.  When it reached the point that we were considering yet another reinstall of Windows, I suggested switching the accountants over to Fedora and having them use a virtual machine for the software that required the other OS.

It took a few days to get something that worked, and another week (including one very late night) to tie down the little glitches and get the virtual machine beyond just-usable to easy-to-use.

I started with VirtualBox, but there were a number of issues with stability, so I decided to take another look at QEMU.  I thought about using libvirt, but one of my requirements was that everything needed to run under the user&#8217;s permissions, so it turned out to be easier to run qemu-kvm directly.  I used SPICE and installed the guest agent, which gave us a far better experience with QEMU than the last time I used it for a desktop OS (which, granted, was over five years ago).

Most of my time was spent fixing problems inherent to Windows 7 itself, rather than the virtualization process.  It turns out that there are bugs in how it handles network printers, causing delays every time you want to print.  Oddly enough, the fix [was pretty simple][1], but it took a while to figure it out.  There was also [the bug where network drives aren&#8217;t mapped properly][2] if the system boots so quickly that the network isn&#8217;t up in time, which was only fixable by using a batch file for mapping the network drives.

One change I made was to insist that we use throw-away snapshots for day-to-day work (the data is stored on a network drive) and only keep changes when we&#8217;re updating the accounting software.  This should help protect us from viruses and malware that can&#8217;t be easily removed.

The best part of all this is that the new accounting VM and the scripts necessary to start it are sitting in a network folder only accessible by the accountants.  This means that they can now do their work from _any_ computer in the school, if necessary, while still protecting them.

And I&#8217;m no longer stuck keeping unmanaged Windows systems running.  What a way to close out the year!

**[Colorful Fireworks][3] by 久留米市民(Kurume-Shimin) used under a [CC BY-SA 3.0 unported][4] license**

 [1]: http://chee-yang.blogspot.com/2010/07/google-chrome-is-laging-running-on.html
 [2]: http://answers.microsoft.com/en-us/windows/forum/windows_7-networking/mapped-network-drive-is-connected-but-shows-as-not/4ac5ff92-863c-4921-8632-e38cbd136fb4
 [3]: https://commons.wikimedia.org/wiki/File:ColorfulFireworks.png
 [4]: https://creativecommons.org/licenses/by-sa/3.0/deed.en
