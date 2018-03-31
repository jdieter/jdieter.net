---
title: On Vacation
author: jdieter
type: post
date: 2014-06-30T21:43:18+00:00
url: /posts/2014/07/01/on-vacation
categories:
  - Personal
tags:
  - deltarpm
  - dieter family
  - family
  - fedora

---
{{< imgproc "14-1" Resize "300x" >}}The rain in Washington{{< /imgproc >}}

On Thursday, my family and I departed beautiful Lebanon and started the long trek (at least as far as sitting in an airplane can be considered trekking) back home to Washington State. We were greeted with some rain when we arrived, which was definitely proof that we were home.

We&#8217;ll be here until the beginning of September, and then it&#8217;s back to sunny Beirut. I&#8217;m looking forward to the kids getting to celebrate the 4th of July for the first time.

I&#8217;m also hoping to get some time to look into making applydeltarpm more efficient. If you&#8217;ve been following the conversation on the [fedora-devel list][2], you&#8217;ll have noticed that, oddly enough, some people don&#8217;t like deltarpms, and the reasons given are definitely valid.

At the moment, recreating an rpm from a deltarpm includes recompressing it so that signatures match, and that recompression is \*very\* expensive in terms of CPU time. If you&#8217;re on a slow computer with decent storage, it might make more sense to rebuild uncompressed rpms, but if we did this, then signatures would no longer match. I&#8217;d like to see if there&#8217;s some way that we can reasonably store the signature of the uncompressed payload as well as the compressed payload in the rpm. Ideally, this will be done in such a way so as to require minimal (if any) changes to the buildsystem.

If I can manage a proof-of-concept that works without too much trouble for the infrastructure guys, then we might just be able to pull off much faster deltarpm rebuilds.

 [2]: http://comments.gmane.org/gmane.linux.redhat.fedora.devel/197488
