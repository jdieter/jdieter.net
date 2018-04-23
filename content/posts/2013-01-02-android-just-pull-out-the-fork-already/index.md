---
title: Android – Just pull out the fork already
author: jdieter
description: Frustrations with Android's fragmented landscape
type: post
date: 2013-01-01T22:52:21+00:00
url: /posts/2013/01/02/android-just-pull-out-the-fork-already
categories:
  - Computers
tags:
  - android
  - apps
  - cyanogenmod
  - forking
  - hp veer
  - kernel source
  - veer
  - webos

---
{{< imgproc "broken_veer3" Resize "150x" />}}

As mentioned in [this post][1], I have an HP Veer cell phone that I bought last year when we were in the States on furlough. Despite (or maybe because of) a 2.6&#8243; display and tiny keyboard, I&#8217;ve found it a joy to use, but its operating system, WebOS has one major drawback. Apps-wise, it&#8217;s dying.

My wife has an LG P500 with half the Veer&#8217;s RAM, a fraction of its flash, an ICS ROM that the good fellows over at AOKP have managed to hack together, and an up-to-date version of Skype, Whatsapp and any other app she desires. I, on the other hand, have a version of Skype that doesn&#8217;t log in unless I reset my user information, an impressive but buggy implementation of Whatsapp that seems to suck the ole&#8217; power out of my phone, and a small list of apps that&#8217;s slowly but surely shrinking.

Over the Christmas holidays, I thought I would see what it would take to get some form of Android on this phone. There seem to have been a [couple][2] of [attempts][3], but no source code that I could find, which brings me to my first complaint.

**&lt;rant&gt;**
  
What is up with Android ROM developers who take thousands of man-hours of somebody else&#8217;s work, add a few hours of their own, and then act as if they&#8217;ve invented the wheel and they need to keep it top secret? Maybe it&#8217;s the fact that I&#8217;m coming from the Fedora community where the concept of working as a team is an ideal even if it doesn&#8217;t always happen in fact, but the isolationist attitude I see in the different Android communities is quite depressing. I believe it&#8217;s one of the main reasons that participants in the Android community can be quite harsh with each other, much harsher on average than I see in the Fedora community.
  
**&lt;/rant&gt;**

So I go to [AOSP][4], download the platform and build it with no problems. Yay! Then I need to get the kernel source. From where? I start with <https://android.googlesource.com/kernel/msm.git>. There are four branches, three which are supposedly 3.0 or 3.4 JB kernels. And I can&#8217;t compile any of them. Some of the problems are configuration issues (the config.gz from WebOS&#8217;s 2.6.25 kernel is only a starting point), but there are also simple typos that are preventing compilation. Not exactly confidence-inspiring.

I decide to check out [Cyanogenmod&#8217;s kernel][5], but it looks like it hasn&#8217;t been touched in forever. A closer look at [Cyanogenmod&#8217;s github repository][6] shows 10&#8230; no 20&#8230; no a hundred kernel forks for various devices? And all this brings me to my second major complaint.

**&lt;rant&gt;**
  
Why on earth do we need a different kernel fork for each device? All I want to do is build straight from kernel.org. Is that so wrong? When will the forking stop?
  
**&lt;/rant&gt;**

Seriously, though, forking the Linux kernel to build it for your device seems a bit overkill, but it&#8217;s par for the course for the Android community. Is there any way to get this stuff back upstream? Or at the very least, could AOSP (or possibly Cyanogenmod) use one &#8220;official&#8221; kernel tree with patches sent back from these forks?

Anyhow, now I&#8217;m off to see if I can get one of the Cyanogenmod kernel forks to build. I&#8217;m sure I saw one in there for a msm7x30 chipset. Maybe I&#8217;d be better off just waiting until I can get a Nexus 4. Happy new year, everyone!

**Edit:** A couple of weeks ago, I got a [Samsung Galaxy S3 Mini][7], as they are available and cheaper here in Lebanon than in the States. It may not be the best phone out there, but it&#8217;s a great size and easily does everything I need. Goodbye WebOS. It was nice knowing you.

 [1]: /posts/2011/09/17/the-phone-is-dead-long-live-the-phone/
 [2]: http://github.com/xndcn/android-on-veer
 [3]: http://code.google.com/p/android-on-veer/downloads/list
 [4]: http://source.android.com/
 [5]: http://github.com/CyanogenMod/cm-kernel
 [6]: http://github.com/CyanogenMod
 [7]: http://www.samsung.com/uk/consumer/mobile-devices/smartphones/android/GT-I8190RWABTU
