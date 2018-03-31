---
title: Novacom for Fedora
author: jdieter
type: post
date: 2012-04-02T16:01:04+00:00
url: /?p=447
tagazine-media:
  - 'a:7:{s:7:"primary";s:0:"";s:6:"images";a:1:{s:75:"/images/2012/04/webos-logo-bluerq_0.png";a:6:{s:8:"file_url";s:75:"/images/2012/04/webos-logo-bluerq_0.png";s:5:"width";s:3:"550";s:6:"height";s:3:"209";s:4:"type";s:5:"image";s:4:"area";s:6:"114950";s:9:"file_path";s:0:"";}}s:6:"videos";a:0:{}s:11:"image_count";s:1:"1";s:6:"author";s:6:"664943";s:7:"blog_id";s:7:"9493963";s:9:"mod_stamp";s:19:"2012-04-02 16:01:04";}'
categories:
  - Computers
tags:
  - fedora
  - novacom
  - webos

---
[<img src="/images/2012/04/webos-logo-bluerq_0.png?w=150" alt="" title="Open WebOS" width="150" height="56" class="alignleft size-thumbnail wp-image-448" srcset="/images/2012/04/webos-logo-bluerq_0.png 550w, /images/2012/04/webos-logo-bluerq_0-300x114.png 300w" sizes="(max-width: 150px) 100vw, 150px" />][1]

[Novacom][2] is a utility that allows you to connect to a WebOS device via it&#8217;s USB cable. It&#8217;s used by the [WebOS Quick Installer][3] and can also give you direct terminal access to the device&#8217;s OS. In many ways it&#8217;s is comparable to using adb with Android devices.

The one major technical problem novacom has had is that it only worked with libusb-0.x and [did _not_ work with libusb-compat][4]. This meant that, to use novacom on Fedora 15+, you had to download Fedora 14&#8217;s libusb and do some funky library overrides. Since novacom was closed-source, there was no way for us to actually fix the problem.

Last week, HP open sourced novacom, and yesterday, I started looking into package novacom for Fedora. It turns out that the novacom daemon was using libusb to initialize the USB device, but was doing the actual reading and writing using a home-grown implementation. This implementation depended on some private information from libusb that, oddly enough, was completely different (and, as far as I could see, completely unavailable) in libusb-compat.

I [wrote a patch][5] to change novacom so it used the stock libusb read and write functions, and it now works perfectly with both the old libusb and the new libusb-compat. Yay!

I&#8217;ve created bugs [809114][6] and [809116][7] for the package reviews, and I&#8217;ve already got someone to review them (Thanks Mohamed!).

So, in the not so distant future, installing novacom on Fedora should be as easy as &#8220;yum install novacom&#8221;.

 [1]: /images/2012/04/webos-logo-bluerq_0.png
 [2]: https://github.com/openwebos/novacom
 [3]: http://forums.webosnation.com/canuck-coding/274461-webos-quick-install-v4-4-0-a.html
 [4]: http://www.webos-internals.org/wiki/MojoSDK_on_Fedora#Troubleshooting
 [5]: https://github.com/jdieter/novacomd/commit/c4586e80dc6f1a92513b466d8d43748ec733b7fd
 [6]: https://bugzilla.redhat.com/show_bug.cgi?id=809114
 [7]: https://bugzilla.redhat.com/show_bug.cgi?id=809116