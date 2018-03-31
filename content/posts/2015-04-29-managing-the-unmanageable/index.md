---
title: Managing the unmanageable
author: jdieter
type: post
date: 2015-04-29T18:37:07+00:00
url: /posts/2015/04/29/managing-the-unmanageable
categories:
  - Computers
tags:
  - lesbg
  - managed switches
  - mikrotik
  - networking
  - switches
  - unmanaged switches

---
{{< imgproc "sisyphus" Resize "300x" >}}Uphill battle{{< /imgproc >}}

When I first started working at [LES][2], sometime in the last century, the computers were networked together using some high-tech gizmos called &#8220;[hubs][3]&#8220;. These hubs would reach a maximum speed of 10Mbps on a good day, if there were only two devices connected and the solar flares were at a minimum.

Time marched on and we upgraded to 10/100Mbps hubs, then 10/100Mbps switches, and then, finally, in the last few years to unmanaged gigabit switches. One of the biggest problems with using unmanaged switches is that the network can be brought to a standstill [using a simple patch cable, plugged into two network sockets][4]. I&#8217;ve become pretty adept at recognizing the signs of a network switching loop (the lights on the switches are flickering like the last few seconds on the timer in _Mission Impossible_, the servers are inaccessible, the teachers are waiting outside my office with baseball bats). One of our network loop <del datetime="2015-04-29T17:14:38+00:00">disasters</del> hiccups even managed to anonymously make it to a site dedicated to technology-related problems.

Over the last month, though, I had lots of small problems that never quite reached the level of crashing the network. Our Fedora systems, connected to the server via NFS, would occasionally freeze for a few seconds, and then start working again. Our accountants, who are running Windows, complained that their connection to the server was being broken a couple of times each day, causing their accounting software to crash. And pinging any server would result in a loss of ten-fifteen packets every ten minutes or so.

I checked our switches for the flicker of death and came up dry. I tried dumping packets from a server on one side of the school to a server on the other side of the school and consistently reached 1Gbps. In desperation, I retipped the Cat6 cable connecting the switches that form the backbone of our network. All to no avail. I decided to wait until evening and then unplug the switches one at a time until I found the problem. The problem disappeared.

The next morning it was back. I had two options. Disconnect the switches one port at a time in the middle of the school day, while teachers, students and accountants are all trying to use the system. Or put in a request for some managed switches and see if they could help us figure out what the heck was going on. Hundreds of irritated users outside my door&#8230; or new kit. It was a hard call, but I went for the new kit.

We started with an [eight-port MikroTik switch/router][5], and, after I tested it for a day, we quickly grabbed a couple more [24-port MikroTik switches][6] (most of our backbone locations have nine or ten ports that need to be connected and MikroTik either does 8 or 24 ports).

After we got the three core locations outfitted with switches, I quickly got messages on the switches pointing to a potential network loop on a link to one of our unmanaged leaf switches in the computer room, which was connected to another unmanaged five-port switch that had apparently had a bad day and decided it would start forwarding packets back through itself.

I replaced the five port switch with a TP-Link five-port router running OpenWRT and, just like that, everything was back to normal.

I am never going back to unmanaged switches again. Having managed switches as our network&#8217;s backbone reduced the time to find the problem by a factor of 10 to 20, and, if we&#8217;d had managed switches all the way through the network from the beginning, we could have zeroed in directly on the bad switch rather than spending weeks trying to work out what the problem was.

So now we&#8217;re back to a nice quiet network where packet storms are but a distant nightmare. Knock on wood.

**_[First Work: Myth of Sisyphus detail #1][7]_ by [AbominableDante][8], used under a [CC BY-NC-ND][9] license**

 [2]: http://www.lesbg.com
 [3]: http://www.connectgear.com/Hubs/GH-T09P.htm
 [4]: http://en.wikipedia.org/wiki/Switching_loop
 [5]: http://routerboard.com/CRS109-8G-1S-2HnD-IN
 [6]: http://routerboard.com/CRS125-24G-1S-2HnD-IN
 [7]: http://abominabledante.deviantart.com/art/First-Work-Myth-of-Sisyphus-detail-1-397220876
 [8]: http://abominabledante.deviantart.com
 [9]: http://creativecommons.org/licenses/by-nc-nd/3.0/
