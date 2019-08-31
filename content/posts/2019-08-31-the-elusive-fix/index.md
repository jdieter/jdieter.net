---
title: Anatomy of a bug
author: jdieter
description: A fix for a zchunk bug has made it worse
type: post
date: 2019-08-31T16:05:20+01:00
url: /posts/2019/08/31/anatomy-of-a-bug
categories:
  - Computers
tags:
  - fedora
  - zchunk
  - dnf

---

{{< imgproc "bug" Resize "300x" />}}

#### DNF not downloading zchunk metadata in Fedora

I'm not sure how many have noticed, but DNF hasn't been downloading zchunk metadata in Fedora since the beginning of this month due to a bug in... well, it's complicated.

Let's start with the good news.  The fact that almost nobody has noticed means that the fallback to non-zchunk metadata is working perfectly.  Fedora is still generating zchunk metadata.  When we get the fix built for Fedora, DNF will automatically go back to downloading zchunk metadata.  And, when that happens, almost nobody will notice (but their metadata downloads will be greatly reduced in size again)

#### So, what happened?

Back in July, a [bug](https://bugzilla.redhat.com/show_bug.cgi?id=1726141) was found in RHEL 8 that caused a crash if zchunk-enabled repos were found.  The bug turned out to be in librepo, where `LRO_SUPPORTS_CACHEDIR` was defined in all recent versions.  This define is used by libdnf to detect whether to ask libsolv and librepo to attempt to use zchunk (libdnf doesn't actually use zchunk itself).  The problem is that RHEL 8's librepo had this defined, but didn't actually have zchunk enabled, which caused Bad Things To Happen™.

The DNF developers quickly settled on an [easy fix](https://github.com/rpm-software-management/librepo/pull/156/files), wrapping the define in an `#ifdef WITH_ZCHUNK` so it would only be defined if zchunk was enabled in librepo.  At least, that's how it was supposed to work.

This fix made it into Fedora and had no noticeable effect until libdnf was rebuilt early this month.  It turns out that the header file with the define is included as is in libdnf.  libdnf wasn't being build with `WITH_ZCHUNK` enabled, so `LRO_SUPPORTS_CACHEDIR` wasn't defined, so libdnf never passed librepo the base cache directory, so librepo can't find the old zchunk files, so librepo downloads the non-zchunk metadata.  Oops.

#### How do we fix it?

There are a couple of ways to fix this.  The method we've [gone with](https://github.com/rpm-software-management/libdnf/pull/777) is to define `WITH_ZCHUNK` in libdnf so `LRO_SUPPORTS_CACHEDIR` is defined once more.  This fix is currently in review, and once it's pushed upstream, we'll try to get libdnf [builds](https://src.fedoraproject.org/rpms/libdnf/pull-request/6) done in Fedora with it included.

Once a libdnf build is pushed out with `LRO_SUPPORTS_CACHEDIR` defined, DNF will once more start downloading zchunk metadata.
