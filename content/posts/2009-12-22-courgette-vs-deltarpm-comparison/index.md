---
title: Courgette vs. deltarpm comparison
author: jdieter
type: post
date: 2009-12-22T14:59:34+00:00
url: /posts/2009/12/22/courgette-vs-deltarpm-comparison
categories:
  - Computers

---
I keep on getting questions about deltarpm using the courgette algorithm, so I thought I would temporarily put them to rest:

firefox-3.5.4-1.fc12.i686.rpm &#8211; 15M<br/>
firefox-3.5.6-1.fc12.i686.rpm &#8211; 15M<br/>
firefox-3.5.4-1.fc12_3.5.6-1.fc12.i686.drpm (rpm-only deltaprm) &#8211; 434K<br/>
firefox-3.5.4-1.fc12_3.5.6-1.fc12.i686.courgette.bz2 (delta of rpm cpios) &#8211; 426K

Please note that this is *not* a reflection of how courgette would work if it could use its disassembly algorithm on Linux binaries. The problem is that the disassembly algorithm only works with Windows binaries right now. Until courgette is able to do its disassembly-foo on Linux binaries, there will be no real benefit to using courgette in deltarpm.

**Method**
  
For deltarpm:
```
$ makedeltarpm -r firefox-3.5.4-1.fc12.i686.rpm \
  firefox-3.5.6-1.fc12.i686.rpm \
  firefox-3.5.4-1.fc12_3.5.6-1.fc12.i686.drpm
```

For courgette:
```  
$ rpm2cpio firefox-3.5.4-1.fc12.i686.rpm > \
  firefox-3.5.4-1.fc12.i686.cpio
$ rpm2cpio firefox-3.5.6-1.fc12.i686.rpm > \
  firefox-3.5.6-1.fc12.i686.cpio
$ courgette -gen firefox-3.5.4-1.fc12.i686.cpio \
  firefox-3.5.6-1.fc12.i686.cpio \
  firefox-3.5.4-1.fc12_3.5.6-1.fc12.i686.courgette
$ bzip2 firefox-3.5.4-1.fc12_3.5.6-1.fc12.i686.courgette
```

Note: I believe the 8K difference in file size is because the courgette delta doesn&#8217;t contain any of the rpm metadata.
