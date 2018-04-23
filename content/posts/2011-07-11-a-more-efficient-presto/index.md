---
title: A more efficient Presto
author: jdieter
description: I've pushed yum-presto-0.7.0 to Rawhide, which fixes most of the small complaints that have built up
type: post
date: 2011-07-11T11:13:32+00:00
url: /posts/2011/07/11/a-more-efficient-presto
categories:
  - Computers
tags:
  - fedora
  - presto

---
{{< imgproc "neb" Resize "104x" />}}

Over the last year or so, I&#8217;ve done very little with the yum plugin [Presto][2]. It&#8217;s done its job and done it reasonably well, but, like water wearing down an ancient monument, there have been a few little complaints that have built up, and it&#8217;s long past time to fix them. I&#8217;ve pushed [yum-presto-0.7.0 to Rawhide][3], which deals with most of the problems.

The [first complaint][4] was that Presto would download the deltarpm metadata even when you were just doing an install. Obviously, deltarpms can&#8217;t accomplish a whole lot when you&#8217;re only doing an install, so downloading the metadata is waste of bandwidth, which, ironically, is what Presto is supposed to prevent. So, now Presto has been fixed so that it only downloads the deltarpm metadata when at least one package is being updated.

This brings us to the [second complaint][5], which is that there&#8217;s not much point in downloading a 800kb deltarpm metadata file when you&#8217;re only updating a 50kb package. Even if the deltarpm is 0 bytes, you&#8217;ve still managed to waste 750kb of bandwidth. The problem is that there&#8217;s no way to see how much the deltarpms will save until Presto has downloaded the deltarpm metadata file, which is what we&#8217;re trying avoid.

So, now Presto checks whether or not the combined size of updated packages in the repository is smaller than the deltarpm metadata. If it is, there is definitely no advantage to using deltarpms, so Presto doesn&#8217;t bother downloading the deltarpm metadata.

There were a [number][6] of other [small bugs][7] [fixed][8] in 0.7.0. Unfortunately, because all of the fixes would be considered enhancements, and given [Fedora&#8217;s update policy][9], I will not be pushing the updated yum-presto to Fedora 14 or 15.

 [2]: https://fedorahosted.org/presto/wiki
 [3]: http://koji.fedoraproject.org/koji/buildinfo?buildID=252023
 [4]: https://bugzilla.redhat.com/show_bug.cgi?id=664864
 [5]: https://fedorahosted.org/presto/ticket/12
 [6]: https://bugzilla.redhat.com/show_bug.cgi?id=678588
 [7]: https://bugzilla.redhat.com/show_bug.cgi?id=677379
 [8]: https://bugzilla.redhat.com/show_bug.cgi?id=572553
 [9]: http://fedoraproject.org/wiki/Updates_Policy
