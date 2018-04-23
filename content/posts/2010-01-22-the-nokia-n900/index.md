---
title: The Nokia N900
author: jdieter
description: I review my brand new Nokia N900
type: post
date: 2010-01-22T19:54:14+00:00
url: /posts/2010/01/22/the-nokia-n900
categories:
  - Computers
  - Personal
tags:
  - linux
  - mtc touch
  - n900
  - nokia
  - opengl es

---
{{< imgproc "n900-supertux" Resize "300x" />}}

I got a Nokia N900 for Christmas. No, to be more accurate, I got a Nokia N900 **after** Christmas. We had some friends who were spending Christmas in the States, so I ordered one off of Amazon and had it shipped to their home. It was a full $150 cheaper than it would have been here. The bummer was having to wait until they got back to Beirut to open it.

So, I&#8217;ve been using it for the last few weeks and there are some seriously cool things, as well as some things that are less cool.

First off, the good:

  1. Root access
  2. Native X Windows, so most programs run on it without having to modify the source
  3. A very sensitive touch screen
  4. Nice effects
  5. SSH server and client
  6. An 800&#215;480 display crammed into 3.5&#8243;
  7. Community-run repositories so I can roll and publish my own packages
  8. And finally (just in case I forgot), Root access

But there is some bad:

  1. **OpenGL ES 2.0:** One of the first things I wanted to do with this was play BZFlag on it. Nope, it&#8217;s not in the repositories and can&#8217;t be compiled because it requires glBitmap(), glRasterPos3f() and various other functions not available in either OpenGL ES 2.0 or 1.1. I understand the motivation between ES, but surely there is _some_ value in a OpenGL -> ES wrapper. I&#8217;ve found one [here][2], but it doesn&#8217;t implement the above functions. I&#8217;m hoping to do some stuff with this, but I&#8217;m no OpenGL expert. So for now I&#8217;m stuck playing Supertux (in non-OpenGL mode).
  2. **Ovi Maps:** Yeah, I got all excited about Ovi Maps 3.0.3 which is supposed to be super cool with voice and turn-by-turn directions, but I&#8217;m not able to upgrade from 1.0.1. Apparently the N900 was left out of the first batch of smartphones to get the updates. Having said that, 1.0.1&#8217;s Lebanon maps are incredibly useless, so unless 3.0.3 includes better maps, it will all be pointless anyway.
  3. **Skype:** There&#8217;s no video. There&#8217;s even a second (crappy) camera on the phone that points towards the user, but video just isn&#8217;t available. Unfortunately, I don&#8217;t have my family on GoogleTalk yet, so I haven&#8217;t been able to test whether that&#8217;s any different.

Despite the above flaws, I am extremely happy with this phone. I can hack on it without having to jailbreak it. What more can you ask for? Aside from a reasonable data plan from MTC Touch (my local cell phone service provider)&#8230;

 [2]: http://code.google.com/p/gl-wes-v2/
