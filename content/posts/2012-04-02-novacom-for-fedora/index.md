---
title: Novacom for Fedora
author: jdieter
description: Novacom is a utility that allows you to connect to a WebOS device via it's USB cable and is now packaged in Fedora
type: post
date: 2012-04-02T16:01:04+00:00
url: /posts/2012/04/02/novacom-for-fedora
categories:
  - Computers
tags:
  - fedora
  - novacom
  - webos

---
{{< imgproc "webos-logo-bluerq_0" Resize "150x" left />}}

[Novacom][2] is a utility that allows you to connect to a WebOS device via it&#8217;s USB cable. It&#8217;s used by the [WebOS Quick Installer][3] and can also give you direct terminal access to the device&#8217;s OS. In many ways it&#8217;s is comparable to using adb with Android devices.

The one major technical problem novacom has had is that it only worked with libusb-0.x and [did _not_ work with libusb-compat][4]. This meant that, to use novacom on Fedora 15+, you had to download Fedora 14&#8217;s libusb and do some funky library overrides. Since novacom was closed-source, there was no way for us to actually fix the problem.

Last week, HP open sourced novacom, and yesterday, I started looking into package novacom for Fedora. It turns out that the novacom daemon was using libusb to initialize the USB device, but was doing the actual reading and writing using a home-grown implementation. This implementation depended on some private information from libusb that, oddly enough, was completely different (and, as far as I could see, completely unavailable) in libusb-compat.

I [wrote a patch][5] to change novacom so it used the stock libusb read and write functions, and it now works perfectly with both the old libusb and the new libusb-compat. Yay!

I&#8217;ve created bugs [809114][6] and [809116][7] for the package reviews, and I&#8217;ve already got someone to review them (Thanks Mohamed!).

So, in the not so distant future, installing novacom on Fedora should be as easy as &#8220;yum install novacom&#8221;.

 [2]: https://github.com/openwebos/novacom
 [3]: http://forums.webosnation.com/canuck-coding/274461-webos-quick-install-v4-4-0-a.html
 [4]: http://www.webos-internals.org/wiki/MojoSDK_on_Fedora#Troubleshooting
 [5]: https://github.com/jdieter/novacomd/commit/c4586e80dc6f1a92513b466d8d43748ec733b7fd
 [6]: https://bugzilla.redhat.com/show_bug.cgi?id=809114
 [7]: https://bugzilla.redhat.com/show_bug.cgi?id=809116
