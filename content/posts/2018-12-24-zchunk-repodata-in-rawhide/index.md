---
title: Zchunk repodata in Rawhide
author: jdieter
description: Zchunk repository metadata is now available in Fedora Rawhide.
type: post
date: 2018-12-24T16:05:01+00:00
url: /posts/2018/12/24/zchunk-repodata-in-rawhide
categories:
  - Computers
tags:
  - fedora
  - zchunk
  - dnf

---
{{< imgproc "kiwi-chunks" Resize "300x" />}}

In my [last post][1], I mentioned that we were hoping to get Zchunk metadata into Fedora 30, and I am pleased to announce that this feature is ready for preliminary testing.  Last month, Daniel Mach reviewed and accepted the zchunk patches for librepo, libdnf and createrepo_c, and last week Kevin Fenzi turned on zchunk metadata generation in Rawhide.

If you install librepo and libdnf from [my COPR][2] (Rawhide only), you will download zchunk metadata if it's available.  Please note that, at the moment, only ```primary.xml```, ```filelists.xml``` and ```other.xml``` are zchunked.

Once we're convinced that we're not going to break anybody's install, we will see about getting these packages pushed to Rawhide.

### Bugs

There are a couple of current known bugs:

* <s>The current zchunked metadata isn't being compressed with [Fedora's repodata zdicts][3], so ```primary.xml.zck``` and ```other.xml.zck``` are roughly double the size of their gzip counterparts (```filelists.xml.zck``` is about the same size, so overall download size is about 10-15% larger).  We're [looking into this][4], and these sizes should be dramatically smaller once we figure it out.</s> This has been fixed as of December 27th's metadata.  Zchunk metadata is now roughly 10% smaller than the equivalent gzip metadata, excluding any zchunk savings.
* <s>DNF resets the download progress bar multiple times when downloading zchunked metadata, and the final sum isn't accurate.  I believe this is due to how librepo is reporting the zchunk download, and I hope to have a fix soon.</s>This is [fixed here][6].

### Testers wanted

If you are willing to take a risk with your Rawhide system, we'd appreciate some more people kicking the tires and making sure that, at minimum, we haven't broken anything.  To test, download a backup copy of librepo and libdnf, and then install librepo and libdnf from [my COPR][2].   Then install, update or remove packages and verify that it works as expected.  I've tested with dnf, microdnf and PackageKit, but it should work out of the box with anything that uses libdnf as a backend.

If anything goes significantly wrong (i.e. dnf stops working), first try setting ```zchunk=False``` in /etc/yum.conf, and, if that doesn't work, downgrade librepo and libdnf to your backup copies.

If, after enabling this, you run into any new bugs, for the moment please report them in [bugzilla][5] against zchunk (even if it's librepo or libdnf that crash).

**Updated 2018/12/28 as the first bug has been fixed**

**Updated 2019/01/01 as the second bug has been fixed**

 [1]: /posts/2018/10/31/zchunk-update
 [2]: https://copr.fedorainfracloud.org/coprs/jdieter/dnf-zchunk
 [3]: https://pagure.io/fedora-repo-zdicts
 [4]: https://pagure.io/pungi-fedora/issue/679
 [5]: https://bugzilla.redhat.com/
 [6]: https://github.com/rpm-software-management/librepo/pull/138