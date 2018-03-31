---
title: Notes on a mass upgrade to Fedora 23
author: jdieter
type: post
date: 2016-02-29T19:28:24+00:00
url: /posts/2016/02/29/notes-on-a-mass-upgrade-to-fedora-23
categories:
  - Computers
tags:
  - ansible
  - fedora
  - fedora 23
  - lesbg
  - linux
  - upgrades

---
{{< imgproc "fedora-screenshot" Resize "300x" >}}Fedora 23{{< /imgproc >}}

One of the hardest parts of running Fedora in a school setting is keeping on top of the upgrades, and I ended up falling a few months behind. Fedora 23 was released back in November, and it took me until February to start the upgrade process.

For our provisioning process, we&#8217;ve switched from a custom koji instance to ansible (with our [plays on github][1]), and this release was the first time I was really able to take advantage it. I changed our default kickstart to point to the Fedora 23 repositories, installed it on a test system, ran ansible on it, and _voilà_, I had a working Fedora 23 setup, running perfectly with all our school&#8217;s customizations. It was the easiest upgrade experience I&#8217;ve ever had!

Well, mostly.

As usual, the moment you think everything is perfect is the moment everything goes wrong. On our multiseat systems, we have three external AMD graphics cards along with the internal Intel graphics. The first bug I noticed was that the Intel card wasn&#8217;t doing any graphics acceleration. It turns out that VGA arbitration is automatically turned on if you have more than one video card, and Intel cards don&#8217;t support it in DRI2. DRI3 does handle arbitration just fine, but it was (and still is) disabled in the latest xorg-x11-drv-intel in the updates repository. Luckily for me, there&#8217;s a [build in koji][2] that re-enables DRI3. Problem solved.

The second bug was&#8230;odd. While we use gnome-shell as the default desktop environment in the school, we use lightdm for logging in, mainly because of it&#8217;s flexibility. We run xscreensaver in the login screen (and only in the login screen) to make it clear which computers are off, which are on, and which are logged in. GDM doesn&#8217;t support xscreensaver, but lightdm does. And this brings us back to the bug. On the Intel seat, moving the mouse or pressing a key would stop the screensaver as expected, but the screen would remain black except for the username control. It seems that the &#8220;VisibilityNotify&#8221; event [isn&#8217;t being honored by the driver][3] (though don&#8217;t ask me why it should be passed down to the driver). I [filed a bug][4], and then finally figured out that fading xscreensaver back in works around the problem.

The third bug is even stranger. On the teacher&#8217;s machine, we have a small script that starts x11vnc (giving no control to anyone connecting to it) so the teacher can give a demonstration to the students. But after install Fedora 23 on the teacher&#8217;s machine, the demo kept showing the same three frames over and over. The teacher&#8217;s system isn&#8217;t multiseat and is using the builtin Intel graphics, so, oddly enough, disabling DRI3 fixed the problem. I [filed another bug][5].

When upgrading the staff room systems, I [ran into a bug][6] in which cups runs screaming into the night (ok, slight exaggeration) if you have a server announcing printers over both the old cups and new dnssd protocols. Since we don&#8217;t have any pre-F21 systems any more, I&#8217;ve just disabled the old cups protocol on the server.

And, finally, my principal, who teachers computers to grades 11 and 12, came in to ask me why [LibreOffice was crashing][7] for a couple (and only a couple) of his students when they were formatting cells on a spreadsheet that he gave them. After some fancy footwork involving rm&#8217;d .config/libreoffice directories and files saved into random odd formats and then back into ods, we finally managed to format the cells without a crash. Lovely.

All this brings me back to ansible. In each of the bugs that required changes to the workstations, all I had to do was update the ansible scripts and push the changes out. Talk about painless! Ansible has made this job so much easier!

And I do want to finish by saying that these bugs are part of the reason that I love Fedora. With Fedora, I have the freedom to fix these problems myself. For both the cups bug and the xscreensaver bug, I was able to dig into the source code to start tracking down where the problem lay and come up with a workaround. And if I can just get the LibreOffice bug to reproduce, I could get a crash dump off of it and possibly figure it out too. Hurrah for source code!

 [1]: https://github.com/lesbg/ansible
 [2]: http://koji.fedoraproject.org/koji/buildinfo?buildID=707268
 [3]: https://bugzilla.redhat.com/show_bug.cgi?id=1309680#c4
 [4]: https://bugzilla.redhat.com/show_bug.cgi?id=1309680
 [5]: https://bugzilla.redhat.com/show_bug.cgi?id=1310532
 [6]: https://bugzilla.redhat.com/show_bug.cgi?id=1311387
 [7]: https://bugzilla.redhat.com/show_bug.cgi?id=1313016
