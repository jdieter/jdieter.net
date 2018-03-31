---
title: I hate virtual machines (was I hate NFS)
author: jdieter
type: post
date: 2009-10-27T18:46:30+00:00
url: /?p=35
categories:
  - Computers
tags:
  - centos
  - fedora
  - linux
  - nfs
  - virtual server

---
(Please note that you&#8217;ll probably want to read the previous post before this one)

So, I set up a new virtual machine running Fedora rather than CentOS 5.4 and migrated the services over to it. We did see an improvement, but just not enough. I went into the computer room during break, and several students had gray screens for Firefox and OpenOffice.org.

So I&#8217;ve switched us back over to the original configuration (running NFS off of the real servers). I have to admit that I&#8217;m quite curious as to what the load will be tomorrow when everyone logs in.

Thanks to those who commented on my last post. The general consensus seems to be that this just isn&#8217;t the best area to use a virtual machine.

EDIT:
  
We&#8217;ve been running the new system for a few days now and it&#8217;s much more responsive. Logins never take longer than 30 seconds, and none of the students are getting gray windows. Load during breaks now ranges from 7 to 20. I&#8217;d still love to see a much lower load, but at least we&#8217;re back to a reasonably fast system.