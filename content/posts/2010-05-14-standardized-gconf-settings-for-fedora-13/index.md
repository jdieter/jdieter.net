---
title: Standardized gconf settings for Fedora 13
author: jdieter
type: post
date: 2010-05-14T21:55:11+00:00
url: /?p=176
categories:
  - Computers
tags:
  - fedora
  - fedora 13
  - gconf
  - lesbg

---
[<img src="http://cedarandthistle.files.wordpress.com/2010/05/goddard-normalish.jpg?w=300" alt="Desktop background for our computer systems" title="Desktop background" width="300" height="240" class="alignright size-medium wp-image-178" srcset="/images/2010/05/goddard-normalish.jpg 1280w, /images/2010/05/goddard-normalish-300x240.jpg 300w, /images/2010/05/goddard-normalish-768x614.jpg 768w, /images/2010/05/goddard-normalish-1024x819.jpg 1024w" sizes="(max-width: 300px) 100vw, 300px" />][1]Over the past couple of weeks I&#8217;ve been putting together a Fedora 13 image to replace the Fedora 11 image we&#8217;re currently using in the school. One of the things I&#8217;ve been working on since we deployed Fedora 10 a couple of years ago is storing school-wide configuration in RPMs that can be easily updated with a new release.

One of these RPMs contains [default gconf settings][2] ([SRPM][3]) for things like the school proxy server, default icons to show up on the panel when a user logs in, keyboard layouts (our keyboards are dual English/Arabic), fonts, and now, with Fedora 13, default favorites for gnome-shell.

These gconf settings are stored in a location where they won&#8217;t conflict with the defaults set by applications but will automatically have a higher precedence.

A second RPM enforces [mandatory gconf settings][4] ([SRPM][5]) by using a small bash script that runs on bootup to take the combined defaults for specified keys and make them mandatory. This allows me to set things like `/system/proxy` and `/system/http_proxy` and not worry that somebody&#8217;s going to accidentally change it, messing up their Internet access.

It also gives me the freedom to change some things, like the background image, from mandatory for lab computers to default for school administration computers just by removing the key names from an easily editable configuration file.

Finally, I have a few packages with gconf settings for compiz. The idea is that if the computer can&#8217;t support compiz, you don&#8217;t install any of the packages and are stuck with metacity (VIA, I&#8217;m looking at you). If it&#8217;s one of our seven-year-old nvidia cards that barely supports compiz, you install the [minimal effects package][6] ([SRPM][7]) which will just have the cube and a few other simple odds and ends. If the computer is one of our year-old Intel desktops, you get a [lot more bling][8] ([SRPM][9]). And now, as an alternative to either of the compiz options, there&#8217;s a package that has [gnome-shell by default][10] ([SRPM][11]).

One thing I haven&#8217;t mentioned yet is the [required background image][12] ([SRPM][13]). As is pretty obvious if you look at it (it&#8217;s also at the top of this post), I take the default Fedora background from [here][14] ([CC-BY-SA][15]) and add the school logo. I&#8217;m quite happy with how it turned out this time.

**_Update 7/30/2010:_ As mentioned in my more recent blog post [Better Building][16], all the packages we use in our school are available from <http://koji.lesbg.com>.**

 [1]: http://cedarandthistle.files.wordpress.com/2010/05/goddard-normalish.jpg
 [2]: http://www.lesbg.com/jdieter/lesbg-gconf-defaults-1.5-1.fc13.noarch.rpm
 [3]: http://www.lesbg.com/jdieter/lesbg-gconf-defaults-1.5-1.fc13.src.rpm
 [4]: http://www.lesbg.com/jdieter/lesbg-gconf-mandatory-1.1-1.fc13.noarch.rpm
 [5]: http://www.lesbg.com/jdieter/lesbg-gconf-mandatory-1.1-1.fc13.src.rpm
 [6]: http://www.lesbg.com/jdieter/lesbg-gconf-compiz-minimal-1.2-1.fc13.noarch.rpm
 [7]: http://www.lesbg.com/jdieter/lesbg-gconf-compiz-minimal-1.2-1.fc13.src.rpm
 [8]: http://www.lesbg.com/jdieter/lesbg-gconf-compiz-full-1.2-1.fc13.noarch.rpm
 [9]: http://www.lesbg.com/jdieter/lesbg-gconf-compiz-full-1.2-1.fc13.src.rpm
 [10]: http://www.lesbg.com/jdieter/lesbg-gconf-gnomeshell-1.0-1.fc13.noarch.rpm
 [11]: http://www.lesbg.com/jdieter/lesbg-gconf-gnomeshell-1.0-1.fc13.src.rpm
 [12]: http://www.lesbg.com/jdieter/lesbg-background-13.0-1.fc13.noarch.rpm
 [13]: http://www.lesbg.com/jdieter/lesbg-background-13.0-1.fc13.src.rpm
 [14]: http://fedorapeople.org/groups/designteam/Resources/Fedora%20Release%20Themes/F13/Final/goddard_1280x1024.xcf
 [15]: http://creativecommons.org/licenses/by-sa/3.0/
 [16]: http://cedarandthistle.wordpress.com/2010/07/22/better-building/