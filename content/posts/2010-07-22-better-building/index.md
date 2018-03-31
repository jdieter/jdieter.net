---
title: Better Building
author: jdieter
type: post
date: 2010-07-22T12:08:43+00:00
url: /?p=215
categories:
  - Computers
tags:
  - ain zhalta
  - fedora
  - koji
  - lesbg
  - loueizeh
  - tyre

---
[<img src="http://cedarandthistle.files.wordpress.com/2010/07/gears.jpg?w=150" alt="Gears" title="Gears" width="150" height="112" class="alignright size-thumbnail wp-image-216" srcset="/images/2010/07/gears.jpg 500w, /images/2010/07/gears-300x225.jpg 300w" sizes="(max-width: 150px) 100vw, 150px" />][1]As I mentioned in my last post, I&#8217;m setting up the computer system in our sister school in Ain Zhalta, up in the mountains, and last summer I set up the computer system in our sister school down in Tyre.

This includes both servers and workstations, and, being the lazy sysadmin that I am, I prefer not to reinvent the wheel for each place. My method last summer was to build rpms for most of the school-specific configuration settings, which allows me to make small changes and have them pulled in automatically.

The one problem I&#8217;ve hit is that there are some packages that have to be different between the two (and now three) schools. For example, the package lesbg-gdm-gconf contains the gconf settings so our login says &#8220;Welcome to the LES Loueizeh computer system&#8221;. Somehow, I don&#8217;t think Tyre or Ain Zhalta will appreciate having that showing on their welcome screen. Each school also has a different logo, and, again, the other schools don&#8217;t want our logo on their backgrounds.

So, what I really need is a way of organizing my rpms so that the common ones get passed to all the schools while the per-school ones only get passed to their school. Hmm. Think, think, what software is available in Fedora that could do that&#8230;

Enter [koji][2]. I had already setup a koji buildsystem to help track down the disappearing deltarpms bug (yes, the bug is still there, but that&#8217;s for another day), and the hardest part was getting the SSL certs right.

I set up a koji instance on our dedicated server (now yum upgraded to Fedora 13, see [this post][3] for more details) by following [these instructions][4], and now have a nice centralized build system for our schools at <http://koji.lesbg.com>.

The beauty of koji is that it handles inheritance. For Fedora 13, I&#8217;ve created one parent tag, [`dist-f13`][5], and three child tags [`dist-f13-lesbg`][6], [`dist-f13-lest`][7], [`dist-f13-lesaz`][8]. All of the common packages are built to the `dist-f13` tag, while the school-specific packages are built to their respective tags. Every night, I generate three repositories ([lesbg][9], [lest][10], and [lesaz][11]), and each repository has the correct rpms for that school. What could be easier than that?

There are a few caveats, though. First, our dedicated server is _slow_. It&#8217;s an old celeron with a whole 1GB of RAM (through [HiVelocity][12]), so I&#8217;ve had to compromise on a few little things. First off, we run both the x86_64 and i386 Fedora distributions, but our server is i386 only. This means that, at least for the moment, all of our packages have to be noarch.

Second, a normal part of the build process is to merge the upstream Fedora repositories with the local packages after each build (so it can be used to build the next package). On our server, this takes almost two hours. So I&#8217;ve modified it so the build repository _doesn&#8217;t_ include the local packages, and that mess is now gone. The downside is that I can&#8217;t BuildRequires any local packages, but, seeing as they&#8217;re all supposed to be configuration anyway, that hasn&#8217;t been a problem yet (and I don&#8217;t expect that it ever will be).

Anyhow, aside from some small glitches that seem to reflect more on the slow hardware available, koji has done the trick and done it nicely. With our current setup, I can now add another organization with a minimal amount of fuss, and that&#8217;s just what I was looking for! Thanks koji devs!

_Gears credit: [Gears gears cogs bits n pieces][13] by [Elsie esq][14]. Used under [CC BY][15]_

 [1]: http://cedarandthistle.files.wordpress.com/2010/07/gears.jpg
 [2]: https://fedorahosted.org/koji/wiki
 [3]: http://cedarandthistle.wordpress.com/2010/03/05/from-fedora-8-to-fedora-12-baby-steps
 [4]: http://fedoraproject.org/wiki/Koji/ServerHowTo
 [5]: http://koji.lesbg.com/koji/taginfo?tagID=1
 [6]: http://koji.lesbg.com/koji/taginfo?tagID=6
 [7]: http://koji.lesbg.com/koji/taginfo?tagID=5
 [8]: http://koji.lesbg.com/koji/taginfo?tagID=3
 [9]: http://koji.lesbg.com/lesbg
 [10]: http://koji.lesbg.com/lest
 [11]: http://koji.lesbg.com/lesaz
 [12]: http://www.hivelocity.net/
 [13]: http://www.flickr.com/photos/elsie/8229790/
 [14]: http://www.flickr.com/photos/elsie/
 [15]: http://creativecommons.org/licenses/by/2.0/deed.en