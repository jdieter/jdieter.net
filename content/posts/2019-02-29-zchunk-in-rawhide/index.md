---
title: You can now download zchunk metadata in Rawhide
author: jdieter
description: A year after its creation, zchunk is finally ready for use in Rawhide
type: post
date: 2019-02-19T20:37:20+00:00
url: /posts/2019/02/19/zchunk-in-rawhide
categories:
  - Computers
tags:
  - fedora
  - zchunk
  - dnf

---
{{< imgproc "gears" Resize "300x" />}}

It's been a long push, but the downloading of zchunk metadata is now fully functional in Rawhide.  Included in the next Rawhide push is [libdnf-0.26.0-2.fc30][1], which, when installed, will automatically download zchunk metadata wherever it's available.

It's been a year since I first started working on zchunk, and I'm excited that we've finally managed to get it fully integrated into Fedora's metadata.  I'd like to take the opportunity to express my appreciation to Daniel Mach, Jaroslav Mracek and the rest of the DNF team for reviewing and merging my (quite invasive) patches, Michael Schroeder for extensive critiques and improvements on the zchunk format, Igor Gnatenko for help early on, and, finally, Neal Gompa for working behind the scenes to keep things moving.

 [1]: https://koji.fedoraproject.org/koji/buildinfo?buildID=1213513