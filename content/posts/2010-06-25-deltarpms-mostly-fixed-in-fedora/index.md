---
title: Deltarpms (mostly) fixed in Fedora
author: jdieter
type: post
date: 2010-06-25T18:50:47+00:00
url: /posts/2010/06/25/deltarpms-mostly-fixed-in-fedora
categories:
  - Computers
tags:
  - deltarpm
  - fedora

---
{{< imgproc "amoeba" Resize "300x" />}}

As some have noticed, there haven&#8217;t been nearly as many deltarpms in Fedora since about the time Fedora 13 was released. This was a result of a couple of different bugs ([see bug report here][2]).

The first problem, affecting Fedora 13, was that deltarpms were only being created against GA. This meant that you only really benefited from them if it was the first update for that package for Fedora 13.

The second problem, affecting all Fedora releases, was that deltarpms were being deleted after each push. This meant that if you weren&#8217;t downloading your updates very frequently, you would miss a lot of them.

The good news is that both problems should be fixed in today&#8217;s or tomorrow&#8217;s push.

**Edit (7/2/2010):** It looks like the second problem has _not_ been fixed. We&#8217;re still trying to track down the problem.

_Bug credit: [Amoeba][3] by David Patterson and Aimlee Laderman at [Micro*scope][4]. Used under [CC BY-NC][5]_

 [2]: https://bugzilla.redhat.com/show_bug.cgi?id=598584
 [3]: http://www.eol.org/pages/62527#image-2087429
 [4]: http://starcentral.mbl.edu/microscope/
 [5]: http://creativecommons.org/licenses/by-nc/3.0/
