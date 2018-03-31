---
title: Back to the (i386) bottle
author: jdieter
type: post
date: 2010-12-10T16:49:10+00:00
url: /?p=285
categories:
  - Computers
tags:
  - fedora
  - i386
  - x86_64

---
<figure id="attachment_286" style="max-width: 216px" class="wp-caption alignright">[<img class="size-medium wp-image-286" title="i386-bottle" src="http://cedarandthistle.files.wordpress.com/2010/12/i386-bottle.jpg?w=216" alt="Bottle with 'i386' on it" width="216" height="300" srcset="/images/2010/12/i386-bottle.jpg 723w, /images/2010/12/i386-bottle-217x300.jpg 217w" sizes="(max-width: 216px) 100vw, 216px" />][1]<figcaption class="wp-caption-text"> </figcaption></figure> 

In the spring of my last year at Washington State University, I bought an eMachines M6807, one of the first reasonably-priced laptops with a 64-bit processor in it. I almost immediately installed a 64-bit distribution on it, and then almost immediately went back to 32-bit (if I remember correctly, it had a Broadcom wifi card that could only be used with 32-bit ndiswrapper).

Somewhere around the time the b43 driver came out, I switched back to 64-bit Fedora and, in the two laptops since then, have stuck with it. Until today. When I upgraded from Fedora 13 to Fedora 14, I started running into memory problems, and it finally came to a head today when Firefox, Evolution and Eclipse combined were enough to make my laptop start swapping. Heavily. The hard drive light may be pretty, but watching the desktop sitting unresponsive isn&#8217;t my idea of fun (or of being productive).

I have 3GB of RAM on this laptop. There should be little need for swap, and no thrashing at all. I decided to install Fedora 14 i386 on a second partition and see if it made any difference. Sure enough, with Firefox, Evolution and Eclipse open for several hours, I&#8217;m currently sitting at 815MB used, 2185MB free.

So where do I even start filing a bug on this?

 [1]: http://cedarandthistle.files.wordpress.com/2010/12/i386-bottle.jpg