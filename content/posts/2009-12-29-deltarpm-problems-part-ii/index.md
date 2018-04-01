---
title: Deltarpm problems (Part II)
author: jdieter
type: post
date: 2009-12-29T18:30:53+00:00
url: /posts/2009/12/29/deltarpm-problems-part-ii
categories:
  - Computers
tags:
  - deltarpm
  - fedora
  - presto
  - xz

---
{{< imgproc "crumpled-paper" Resize "300x" />}}

About six weeks ago, I [looked at][2] one of the problems we currently face with deltarpm, that of colored executables.

Today, I want to look at one of the other major problems that we&#8217;ve currently papered over without really fixing. That is compression.

**Background**
  
When we switched over to using xz compression in Fedora 12, we ran into a two problems, one expected and one not. The first problem was that deltarpm didn&#8217;t have to code to handle xz-compressed rpms. That was solved quickly thanks to the work that SUSE developers had already put into handling lzma-compressed rpms. We had to do a little bit of adapting to xz, but it was pretty straightforward and trivial.

The second problem popped up right after the switchover and was completely unexpected. When doing some updates on a Rawhide machine, I [noticed][3] that a number of noarch deltarpms were giving me a checksum error on rebuild (prompting a download of the full rpm). It soon became obvious that xz wasn&#8217;t producing the same compressed files on PPC and x86 machines.

A noarch rpm (one that could be installed on any architecture machine) would sometimes be randomly built on a PPC builder, and a deltarpm for that package would be generated. The deltarpm would be applied on my x86 laptop and the resulting uncompressed data would be identical to the original rpm&#8217;s uncompressed data. However, when that uncompressed data was then recompressed so that we would have the original compressed rpm, it compressed slightly differently, breaking the package signatures.

**The Problem**
  
Most compression formats don&#8217;t guarantee repeatability. They do not promise that the compressed file you generated today will be identical to the compressed file you generate tomorrow. They just promise that you&#8217;ll be able to decompress your file tomorrow.

To understand this, remember that any compression format has a standard (which must always be followed) and an algorithm (which may change slightly). Look at the two following math formulas:

_(1 + 5) / 3 + (3 + 9) / 4_
  
_(3 + 9) / 4 + (1 + 5) / 3_

Though they are different, they still parse to exactly the same result. Now imagine that the formulas are two different compressed files, and the result is the uncompressed file. As far as the compression format is concerned, both compressed files are valid.

The problem is that because deltarpm must rebuild the original compressed rpm, it&#8217;s built on the assumption that compression is repeatable. And the assumption is **mostly** true, mainly because gzip and bzip2 haven&#8217;t made changes to their compression algorithms in years. But xz is a much newer algorithm that is still being fine-tuned.

One advantage of this is that upstream changed xz so it is repeatable across different architectures, fixing the PPC/x86 problem. However, upstream made it very clear that they were _not_ promising repeatability over time. They may change the compression algorithm to improve speed or compression, while still sticking to the standard.

**A Related Problem**
  
This is closely related to another problem we hit when generating deltas: compressed files in rpms.

How many files are stored on the filesystem in a compressed format? All of our man pages, to start with. A lot of game data. And more&#8230;

Guess how good our deltas our of compressed data? Pretty bad, because a small change in an uncompressed file normally creates big changes in compressed files, throwing away the benefit of deltas.

And we can&#8217;t uncompress those files before doing a delta on them because we can&#8217;t guarantee that they will be recompressed to the exact same file (were they compressed with gzip -5? gzip -9? gzip -1?).

**The Current Situation**
  
So where does this leave us? In a bit of a mess with deltarpms if xz does change its compression output. It is a solvable mess, but it&#8217;s still a mess.

We also have lousy deltas if there are any compressed files in the rpm. In many ways, this problem is more immediate.

What we need is some way to recompress data in such a way that guarantees that it&#8217;s identical to the original compressed data&#8230;

 [2]: /posts/2009/11/16/deltarpm-problems-part-i/
 [3]: http://osdir.com/ml/fedora-devel-list/2009-09/msg00438.html
