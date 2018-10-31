---
title: Zchunk update
author: jdieter
description: Zchunk has been available for almost eight months, and we're working to get Fedora using it for metadata updates
type: post
date: 2018-10-31T20:42:01+00:00
url: /posts/2018/10/31/zchunk-update
categories:
  - Computers
tags:
  - fedora
  - zchunk
  - dnf

---
{{< imgproc "bricks" Resize "300x" >}}Putting it all together{{< /imgproc >}}

### Zchunk 1.0

Eight months ago, I [started working on zchunk][9], and it's now almost ready for its 1.0 release.  Once zchunk 1.0 is released, we will offer a stability guarantee.  Only additions to the API will be allowed, and the ABI will always be backwards-compatible.  All files created by older versions of zchunk will be able to be opened by new versions of zchunk, and files created by newer versions of zchunk will be able to be opened by the old versions.

There is one important caveat to the last item: the zchunk format supports mandatory feature flags.  It is possible that an older version of zchunk doesn't support a certain feature flag, and, if so, that version of zchunk will be unable to open files that contain the new flag.

As of version 0.9.12, zchunk also supports optional feature flags that provide extra information about the zchunk file.  If a newer version of zchunk sets an optional flag, and the file is read by an older version that doesn't recognize that particular flag, it will ignore the optional flag data and continue reading the file.  This feature was requested at [Flock][10] this year, and I'm glad it will be available when zchunk 1.0 is released.

### Coverity coverage and CI

In September, we managed to get Coverity to scan zchunk as part of its open source project support, and managed to [eliminate 15 potential bugs][6] that Coverity identified.  New releases will continue to be scanned by Coverity.  Thanks, Stephen Gallagher, for the suggestion.

I've also setup [a jenkins instance][7] for continuous integration.  Every commit is run through a series of tests to verify that we're not breaking anything.

### Fedora metadata integration

One of the features that we hoped to get into Fedora 29 was [Zchunk metadata][1], creating zchunk-compressed metadata for DNF.  It was a stretch, and we were unable to get the zchunk patches reviewed upstream in time for Fedora 29's release.  The goal now is to get the patches accepted in time for Fedora 30.

We have patches for [libdnf][2], [librepo][3], [createrepo_c][4] and [libsolv][5].  In a point for inter-distribution cooperation, Michael Schroeder from SUSE merged the libsolv patch first, but the other patches are still awaiting review.  Now that Fedora 29 is out the door, I'm hoping we'll be able to get this done quickly.

Unless we hit major problems, I anticipate that Zchunk metadata will be a Fedora 30 feature.  A huge thank you to Neal Gompa and Igor Gnatenko for their help with this.

### Future features

There are a couple of ideas that I have bouncing around in my head for a couple of other places where zchunk might be useful, and I figured I should commit them to (digital) paper here.

##### zchunk-compressed RPMs
Deltarpms offer amazing space savings, but are very limited.  In order to take advantage of a deltarpm, you must not only want a specific new version of the RPM, but also have a specific old version of the RPM installed.  Because zchunk doesn't look at any old versions at compression time, the same zchunk-compressed RPM can be used whatever the old version you have installed (or even if you have no old version installed).

To make this work, we would need to create some new feature flags in zchunk, and it would require some changes in the RPM format itself (the third rail, I know), but it is possible and could provide us with significant download savings without having to generate deltarpms at all.

##### zchunk-compressed container images
This would require that container registries and container management systems both support zchunk, but would allow pull operations to be significantly smaller.  I don't know much about how podman or docker actually pull their images, but I've been pulling updated images over 3G and it's not much fun.

##### Other ideas?
We would welcome ports of zchunk to other languages.  At Flock, a few people were keen on doing a Rust implementation, and I think that's a brilliant idea.

If you have any other ideas for new features (or find a bug), please [create an issue][8].  I won't guarantee that we'll implement your new ideas, but we'll take a look at them and see if they're feasible.  Obviously, pull requests greatly increase the chances that your idea will become part of zchunk.


 [1]: https://fedoraproject.org/wiki/Changes/Zchunk_Metadata
 [2]: https://github.com/rpm-software-management/libdnf/pull/478
 [3]: https://github.com/rpm-software-management/librepo/pull/127
 [4]: https://github.com/rpm-software-management/createrepo_c/pull/92
 [5]: https://github.com/openSUSE/libsolv/pull/270
 [6]: https://scan.coverity.com/projects/zchunk-zchunk
 [7]: https://jenkins.zchunk.net
 [8]: https://github.com/zchunk/zchunk/issues
 [9]: /posts/2018/04/30/introducing-zchunk/
 [10]: https://flocktofedora.org