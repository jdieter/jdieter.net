---
title: Brittle deltas – a possible solution?
author: jdieter
description: Why deltarpms are far more brittle than other compression formats and a potential solution
type: post
date: 2011-02-16T16:58:50+00:00
url: /posts/2011/02/16/brittle-deltas-a-possible-solution
categories:
  - Computers
tags:
  - deltarpm
  - fedora
  - linux
  - xz
  - zlib

---
{{< imgproc "broken_eggs" Resize "300x" left />}}

Deltarpm is brittle. When it works correctly, it&#8217;s brilliant. But, like a tightrope walker crossing the Niagara falls while balancing an egg on his head, all it takes is one slip and&#8230;_\*splat\*_.

At the beginning of the Fedora 15 release cycle, a new version of xz was pushed in which the defaults for compression level 3 were changed (as far as I can tell, to what used to be level 4). This doesn&#8217;t cause any problems for newly compressed data, but if you decompress an rpm whose payload was compressed using old level 3 (like makedeltarpm does) and then recompress it with new level 3 (like applydeltarpm does), the compressed files _no longer match_. _\*Splat\*_.

I wrote about the root problem [here][2] over a year ago, but to summarize: almost no compression algorithms ever guarantee that, over all releases, they will create the same compressed output given the same uncompressed input.

Our fix for Fedora 15 was pretty simple. Delete all of the old deltarpms in Rawhide. As long as the users have the new xz before doing a yum update, all new deltarpms will work correctly. Yay.

The problem is that this is all still extremely fragile. Take Fedora bugs [#524720][3], [#548523][4], and [#677578][5] for example. All three bugs have cropped up because of mistakes in handling changes in the compression format, and it&#8217;s all a bit ridiculous. Would anyone use gzip if an old version couldn&#8217;t decompress data compressed with a newer version?

**A possible solution?**
  
There is no simple solution. So what if we change the rules? Instead of trying to keep the compression algorithms static, what if we stored just enough information in the deltas to recompress using the exact same settings, _whatever they are_.

For gzip, this would mean recording things like each block size, dictionary, etc. For xz, it would mean recording the LZMA2 settings. The problem is that this information is different for each compression type and the functions to extract the needed information haven&#8217;t been included in any compression libraries (to my knowledge).

However, if we could write these functions and get them into the upstream libraries, it would benefit all programs that try to generate deltas. Deltarpm would continue to work when compression algorithms change. Rsync could actually delta gzipped files, even if the &#8220;&#8211;rsyncable&#8221; switch hasn&#8217;t been used in gzip.

There are a couple of possible problems with this solution. First, I&#8217;m not sure how big the extra needed information is. Obviously, for each compression format, it&#8217;s different, but, unless it&#8217;s at most 1/100th the size of the uncompressed file, storing the extra data in the deltarpm will probably not be worth the effort.

Second, no code has actually been written. In an open source world of &#8220;Show me the code&#8221;, this is obviously a major issue. I&#8217;d love to do a reference for one of the simpler compression formats (like zlib), but just haven&#8217;t had the time yet.

Obviously, the best solution would be for the various upstreams to provide the necessary functions, as they understand both their algorithms and what information should be stored. However, most upstreams have enough on their plates without needing extra stuff thrown in from random blogs.

Another good solution would be for someone who is interested in deltas and compression to take on this project themselves. Any volunteers? 🙂

_Broken eggs credit: [Broken Eggs][6] by [kyle tsui][7]. Used under [CC BY-NC-ND][8]_

 [2]: /posts/2009/12/29/deltarpm-problems-part-ii/
 [3]: https://bugzilla.redhat.com/show_bug.cgi?id=524720
 [4]: https://bugzilla.redhat.com/show_bug.cgi?id=548523
 [5]: https://bugzilla.redhat.com/show_bug.cgi?id=677578
 [6]: http://www.flickr.com/photos/wackyland/4454784424/
 [7]: http://www.flickr.com/photos/wackyland/
 [8]: http://creativecommons.org/licenses/by-nc-nd/2.0/
