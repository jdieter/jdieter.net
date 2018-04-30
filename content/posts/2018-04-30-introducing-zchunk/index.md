---
title: Introducing zchunk
author: jdieter
description: A file format designed for easy deltas while maintaining good compression
type: post
url: /posts/2018/04/30/introducing-zchunk
date: 2018-04-30T22:25:00+03:00
timeline_notification:
  - 1525116315
categories:
  - Computers
tags:
  - zchunk
  - fedora
  - compression
  - zstd
---
{{< imgproc "kiwi-chunks" Resize "300x" />}}

Introducing **zchunk**, a new file format that's highly delta-able (is that even a word?), while still maintaining good compression.  This format has been heavily influenced by both [zsync][2] and [casync][3], but attempts to address the weaknesses (for at least some use-case) in both formats.  I'll cover the background behind this in a later post.

Like casync and zsync, zchunk works by dividing a file into independently compressed "chunks".  Using only standard web protocols, the zchunk utility `zckdl` downloads any new chunks for your file while re-using any duplicate chunks from a specified file on your filesystem.

Zchunk is a completely new compression format, and it uses a new extension, `.zck`.  By default, it uses zstd internally, but, because it compresses each chunk separately, a zchunk file cannot be decompressed using the zstd utilities.  A zchunk file can be decompressed using the `unzck` utility and compressed using the `zck` utility.

Zchunk also supports the use of a common dictionary to help increase compression.  Since chunks may be quite small, but have repeated data, you can use a zstd dictionary to encode the most common data.  The dictionary must be the same for every version of your file, otherwise the chunks won't match.  For our test case, Fedora's update metadata, using a dictionary reduces the size of the file by almost 40%.

So what's the final damage?  In testing, a zchunk file with an average chunk size of a few kilobytes and a 100KB dictionary ends up roughly 23% larger than a zstd file using the same compression level, but almost 10% smaller than the equivalent gzip file.  Obviously, results will vary, based on chunk size, but zchunk generally beats gzip in size while providing efficient deltas via both rsync and standard http.

The [zchunk file format][4] should be considered fixed in that any further changes will be backwards-compatible.  The API for creating and decompressing a `.zck` file can be considered essentially finished, while the API for downloading a `.zck` file still needs some work.

Future features include embedded signatures, separate streams, and proper utilities.

zchunk-0.4.0 is available [for download][5], and, if you're running Fedora or RHEL, there's [a COPR][6] that also includes zchunk-enabled `createrepo_c` (Don't get too excited, as there's no code yet in dnf/librepo to download the `.zck` metadata).

Development is currently on [GitHub][7].

 [2]: http://zsync.moria.org.uk
 [3]: https://github.com/systemd/casync
 [4]: https://github.com/jdieter/zchunk/blob/master/zchunk_format.txt
 [5]: https://github.com/jdieter/zchunk/archive/0.4.0.tar.gz
 [6]: https://copr.fedorainfracloud.org/coprs/jdieter/zchunk/
 [7]: https://github.com/jdieter/zchunk