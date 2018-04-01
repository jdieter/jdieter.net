---
title: Deltarpm problems (Part I)
author: jdieter
type: post
date: 2009-11-16T19:16:08+00:00
url: /posts/2009/11/16/deltarpm-problems-part-i
categories:
  - Computers
tags:
  - deltarpm
  - fedora
  - multilib
  - presto

---
{{< imgproc "broken_bicycle" Resize "300x" />}}

In my [last post][1], I talked a bit about how deltarpm&#8217;s delta algorithm actually works, especially in relation to binary files.

Today, I want to look at one of the real-world problems that has a large effect on the size of some of our deltas.

**Background**

Our problem stems from how RPM deals with multiple arches. All binary files in an RPM are labeled with a &#8220;color&#8221;, that is, the architecture the RPM is built for. When two different arches of the same package are installed and binary files conflict, the binary files whose color matches the system color are the ones that are kept.

For example, let&#8217;s imagine that you install samba-common.x86\_64 on an x86\_64 Fedora installation. You then install samba-common.i686 because some program requires 32-bit libnetapi.so. This isn&#8217;t a problem because the 64-bit version of libnetapi.so is in /usr/lib64 while the 32-bit version is in /usr/lib.

But there&#8217;s no such thing as /usr/bin64, so what about the files installed into /usr/bin by samba-common? Because our system &#8220;color&#8221; is x86_64, the 32-bit /usr/bin executables from samba-common.i686 _never actually get installed_. If you run the file command on /usr/bin/pdbedit, it will tell you that it&#8217;s a 64-bit binary.

**The Problem**

While this is (generally) what you want on your system, it leaves us in a bit of a pickle for deltarpms. One of the requirements of a deltarpm is that it **must** build back perfectly into the original rpm.

Let&#8217;s imagine that we are now wanting to upgrade to a newer version of samba-common.i686 with the only change being a minor typo being fixed in the documentation. (Why you would want to upgrade for that is beyond the scope of this article.)

At first glance, this is an excellent place for a deltarpm. A small change in the documentation should result in a very small deltarpm. But when we try to apply our deltarpm to the currently installed samba-common.i686, we run into a major problem:

_The currently installed 64-bit /usr/bin/pdbedit doesn&#8217;t match the 32-bit /usr/bin/pdbedit we need for our new rpm._

Bam! The delta fails, and yum-presto proceeds to download the full 14MB samba-common.i686 package.

**The Solution**

We became aware of this problem a few years back when 32-bit packages were common in 64-bit installs (this was back in the day when OpenOffice.org was still 32-bit only). We ended up pushing a patch into deltarpm that forces all colored executables not installed into multilib directories to be included in the deltarpm. This way, we never use the locally installed executables and the whole color problem disappears.

**The Tradeoff**

But this leaves us with another problem. We end up losing all delta savings on _any_ binaries in /usr/bin. For samba-common, that&#8217;s 27MB (uncompressed) of binaries that we have to redownload every time we get an update.

Which is exactly the problem that deltarpm is supposed to solve.

**Broken bicycle credit: [unwanted & undesired &#8230; just let it rot][2] by [notsogoodphotography on Flickr][3]. Used under a Creative Commons Attribution 2.0 license.**

 [1]: /posts/2009/11/06/on-binary-delta-algorithms
 [2]: http://www.flickr.com/photos/notsogoodphotography/291373072/
 [3]: http://www.flickr.com/photos/notsogoodphotography/
