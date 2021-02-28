---
title: WANPIPE and DAHDI COPR for EL8
author: jdieter
description: Custom build of WANPIPE and DAHDI kmods in a COPR for EL8
type: post
date: 2021-02-28T22:14:54+00:00
url: /posts/2021/02/28/wanpipe-and-dahdi-copr-for-el8
categories:
  - Computers
tags:
  - centos
  - wanpipe
  - dahdi
---

{{<imgproc "telephone" Resize "x300" />}}

At [Spearline](https://www.spearline.com), we have a number of servers around the world with [Sangoma telephony cards](https://www.sangoma.com/telephony-cards/digital), which use the out-of-tree `wanpipe` and `dahdi` kernel modules.  As we've been migrating our servers from [CentOS 6 to SpearlineOS](/posts/2020/10/31/switching-to-ostree), one of the problems we've hit has been the out-of-tree modules don't compile against the EL8 kernels that we use as the base for SpearlineOS.

I've written some patches to fix the compilation bugs and have packaged them up [in a COPR](https://copr.fedorainfracloud.org/coprs/jdieter/slos).  `wanpipe` requires the `dahdi` sources to build, so I've put both sources into one `telephony-kmods` RPM, and then build the separate kmod RPMs from the single SRPM.  We've been using the packages for the last few months without any problems, but, as always, use at your own risk.

Note that the COPR does have our build of Asterisk, with only the modules we require enabled, so if you're using Asterisk, you may want to exclude it from being installed from the COPR.  If there's any interest in using the kmod RPMs without the other packages in the COPR, I could look at splitting them into a separate COPR.  Please email me if you would like me to do this.

[Old Germany telephone](https://commons.wikimedia.org/wiki/File:Old_Germany_telephone.jpg) by Antonis glykas used under the [CC BY-SA 4.0 license](https://creativecommons.org/licenses/by-sa/4.0/deed.en)
