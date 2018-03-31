---
title: Fedora 18 – A Sysadmin’s view
author: jdieter
type: post
date: 2013-02-25T20:17:33+00:00
url: /?p=551
categories:
  - Computers
tags:
  - btrfs
  - dconf
  - fedora
  - fedora 18
  - filesystem snapshots
  - linux
  - offline updates
  - polkit
  - systemd

---
<figure id="attachment_556" style="max-width: 200px" class="wp-caption alignright">[<img src="http://cedarandthistle.files.wordpress.com/2013/02/road-into-clouds.jpg?w=200" alt="Road leading down into clouds" width="200" height="150" class="size-medium wp-image-556" srcset="/images/2013/02/road-into-clouds.jpg 1024w, /images/2013/02/road-into-clouds-300x225.jpg 300w, /images/2013/02/road-into-clouds-768x576.jpg 768w" sizes="(max-width: 200px) 100vw, 200px" />][1]<figcaption class="wp-caption-text">The road less traveled</figcaption></figure> 

At our school we have around 100 desktops, a vast majority of which run Fedora, and somewhere around 900 users. We switched from Windows to Fedora shortly after Fedora 8 was released and we&#8217;ve hit 8, 10, 13, 16, and 17 (deploying a [local koji instance][2] has made it easier to upgrade).

As I finished putting together our new Fedora 18 image, there were a few things I wanted to mention.

**The Good**

  1. **Offline updates:** Traditionally, our systems automatically updated on shutdown. In the 16-17 releases, that became very fragile as any systemctl scriptlets in the updates would block because systemd was in the process of shutting down. Now, with systemd&#8217;s support for offline updates, we can download the updates on shutdown, reboot the computer, and install the updates in a minimal system environment. I&#8217;ve packaged my offline updater [here][3].
  2. **btrfs snapshots:** This isn&#8217;t new in Fedora 18, but, with the availability of offline updates, we&#8217;ve finally been able to take proper advantage of it. One problem we have is that we have impatient students who think the reset button is the best way to get access to a computer that&#8217;s in the middle of a large update. Now, if some genius reboots the computer while it&#8217;s updating, it reverts to its pre-update state, and then attempts the update again. If, on the other hand, the update fails due to a software fault, the computer reverts to its pre-update state and boots normally. Either way, the system won&#8217;t be the half-updated zombie that so many of my Fedora 17 desktops are.
  3. **dconf mandatory settings:** Over the years we&#8217;ve moved from gconf to dconf, and I love the easy way that dconf allows us to set mandatory settings for Gnome. This continued working with only a small modification from Fedora 17 to Fedora 18, available [here][4] and [here][5].
  4. **Javascript config for polkit:** I love how flexible this is. We push out the same Fedora image to our school laptops, but the primary difference compared to the desktop is that we allow our laptop users to suspend, hibernate and shutdown their laptops, while our desktop users can&#8217;t do any of the above. What I would really like to do is have the JS config check for the existence of a file (say /etc/sysconfig/laptop), and do different things based on that, but I haven&#8217;t managed to work out how to do that yet. My first attempt is [here][6].
  5. **systemd:** This isn&#8217;t a new feature in 18, but systemd deserves a shout-out anyway. It does a great job of making my workstations boot quickly and has greatly simplified my initscripts. It&#8217;s so nice to be able to easily prevent the display manager from starting before we have mounted our network directories.
  6. **Gnome Shell:** We actually started experimenting with Gnome Shell when it was first included in Fedora, and I switched to it as the default desktop in Fedora 13. As we&#8217;ve moved from 13 to 16, then 17, and now 18, it&#8217;s been a nice clean evolution for our users. When I first enabled Gnome Shell in our Fedora 13 test environment, the feedback from our students was very positive. &#8220;It doesn&#8217;t look like Windows 98 any more!&#8221; was the most common comment. As we&#8217;ve upgraded, our users have only become more happy with it.

**The Bad**

The bad in Fedora 18 mainly comes down to the one area where Linux in general, and Fedora specifically, is weak &#8211; being backwards-compatible. This was noticeable in two very specific places:

  1. **Javascript config for polkit:** While I was impressed with the new javascript config&#8217;s flexibility, I was most definitely _not_ impressed that my old pkla files were completely ignored. As a system administrator, I find it frustrating when I have to completely rewrite my configuration files because &#8220;now we have a better way&#8221;. I&#8217;ve read the [blog post][7] explaining the reasoning behind the switch to the JS config, but how hard would it have been to either keep the old pkla interpreter, or, if it was really desired, rewrite the pkla interpreter in javascript? The ironic part of this is that the &#8220;old&#8221; pkla configuration was itself a non-backwards-compatible change from the even older PolicyKit configuration a little less than four years ago.
  2. **dconf mandatory settings:** With the version of dconf in Fedora 18, we now have the ability to have multiple user dconf databases. This is a great feature, but it requires a change in the format of the database profile files, which meant my database profile files from Fedora 17 no longer worked correctly. In fact, they caused gnome-settings-daemon to crash, which crashed Gnome and left users unable to log in. Oops. To be fair, this was a far less annoying change because I only had to change a couple of lines, but I&#8217;m still not impressed that dconf couldn&#8217;t just read my old db profile files.

As a developer, I totally understand the &#8220;I have a better way&#8221; mindset, but I think backwards compatibility is still vital. That&#8217;s why I love [rsync][8] and [systemd][9], but have very little time for [unison][10] (three _different_ versions in the Fedora repositories because newer versions don&#8217;t speak the same language as older versions).

I know some people will say, &#8220;If you want stability, just use RHEL.&#8221; That&#8217;s fine, but I&#8217;m not necessarily looking for stability. I like the rate of change in Fedora. What I dislike is when things break because someone wanted to do something different.

All in all, I&#8217;ve been really happy with Fedora as our school&#8217;s primary OS, and each new release&#8217;s features only make me happier. Now I need to go fix [a regression][11] in [yum-presto][12] that popped up because of some changes we made because we wanted to do something different.

 [1]: http://cedarandthistle.files.wordpress.com/2013/02/road-into-clouds.jpg
 [2]: http://koji.lesbg.com/koji
 [3]: http://koji.lesbg.com/koji/buildinfo?buildID=193
 [4]: http://koji.lesbg.com/koji/buildinfo?buildID=189
 [5]: http://koji.lesbg.com/koji/buildinfo?buildID=187
 [6]: http://koji.lesbg.com/koji/buildinfo?buildID=192
 [7]: http://davidz25.blogspot.com/2012/06/authorization-rules-in-polkit.html
 [8]: https://rsync.samba.org/
 [9]: http://www.freedesktop.org/wiki/Software/systemd
 [10]: http://www.cis.upenn.edu/~bcpierce/unison/
 [11]: http://bugzilla.redhat.com/show_bug.cgi?id=752428
 [12]: http://fedorahosted.org/presto/wiki