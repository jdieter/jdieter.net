---
title: Goodbye GDM (for the moment)
author: jdieter
description: Switching from GDM to lxdm on our Fedora desktops
type: post
date: 2012-02-08T14:39:05+00:00
url: /posts/2012/02/08/goodbye-gdm-for-the-moment
categories:
  - Computers
tags:
  - fedora
  - gdm
  - lesbg
  - linux

---
Our school system has been running Fedora on our desktops since early 2008. During that time, our login screen has been managed by [GDM][1] and our desktop session has been [GNOME][2]. It doesn&#8217;t look like our desktop session is going to change any time soon, as we transitioned to [GNOME Shell][3] in Fedora 13 and the students and teachers have overwhelmingly preferred it to GNOME 2.

At our school we have a couple of IT policies that affect our login sessions. All lab computers that aren&#8217;t logged in have some form of screensaver running (not a black screen) as it helps students identify which computers are on and which aren&#8217;t at a glance. It also helps IT see which computers need to be checked. Logged in computers should never have a screensaver running and screen-locking is disabled as we have far more users than computers. Some may argue that these policies should be amended, but, for the moment, they are what they are.

In older versions of Fedora, gnome-screensaver was set to run in gdm with the floating Fedora bubbles coming on after a minute of disuse. The screensaver was inhibited during the login session (I experimented with changing the gconf settings so it didn&#8217;t come on for 100 hours and other such nonsense, but inhibiting the screensaver was the only way I found that worked reliably over long periods of time).

With Fedora 16 we now have a much more beautiful new version of GDM, but, unfortunately, the gnome-screensaver that comes with it no longer allows you to actually show a screensaver. I decided to try using xscreensaver instead, but it cannot run in GDM. It keeps complaining that something else is grabbing the keyboard, and I can only assume that something is GDM. Finally, I can&#8217;t even write a simple screensaver program in python as it seems I can&#8217;t even run a full-screen app over the GDM screen.

Add to all that the fact that we have 1000+ students in the school who are able to log into any lab computer and GDM lists all users who ever logged into the computer. Which theoretically could be 1000. Urgh!

So for our Fedora 16 system, I&#8217;ve switched over to lxdm. A quick configuration change to tell it to boot gnome-shell as its default session (and some hacks so it doesn&#8217;t try to remember what language the last user used to log in) and it was set. Xscreensaver runs just fine over it and we now have some pretty pictures of Lebanon and the school in a carousel as our login screensaver.

It looks like the screensaver functionality will get merged straight into gnome-shell, and, if it does, we may be able to have extensions that actually implement the screensaver. If that happens, and if GDM re-acquires the ability to not show the user list, we&#8217;ll switch back to GDM. Until then, we&#8217;ll stick with lxdm.

Now I just need to work out how to inhibit gnome-screensaver during login as `gnome-screensaver --inhibit` [no longer works][4]. I&#8217;m sure there was a good reason for [removing that code][5], but for the life of me I can&#8217;t work out what it was&#8230;

 [1]: http://projects.gnome.org/gdm/
 [2]: http://www.gnome.org/
 [3]: http://www.gnome.org/gnome-3/
 [4]: https://bugzilla.redhat.com/show_bug.cgi?id=713255
 [5]: http://dev.gentoo.org/~nirbheek/gnome/3.0/gnome-screensaver-poke.log
