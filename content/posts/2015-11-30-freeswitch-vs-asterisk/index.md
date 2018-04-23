---
title: Freeswitch vs. Asterisk?
author: jdieter
description: What are the advantages and disadvantages of using Freeswitch versus Asterisk?
type: post
date: 2015-11-30T20:08:02+00:00
url: /posts/2015/11/30/freeswitch-vs-asterisk
categories:
  - Computers
tags:
  - asterisk
  - freeswitch
  - lesbg
  - voip

---
{{< imgproc "canned-phone-568056_1920" Resize "300x" >}}VOIP of the highest quality{{< /imgproc >}}

We&#8217;ve been experimenting with VOIP in our school, primarily for internal communication.  I&#8217;ve set up both asterisk and freeswitch servers, and have been quite frustrated with the limitations of both.

Asterisk only allows one registration to be connected to each extension.  Yes, there are ways to work around this restriction (for extension 101, set up multiple extensions &#8211; 980101, 981101, 982101, and then set up a ring group 101 that rings those extensions simultaneously), but it&#8217;s an incredibly irritating workaround.

Freeswitch does allow multiple registrations on a single extension, but it has other problems.  Some of our softphones are running over WiFi and we need SRTP for these systems.  Other hardware phones don&#8217;t support SRTP, which, while not ideal, is less of an issue because they&#8217;re connected via a physical link that we have complete control over.  Unfortunately, even with Freeswitch in bridging mode, it refuses to use SRTP on the softphone link, while using no encryption on the hardware phone link.  It&#8217;s either all or nothing.  Which means, during our testing phase, we&#8217;re stuck at nothing.  Lovely.

So should I bail on Freeswitch and switch over to Asterisk?  Stick with Freeswitch and hope that I can work out some way of fixing the SRTP problem?  Or should I just give our staff tin cans attached to Cat-6 cable and tell them that&#8217;s the new VOIP system?
