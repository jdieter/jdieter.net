---
title: Eulogy for yum-presto
author: jdieter
description: Yum-presto has been retired and its functionality has been merged directly into yum
type: post
date: 2013-05-31T20:59:21+00:00
url: /posts/2013/05/31/eulogy-for-yum-presto
categories:
  - Computers
tags:
  - deltarpm
  - fedora
  - fedora forum
  - lesbg
  - presto

---
{{< imgproc "marker" Resize "300x" />}}

With Fedora 19 comes a change that is rather bitter-sweet. Yum-presto, the plugin that I originally wrote to allow the use of deltarpms in Fedora, has been retired, its functionality merged directly into yum. While this is a necessary step to achieve things like parallel downloads of deltarpms and regular rpms, it&#8217;s still hard to see the death of a project that I&#8217;ve been involved with since its beginning, six years ago.

I started using Linux in 2000, switching from Red Hat Linux to Mandrake in 2001, and then to Fedora Core in September 2004, just before Fedora Core 3 was released. I had just returned to the [Lebanon Evangelical School][2] as a teacher and sysadmin after finishing university, and I remember downloading the FC3 Test 2 ISO image on our impressively fast 128kbps link. And I still remember my disgust when Test 2 was still quite buggy and I had to download the FC2 ISO.

Somewhere around the end of 2005, I came up with the brilliant idea of running a local mirror of Fedora Core for our school. The problem was that updates took forever to download, so I had a flash of inspiration. What if&#8230; we could download only the parts of the rpm that had changed? Updates would be much smaller and running a local mirror would become feasible. With that kind of motivation, I quickly hacked together a brilliantly elegant mess of code that was able to delta two small binary files in sometime under a day and apply the resultant patch in sometime under an hour. Definitely not my proudest coding moment, but I [announced my work in the Fedora Forum][3] (which I&#8217;m sure made sense to me at the time).

I got a single response to my post. [Rahul Sundaram][4] pointed out, much to my disgust, that Michael Schroeder of Suse had already created an efficient and fast (at least compared to my mess of code) program that could create and apply deltas to rpms. This program was cleverly named [deltarpm][5]. After looking at deltarpm and verifying that, yes, it did do what I wanted, I then put the whole project on the back burner for a while.

2006 passed. I got married, in the process missing a war in Lebanon, and spent most of rest of the year trying to adapt to the new rules of married life. Apparently leaving my dirty clothes all over the house was no longer acceptable, and there was some difference of opinion on what the definition of a well-balanced breakfast was. I thought that the peanuts in the Snickers bar did a great job of balancing out my Coke, while my new Irish wife thought that my logic needed to be balanced with a sharp smack on the head. She won. She usually does.

Early in 2007, Ahmed Kamal [started posting][6] about some work he was doing on a yum plugin that would download deltarpms. This plugin was named [yum-presto][7]. In early March, I got involved and started reworking some of the code. By the end of March, we [started testing][8] the plugin with Fedora Core 6, and, in early April, [Kevin Fenzi][9] sponsored me and reviewed yum-presto for Fedora Extras. We hit bugs. Then we fixed them. We were on a roll.

Then things ground to a halt. We had the client side working reliably, but there was no way that the Fedora infrastructure was going to use my hacky scripts for generating deltarpms. Someone needed to do some work to properly integrate deltarpm generation into Fedora&#8217;s infrastructure, but I had no idea how to go about it.

So I ended up in a rut, daily generating deltarpms for our FC6 i386 mirror, but it was anything \*but\* official. If anyone wanted to use them, they had to manually change the url in fedora-updates.repo. FC6 turned into Fedora 7, then Fedora 8, then Fedora 9, and finally Fedora 10. [Jeremy Katz][10], [Casey Dahlin][11] and [James Antill][12] all contributed major changes to the client code, with James essentially rewriting the whole thing, but the infrastructure side of things stayed stagnant.

I opened a [ticket against bodhi][13] to try to figure out where the deltarpm generation should be happening, and, after a few rounds of pass the parcel, [Seth Vidal][14] finally decided to put it straight into createrepo. With that work done in 2009, Fedora 11 was the first release with official deltarpms across all the platforms that Fedora supported.

Four years have passed since Fedora 11 came out. Now I&#8217;m the one trying to convince my kids that Snickers and Coke weren&#8217;t meant for breakfast. And yum-presto has been mostly in maintenance mode. Last May, Lars Gullik Bjønnes added code to rebuild the rpms in parallel, and, in August, Zdenek Pavlas added code to download drpms in parallel. Both features made it into Fedora 18. I didn&#8217;t realize at the time that those would be the last features added to yum-presto.

On February 21, Zdenek [posted this][15] on yum-devel:

> The native drpm support is complete enough to be used and tested. I&#8217;m quite satisfied with the performance, but the applydeltarpm backend needs more work. I&#8217;m going to make a rawhide release today.

Yum-presto had just died. And yum was now able to do things with deltarpms that we never could do as a plugin.

I do want to say thank you to everyone who helped test and develop yum-presto. A special thank you to Michael Schroeder, whose work on deltarpm made yum-presto possible. Thank you to the Lebanon Evangelical School for hosting the i386 deltarpms and Angel Marin for hosting the x86_64 deltarpms for the two years it took to get the Fedora infrastructure up and running. And thank you to all those whose hard work makes Fedora the exciting place that it is.

 [2]: http://www.lesbg.com
 [3]: http://forums.fedoraforum.org/showthread.php?s=a31f3b23779d6c37ba99a396f0082b59&p=415394#post415394
 [4]: https://fedoraproject.org/wiki/User:Sundaram
 [5]: http://gitorious.org/deltarpm
 [6]: http://lists.fedoraproject.org/pipermail/infrastructure/2007-January/000962.html
 [7]: https://fedorahosted.org/presto/
 [8]: http://lists.fedoraproject.org/pipermail/devel/2007-March/097847.html
 [9]: https://fedoraproject.org/wiki/User:Kevin
 [10]: https://fedoraproject.org/wiki/User:Katzj
 [11]: https://fedoraproject.org/wiki/CaseyDahlin
 [12]: https://fedoraproject.org/wiki/User:James
 [13]: https://fedorahosted.org/bodhi/ticket/160
 [14]: https://fedoraproject.org/wiki/User:Skvidal
 [15]: http://lists.baseurl.org/pipermail/yum-devel/2013-February/009916.html
