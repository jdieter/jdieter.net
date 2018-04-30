---
title: Introducing zchunk
author: jdieter
description: A file format designed for easy deltas while maintaining good compression
type: post
hidden: true
url: /posts/2018/04/30/introducing-zchunk
date: 2018-04-30T19:03:00+02:00
timeline_notification:
  - 1525104180
categories:
  - Computers
tags:
  - zchunk
  - fedora
  - compression
  - zstd
---

Over the past few months, I've been working on a new file format that's designed to be highly delta-able (is that even a word?), while still maintaining good compression.  This format has been heavily influenced by both [`zsync`][2] and [`casync`][3], but attempts to address weaknesses in both formats.

The problem that I'm trying to fix with this file format is the ridiculous amount of metadata you download every time you check for updates in Fedora.  Most of the data from one day's updates is exactly the same in the next day's updates, but you'll still find yourself downloading over 20MB of metadata.

The solution is to chunk the metadata in such a way that you can download only the chunks that have changed.  `casync` provides exactly this feature, but real-world testing showed a couple of problems.  Because `casync` puts each chunk into a separate file, in a worst-case scenario, you have to download thousands of individual files to rebuild the original metadata file.  The process of initiating each request can be expensive, and in my testing, downloading only the changed chunks took longer than just downloading the full file in the first place.

`zsync` approaches the problem a completely different way, by requiring you to use an rsyncable compression format, splitting it into chunks and then storing the chunk locations in a separate index.  Unfortunately, it also sends separate requests for each chunk that it downloads.

The more I looked at `casync`, the more obvious it became that it's designed for a different use-case and, while close, wasn't quite what I needed.  `zsync` was closer, but is unmaintained and also somewhat buggy.  I decided to start something completely new, and, in a burst of creativity, I called it... *`zchunk`*!

Like `casync` and `zsync`, `zchunk` works using only the standard web protocols, and, like `zsync` (but unlike `casync`), `zchunk` requires that the web server support range requests.  Unlike `zsync`, `zchunk` will happily combine as many range requests as the server supports, which means you can download a large number of separated chunks using a small number of requests.

Unlike `zsync`, `zchunk` is a completely new compression format, and it uses a new extension, `.zck`.  By default, it uses `zstd` internally, but it compresses each chunk separately, so a `.zck` file cannot be decompressed using the `zstd` utilities.  A `.zck` file starts with an index that describes each chunk and its checksum.

The `zckdl` utility will first download just the index of the requested file.  If there's an old version of the file available, `zckdl` will compare the chunk checksums, copy any old chunks that are still in use in the new file, and then download the remaining chunks in as few requests as possible.

A `.zck` file can be decompressed using the `unzck` utility and compressed using the `zck` utility.

`zchunk` also supports the use of a common dictionary to help increase compression.  Since chunks may be quite small, but have repeated data, you can use a `zstd` dictionary to encode the most common data.  The dictionary must be the same for every version of your file, otherwise the chunks won't match.  For our test case, Fedora's update metadata, using a dictionary reduces the size of the file by almost 40%.

So what's the final damage?  In testing, a `zchunk` file with an average chunk size of a few kilobytes and a 100KB dictionary ends up roughly 23% larger than a `zstd` file using the same compression level, but almost 10% smaller than a `gzip` file.  Obviously results will vary, based on chunk size, but `zchunk` generally beats `gzip` while providing 

 [2]: http://zsync.moria.org.uk
 [3]: https://github.com/systemd/casync