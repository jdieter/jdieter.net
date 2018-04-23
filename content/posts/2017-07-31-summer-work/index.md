---
title: Summer work
author: jdieter
description: Some plans for my summer vacation in Washington State
type: post
date: 2017-07-31T08:48:08+00:00
url: /posts/2017/07/31/summer-work
categories:
  - Computers
tags:
  - ceph
  - fedora
  - flock
  - flock 2017
  - glusterfs
  - lizardfs
  - nfs
  - river
  - summer

---
{{< imgproc "img_20170709_201143" Resize "300x" >}}The dog and the river{{< /imgproc >}}

It&#8217;s summer, we&#8217;re in the US, and I&#8217;m thoroughly enjoying the time with my family. It&#8217;s been quite a while since we&#8217;ve seen everyone here, and we&#8217;ve all been having a blast. The one downside (though my wife is convinced it&#8217;s an upside) is that my parents have limited internet, so my work time has been, out of necessity, minimal. It has nothing to do, I assure you, with our beautiful beach on the river.

I have managed to push through a bugfix LizardFS update for Fedora and EPEL, and I&#8217;ve been working on some benchmarks comparing GlusterFS, LizardFS and NFS. I&#8217;ve been focusing on the [compilebench][2] benchmark which basically simulates compiling and reading kernel trees, and is probably the closest thing to our usage pattern at the school (lots of relatively small files being written, changed, read and deleted).

Using NFS isn&#8217;t really fair, since it&#8217;s not distributed, but it&#8217;s still the go-to for networked storage in the Linux world, so I figured it would be worth getting an idea of exactly how much slower the alternatives are. If I can get Ceph up and running, I&#8217;ll see if I can benchmark it too.

In other news, I have the privilege of attending [Flock][3] again this year. I&#8217;m really looking forward to getting a better feel on Fedora&#8217;s movement towards modules, something that I hope to put into practice over the next year at the systems in school.

Hopefully, I&#8217;ll get a chance to get my benchmarks out within the next couple of weeks, and I&#8217;m sure I&#8217;ll have a lot to say about Flock.

 [2]: https://oss.oracle.com/~mason/compilebench/
 [3]: https://flocktofedora.org/
