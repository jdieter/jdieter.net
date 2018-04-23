---
title: Canon copier/printer on Fedora
author: jdieter
description: How to print straight to a Canon copier in Fedora
type: post
date: 2014-05-31T20:59:33+00:00
url: /posts/2014/05/31/canon-copierprinter-on-fedora
categories:
  - Computers
tags:
  - canon
  - fedora
  - printer

---
{{< imgproc "copy-machine" Resize "300x" />}}

_&lt;tl;dr&gt;
There is a decent cups print driver for Canon copiers if you don&#8217;t mind using proprietary software and making some manual changes
&lt;/tl;dr&gt;_

Recently, our school got a couple of Canon [copy machines][2] that can be configured as network printers, but up until a month ago we only used them as copy machines. Last month, I started the process of getting them configured to print using [CUPS][3], and, in the process, learned a bit about the printers and a lot about how CUPS works.

The first problem I ran into is that Canon&#8217;s printer drivers aren&#8217;t open source, which led to some crazy problems finding the correct drivers. It turns out that Canon produces two cups print drivers, the [first][4] which prints using Canon&#8217;s proprietary UFR-II, and the [second][5] which prints using PCL or PXL. Both drivers are a pain to find, but once found, install in a halfway-reasonable way.

I was interested to find that the UFR-II driver left some odd shading any time I printed a graphic. The cups test page had a weird gradient in the middle where I&#8217;ve never seen a gradient before, and PDFs would print with the same strange gradient. The PCL/PXL driver also had the gradient, but, after mixing a few options (Image Refinement &#8211; On, Line Refinement &#8211; On, Halftones &#8211; High HighResolution), it almost completely disappeared.

The other nice thing about the PCL/PXL driver is that it&#8217;s actually mostly using the built-in (open source) tools already available in cups, and the only proprietary parts (at least as far as I can see) are the PPD itself and a small program that adds the extra print options (like double-sided printing, stapling, etc) to the PCL print job. Given all that, I figured there wasn&#8217;t much point in sticking with the UFR-II driver, and started working with the PCL/PXL driver.

However, on using the driver, I ran into some other strange problems. The first was that the cups page log didn&#8217;t actually show any information on some of the print jobs. After poking at the PPD, I discovered that if an incoming job is PDF, the print driver can&#8217;t count the pages, while if it&#8217;s PostScript the driver can. That was an easy fix. To force cups to convert incoming PDF jobs into PostScript before passing them to the driver, in the PPD delete the following lines:
  
```
*cupsFilter:       "application/vnd.cups-pdf 0 foomatic-rip"
*cupsFilter:       "application/vnd.apple-pdf 25 foomatic-rip"
```

The second problem was a bit more subtle. Let&#8217;s imagine that I want to print a four-page test&#8230; 30 times, because I have 30 students in my class. I go to the print dialog, select the staple option, ask for 30 copies, and send it to print. Out of the copier come 120 pages&#8230; and one staple. The Canon driver will only staple it once because it&#8217;s one job. Because, obviously, if you&#8217;re printing 30 copies of the same job, you must want them to be stapled together.

Fortunately, the Canon driver does support an extra &#8220;Repeat job&#8221; count that you can use in place of the copy count. If you set the &#8220;Repeat job&#8221; count to 30 and leave the copy count at 1, it will print 30 four-page tests, with each test stapled separately. Unfortunately, this feature is in the advanced settings, while the copy count is sitting right there in the print dialog.

So I wrote a [wrapper script][6] for the Canon driver that automatically sets the &#8220;Repeat job&#8221; count to the copy count, and then sets the copy count to 1. Now the teachers can turn on stapling and set the copy count to whatever they want, and it will print as expected. You do have to change the `*FoomaticRIPCommandLine` line to say:
  
```
*FoomaticRIPCommandLine: "sicgsfilter-autonumpages &user; &quot;&title;&quot; &quot;%A&quot; &quot;%B&quot; &quot;%C&quot; &quot;%D&quot; &quot;%E&quot; &quot;%F&quot; &quot;%G&quot; &quot;%H&quot; &quot;%I&quot;"
```

I also went to the trouble of stripping out a bunch of unused options from the PPD, to make sure that they don&#8217;t appear when the teachers are going through the print options.

So now we have Canon copiers that are functioning great as printers, and our teachers love it!

 [2]: http://www.usa.canon.com/cusa/office/products/hardware/multifunction_printers_copiers/imageRUNNER_ADVANCE_Series_Models/imagerunner_advance_6255
 [3]: https://www.cups.org/
 [4]: http://support-au.canon.com.au/contents/AU/EN/0100270808.html
 [5]: http://software.canon-europe.com/software/0044084.asp?model=
 [6]: http://lesloueizeh.com/jdieter/sicgsfilter-autonumpages
