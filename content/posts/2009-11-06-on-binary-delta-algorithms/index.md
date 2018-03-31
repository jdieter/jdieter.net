---
title: On binary delta algorithms
author: jdieter
type: post
date: 2009-11-06T18:49:44+00:00
excerpt: 'Courgette, deltarpm and bsdiff (the tool) are all based on the bsdiff algorithm, which is very efficient.  The problem comes when dealing with binaries.  One small change in the source code will normally result in many small changes through the binary as the locations of pointers change.'
url: /?p=39
categories:
  - Computers
tags:
  - bsdiff
  - courgette
  - deltarpm
  - fedora

---
Yesterday I was reading [this update][1] (warning: still subscriber-only) on the Courgette delta algorithm that will be used by Google to push Chrome updates.

The article focused on potential patent problems with the Courgette method, but also described how the Courgette method works and also suggested that deltarpm (which I maintain in Fedora) could learn from it.

While not wanting to argue that particular point (I would love to get a hold of the code and see how much it would actually help our deltarpms), I do want to correct a couple of misconceptions about deltarpm.

Courgette, deltarpm and bsdiff (the tool) are all based on the bsdiff algorithm, which is very efficient. The problem comes when dealing with binaries. One small change in the source code will normally result in many small changes through the binary as the locations of pointers change.

(In the graphs provided, location two is a byte of data that has changed, while locations 3-6 and 21-24 represent two relative jump pointers to the same location. In the new binary, the location has changed by 74 bytes.)

The first graph is that of a naive delta using the bsdiff algorithm.
  
<img src="http://cedarandthistle.files.wordpress.com/2009/11/binary_sequence-normal-delta1.png?w=400" alt="A graph showing naive delta using bsdiff algorithm" title="Naive bsdiff" width="400" height="210" class="alignnone size-full wp-image-43" srcset="/images/2009/11/binary_sequence-normal-delta1.png 1121w, /images/2009/11/binary_sequence-normal-delta1-300x158.png 300w, /images/2009/11/binary_sequence-normal-delta1-768x404.png 768w, /images/2009/11/binary_sequence-normal-delta1-1024x538.png 1024w" sizes="(max-width: 400px) 100vw, 400px" />

Note that the delta is four bytes of not-very-compressible data (out of 12). Not so great.

The second graph is roughly what courgette does with the same data. It does some disassembly to convert the relative pointers into labels. When applying the delta, courgette will disassemble the old file, apply the delta, and then reassemble the resulting not-quite-machine code into machine code.

<img src="http://cedarandthistle.files.wordpress.com/2009/11/binary_sequence_courgette1.png?w=400" alt="A graph of the bsdiff algorithm using courgette for assembly/disassembly" title="bsdiff with courgette" width="400" height="407" class="alignnone size-full wp-image-45" srcset="/images/2009/11/binary_sequence_courgette1.png 1123w, /images/2009/11/binary_sequence_courgette1-295x300.png 295w, /images/2009/11/binary_sequence_courgette1-768x782.png 768w, /images/2009/11/binary_sequence_courgette1-1006x1024.png 1006w" sizes="(max-width: 400px) 100vw, 400px" />

Note that we&#8217;re down to a one-byte delta! Wonderful!

Now, the final example is how both the bsdiff tool and deltarpm work. They use the algorithm Colin Percival describes [here][2] which has an interesting twist when dealing with binaries.

When the locations change in a binary, they tend to do so in a consistent way. As deltarpm is doing its comparison, it adds an extra step. If less than half of the bytes in a segment have changed, deltarpm will do a byte-wise subtraction of the old binary&#8217;s bytes from the new binary&#8217;s bytes. This is then stored in an &#8220;add block&#8221;, which will mostly contain zeros.

<img src="http://cedarandthistle.files.wordpress.com/2009/11/binary_sequence_deltarpm.png?w=400" alt="This graph shows a bsdiff using the add block algorithm" title="bsdiff with add block" width="400" height="224" class="alignnone size-full wp-image-42" srcset="/images/2009/11/binary_sequence_deltarpm.png 1120w, /images/2009/11/binary_sequence_deltarpm-300x168.png 300w, /images/2009/11/binary_sequence_deltarpm-768x431.png 768w, /images/2009/11/binary_sequence_deltarpm-1024x574.png 1024w" sizes="(max-width: 400px) 100vw, 400px" />

While this does give us a block the size of the old binary, this block is very highly compressible (especially using bzip2).

While we may not be getting the compression levels that we might using courgette, we are doing far better than we would be using a naive bsdiff algorithm.

While courgette obviously has the advantage of size, it&#8217;s primary disadvantage is that it is very archicture-specific. The algorithm must know how to both assemble and disassemble binaries for each architecture it&#8217;s built for.

The advantage of the &#8220;add block&#8221; method is that it is generic to all architectures, but its disadvantage is that it won&#8217;t reach the same delta levels as courgette.

Having said that, I still haven&#8217;t had a chance to do any direct comparisons, which may tell us how much better courgette is than deltarpm.

(**Updated:** Tried to make it clear that bsdiff (the tool) doesn&#8217;t just use a naive bsdiff algorithm)

 [1]: http://lwn.net/Articles/359939/
 [2]: http://www.daemonology.net/papers/thesis.pdf