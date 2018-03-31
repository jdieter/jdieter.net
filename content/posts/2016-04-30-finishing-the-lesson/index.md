---
title: Finishing the LESSON
author: jdieter
type: post
date: 2016-04-30T19:00:31+00:00
url: /posts/2016/04/30/finishing-the-lesson
categories:
  - Computers
tags:
  - lesbg
  - lesson
  - php
  - Python

---
{{< imgproc "lesson_logo" Resize "300x" />}}

At our school, we&#8217;ve been using a web-based marking system called [LESSON][2] for the last twelve years or so. I originally wrote LESSON because I was annoyed with the complexity of using a spreadsheet to deal with both assignments of different weights and absences. It started out as a personal web-based gradebook, written in PHP with all the compromises that implies. I didn&#8217;t use classes, created only a small number of core functions, and made liberal use of copy and paste. My code was a mess of spaghetti that only got worse as time went on. In other words, I wrote a typical PHP website.

During the final half of 2011, I went home to the States on sabbatical, and, when I returned in early 2012, my teaching load was less than normal for the remainder of the school year. One of my goals for the year was a rewrite of LESSON. I had a vision of LESSON 2.0 having a backend written in Python, a well-written web frontend in PHP or Python and an Android client. Using [sqlalchemy][3] and [web.py][4], I came up with [a core backend][5] that automatically generated pages based on the database tables, allowed filtering using URLs, and allowed modules to override the automatically generated pages when necessary. The code was elegant (compared to the old LESSON 1.0 code), resilient and much easier to extend.

Unfortunately, other projects started to take my attention off of the backend, and though I was happy with the core, I never reached the point of even starting to port our current system to the backend. The backend has languished since mid-2012 (coincidentally, when I started teaching my usual load again). There was a small resurgence of commits last October, when I had great intentions of resurrecting the project in preparation for some major work integrating family information, but that rapidly tapered off as other projects took precedence.

Compare that to LESSON 1.0 which has seen more or less continuous development over the last twelve years. This year, I&#8217;ve mainly focused on moving our school registration process over to LESSON, and, more recently, [Telegram][6] integration, but it&#8217;s telling that all that work has been done on LESSON 1.0.

So why does the &#8220;old&#8221; LESSON get all the updates? I think it&#8217;s for the following reasons:

  * **LESSON 1.0 works and works well.** Its code might be a nightmare, but it&#8217;s fast, low-bandwidth and easy to use, even for teachers who have never touched a computer before (and we had a few of those when we first started using LESSON). LESSON has a grand total of two images. Last month, we had 1,009,000 external hits on LESSON with a total bandwidth of less than 2GB. That&#8217;s under 2KB per hit. And, despite multiple student attempts to convince me otherwise, there hasn&#8217;t been a bug in LESSON&#8217;s grading code in years.
  * **New features trump better code.** I am a system administrator, teacher and programmer. Our day-to-day sysadmin emergencies always need to be dealt with before long-term projects and my teaching is definitely next on the list of priorities. When I do have time to work on long-term projects (maybe 10-15 hours a week), new features always have the highest priority. The principal wants to know when he&#8217;ll be able to create a Telegram channel, populate it with all of his teachers, and send them a message. He&#8217;s never asked me when I&#8217;ll be done with LESSON 2.0.
  * **I fell victim to [the second system effect][7].** When developing LESSON 2.0, I spent a lot of time trying to create a system rather than a program. LESSON 1.0 wasn&#8217;t designed to be extensible, but LESSON 2.0 was, complete with the concept of modules and all sorts of other goodies. Unfortunately, these added a level of complexity that made the whole thing more and more difficult to work with.

So where does this leave us? The code for LESSON 1.0 may be ugly, but it works well enough. If I ever get caught up with everything else, I&#8217;ll probably continue working on LESSON 2.0, but for now it&#8217;s on the back burner, and, like anything left on the back burner for too long, it may eventually get thrown out.

 [2]: https://github.com/lesbg/lesson-1.0
 [3]: http://www.sqlalchemy.org/
 [4]: http://webpy.org/
 [5]: https://github.com/lesbg/lesson-backend
 [6]: https://telegram.org/
 [7]: https://en.wikipedia.org/wiki/Second-system_effect
