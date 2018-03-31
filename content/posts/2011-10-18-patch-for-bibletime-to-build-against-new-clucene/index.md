---
title: Patch for BibleTime to build against new CLucene
author: jdieter
type: post
date: 2011-10-18T17:10:16+00:00
url: /?p=393
categories:
  - Computers
tags:
  - bibletime
  - fedora

---
[<img src="http://cedarandthistle.files.wordpress.com/2011/10/bibletime.png?w=100" alt="Bibletime icon" title="Bibletime" width="100" height="102" class="alignleft size-full wp-image-396" />][1]

Bibletime [hasn&#8217;t worked in Fedora 16][2] since CLucene was updated to version 2.3 because of some changes to CLucene&#8217;s API. I&#8217;ve patched BibleTime so it builds against the newer CLucene. An updated [source rpm is available][3], and the [patch is here][4].

 [1]: http://cedarandthistle.files.wordpress.com/2011/10/bibletime.png
 [2]: https://bugzilla.redhat.com/show_bug.cgi?id=715921
 [3]: http://www.lesbg.com/jdieter/bibletime-2.8.1-2.fc16.src.rpm
 [4]: http://www.lesbg.com/jdieter/bibletime-clucene2.patch