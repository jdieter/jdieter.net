---
title: Patch for BibleTime to build against new CLucene
author: jdieter
description: I've patched BibleTime so it builds against the newer CLucene
type: post
date: 2011-10-18T17:10:16+00:00
url: /posts/2011/10/18/patch-for-bibletime-to-build-against-new-clucene
categories:
  - Computers
tags:
  - bibletime
  - fedora

---
{{< imgproc "bibletime" Resize "100x" left />}}

Bibletime [hasn&#8217;t worked in Fedora 16][2] since CLucene was updated to version 2.3 because of some changes to CLucene&#8217;s API. I&#8217;ve patched BibleTime so it builds against the newer CLucene. An updated [source rpm is available][3], and the [patch is here][4].

 [2]: https://bugzilla.redhat.com/show_bug.cgi?id=715921
 [3]: http://www.lesbg.com/jdieter/bibletime-2.8.1-2.fc16.src.rpm
 [4]: http://www.lesbg.com/jdieter/bibletime-clucene2.patch
