---
title: The case of the blocked web pages
author: jdieter
type: post
date: 2010-09-27T19:26:26+00:00
url: /posts/2010/09/27/the-case-of-the-blocked-web-pages
categories:
  - Computers
tags:
  - internet
  - isp
  - lesbg
  - linux
  - mac
  - proxy
  - squid
  - tyre
  - web
  - windows

---
{{< imgproc "les_tyre" Resize "300x" >}}LES Tyre{{< /imgproc >}}

One of my fears when I set up the network in Tyre [last year][2] was that I would be called out for emergency repair trips. It&#8217;s an hour and quarter each way on a good day, double that if you hit the traffic wrong. And, for those who don&#8217;t know Lebanese traffic, hitting it wrong often involves an unhealthy rise in blood pressure.

Anyhow, I had mentally prepared for, at worst, one callout a month. Twelve months later, not one single callout. No emergencies. No &#8220;we need you here _now_&#8221; phone calls. The few times there were problems, I&#8217;d talk Dave (their resident computer expert) through them over the phone or get him to set up a reverse ssh tunnel so I could fix them from here.

Last week, that twelve month streak was finally broken. It started off with a phone call.

&#8220;Jonathan, none of our computers can get on the web. I can ssh with no problems, IMAP and POP3 work fine, but web pages only load sporadically, if at all.&#8221;

I talked Dave through checking the school&#8217;s squid proxy and then checked what happened when they bypassed their proxy. Still nothing.

&#8220;Ok, Dave, it&#8217;s obviously a problem with your ISP. Call them up and get them to fix it.&#8221;

The next day, Dave calls me again.

&#8220;The guy from the ISP was just here. He had no problems at all until he put his laptop behind the proxy. So he says it&#8217;s the proxy.&#8221;

Ok, that&#8217;s reasonable enough. Just to test, I have Dave bypass the proxy with his laptop (running Ubuntu), and, sure enough, the web works fine. For a couple of minutes. And then, again, nothing.

&#8220;Dave, if we&#8217;re bypassing the proxy, and you&#8217;re still not getting any web pages, it _must_ be the ISP. Here&#8217;s what we&#8217;re going to do. We&#8217;re going to completely shut the proxy down and bypass it for everyone. That&#8217;s not going to fix the problem, but at least they can&#8217;t blame the proxy.&#8221;

The next day, I get a call again. &#8220;Jonathan, the technician came, and it&#8217;s definitely _not_ them. He connected his laptop straight to the ISP using PPPoE, bypassing the router, and everything worked. He then went through the router, and, again, everything worked. He browsed for 15 minutes, with no problems at all. And here&#8217;s the crazy thing. _All of the Macs and Windows machines are working fine. It&#8217;s only the Linux machines that aren&#8217;t working._&#8221;

Well, that sucks. The school runs Fedora on all of its desktops, the servers run CentOS, and Dave runs Ubuntu on his computer. And _none_ of them can access the web.

At this point, I&#8217;m out of ideas, so I get in my car and head on down to Tyre. Of course, Dave has a meeting up here in Beirut, but he clears everything with the school secretary, and I&#8217;m given access to the router.

The first thing I do is plug my laptop into the network and start browsing the web. Five minutes later, when Google has still failed to load, I finally accept that, yes, there is actually a problem browsing the web.

My next step is to try swapping in another router. Even after setting the username, password, and MAC address, the new router just won&#8217;t connect. I remember what Dave said about the technician plugging straight into Internet ethernet cable and making the connection using PPPoE. So I plug my laptop straight into the cable, setup PPPoE in NetworkManager (which is insanely easy), and, boom, I&#8217;m in, bypassing the router.

I check my emails (using Evolution, connecting over IMAP). Looks great. I open Google. Not so great. I then test a Windows computer that&#8217;s sitting on the desk. Instant web access.

At this point, a bulb finally lights in my brain. Most of the ISPs in this country using transparent caching proxies, as bandwidth is expensive for them too. Could this have to do with their ISP&#8217;s proxy?

I set up my computer to use our server in the States as a proxy. All of a sudden, my web access is working perfectly. It&#8217;s the ISP&#8217;s proxy. There&#8217;s obviously something wrong with how it&#8217;s parsing _any_ requests that come from Linux computers.

I then realize that the Mac and Windows computers started working after we shut down the school&#8217;s proxy&#8230; which was running under Linux. Ouch.

When Dave returns from Beirut, we sit down and talk through the problem. The first step is for me to turn the school proxy back on, and set it to use the US server as a parent proxy. Now, all web traffic is getting routed through the US server, which may not be efficient, but at least works. The next step is for the school to switch ISPs, and we&#8217;re still waiting on that process to finish.

As for me, I&#8217;m still a bit shell shocked. We live in 2010 and an ISP is using a transparent proxy solution that _doesn&#8217;t work with Linux_? My best guess is that we&#8217;re looking at some weirdness in how it&#8217;s parsing TCP packets&#8230; but how?

If anyone ever works out what the explanation is, I&#8217;d sure love to hear it.

**Update (10/02/2010):** A big thank you to all who offered suggestions in the comments. We went down to Tyre for a visit today, and while we were down there, I switched the school&#8217;s proxy back to a direct connection to the web so I could test some of the suggestions. Of course, the web started working correctly immediately. Obviously the ISP fixed whatever it was that they broke (which is good), but they haven&#8217;t explained what went wrong to the school (which isn&#8217;t so good).

Anyhow, if I come up against this again, I&#8217;ll at least have some things to try. Thanks again.

 [2]: /posts/2009/09/27/tyre-computers/
