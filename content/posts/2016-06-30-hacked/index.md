---
title: Hacked!
author: jdieter
description: This year our students managed to get the server's internet speed and break into a teacher's account in LESSON
type: post
date: 2016-06-30T19:00:34+00:00
url: /posts/2016/06/30/hacked
categories:
  - Computers
tags:
  - 802.1x
  - cheating
  - dhcp
  - hacking
  - ip addresses
  - lesbg
  - networking
  - RADIUS

---
{{< imgproc "locked-laptop" Resize "300x" />}}

With our school&#8217;s graduation ceremony last night, the school year is now officially finished. This year will definitely go down in my memory as the year that the students got the best of me&#8230; twice!

**IP-gate**
  
To give some background on the first &#8220;hack,&#8221; our current network uses a flat IP network with IP subnets used for each different set of machines (for organizational purposes). We don&#8217;t use IP-based security for obvious reasons, but we do use the subnets for deciding internet speed. IP addresses (fixed except for the guest subnet) are given out using DHCP, and each of the subnets except the guest subnet gets decent speed.

When I set up this system ten years ago, I was well aware of the obvious drawback: any person could set a static IP address on any subnet they chose, and, given our lack of managed switches (at the time we had none, though things are changing), there wasn&#8217;t much of anything I could do about it. On the flip side, the worst that could happen is that these users would get faster internet, hardly the end of the world.

It took ten years, but, finally, someone figured it out. One of our more intelligent students decided that his IP address of 10.10.10.113 didn&#8217;t make a whole lot of sense, given that the gateway is 10.10.1.1. He set his IP to 10.10.1.113, and, _voilà_, his internet speed shot through the roof!

Naturally, he shared his findings with his friends, who managed to keep it under the radar until one of the friends decided to see how well BitTorrent would work with the school internet. What none of these students realized is that the 10.10.1.* subnet was for servers, and, oddly enough, none of our servers uses BitTorrent. The traffic stuck out like a sore thumb, and I finally caught on.

My first step was to blacklist all unrecognized MAC addresses using the server subnet. The next step was more difficult. Now that the cat was out of the bag and everyone knew how to get faster internet, I needed a way to block anybody not using the IP they&#8217;d been assigned through our DHCP server. Obviously, there is a correct way of doing this, but that seems to be using [802.1x][2], and we&#8217;re just not there yet. My quick and dirty solution was to copy the dhcp configuration file containing all the host and IP information to our firewall, and then generate a list of iptables rules that only allow traffic through if the IP address matches the expected MAC address.

The problem with this solution is that it doesn&#8217;t account for the fact that spoofing MAC addresses is actually relatively simple, so it looks like one of my summer projects is going to be a complete revamp of our network. I&#8217;m hoping I can configure our [FreeIPA][3] server to also operate as the backend for a RADIUS server so we can implement 802.1x security.

In this case, the consequences of the &#8220;hack&#8221; for us were pretty insignificant. Students got some extra bandwidth for a while. The students who changed their IP addresses also didn&#8217;t suffer any major consequences. Their devices were blacklisted from the internet until they came to speak with me, and then were put on the guest subnet. All of the students were in their final year, so they were only stuck on the guest subnet for the last month or so.

The most obvious lesson I learned from &#8220;IP-gate&#8221; is that security through obscurity works great&#8230;until someone turns on the light. And when that happens, you&#8217;d better have a plan.

**The Grade-changing Scandal**
  
This was a far messier situation. One of our teachers allowed a student to access their computer to set up a video for class. On the computer, the teacher had saved their login credentials for [LESSON][4], our web-based marking system. While the teacher was distracted, the student used [this trick][5] to find the teacher&#8217;s password, and then shared the password with different members of the class. Throughout the next few days, the class average for that teacher&#8217;s subjects rose at a remarkable rate.

Three days later, one of the students finally told the principal what had happened, and the principal called me. What followed was a day of tying together evidence from multiple sources to work out who changed what and when.

What the students weren&#8217;t aware of was that LESSON logs everything at the assignment level, so I could see which IP addresses changed which assignments. If the IP was an internal school address, I could also see which user changed the assignment. One of the students used their laptop (registered on the network, so I knew who it was) to change some marks, then logged in from a lab computer (so once again, I knew who it was), and then finally logged in from home.

The students who logged in from home were harder to track, at least until they did something foolish, like logging in as themselves to verify that the marks had actually changed ten seconds after logging out as the teacher.

We also do daily backups of the LESSON database that we keep for a full year, so it was a piece of cake to restore all of the marks back to their original scores.

Obviously though, this went much further than the IP-spoofing going in in &#8220;IP-gate.&#8221; This wasn&#8217;t just some kids wanting faster internet, this was a case of flagrant academic dishonesty.

In the end, we came up with the following consequences:

  * The students who masterminded the break-in received a zero for the subject for the term
  * The students who we caught _changing_ the marks received zeros for any assignment of theirs that had a changed mark
  * The students we _knew_ that they knew their marks were changed received three Saturday detentions (they have to sit in complete silence for four hours on a Saturday)
  * The students we _suspected_ that they knew their marks were changed received one Saturday detention, though these students were allowed to appeal, and most who did had their Saturday detention reversed

One of the things I&#8217;ve learned from this is that there&#8217;s never too much audit information. LESSON is going to be changed to record not just who changes each assignment, but who changes each mark, and there will be a history of every changed mark so that teachers can see when marks are changed.

Apart from this, I would be curious as to what others think about the consequences for these two &#8220;hacks.&#8221; Were we too lenient on the first? Too harsh on the second? What should we have done differently? And what should we do differently going forward?

_[Laptop computer locked with chain and padlock][6] by [Santeri Viinamäki][7]. Used under a [CC BY-SA 4.0][8] license._

 [2]: https://en.wikipedia.org/wiki/IEEE_802.1X
 [3]: https://www.freeipa.org
 [4]: https://github.com/lesbg/lesson-1.0
 [5]: http://www.groovypost.com/howto/reveal-password-behind-asterisk-chrome-firefox/
 [6]: https://commons.wikimedia.org/wiki/File:Locked_computer_laptop.jpg
 [7]: https://commons.wikimedia.org/wiki/User:Zunter
 [8]: https://creativecommons.org/licenses/by-sa/4.0/deed.en
