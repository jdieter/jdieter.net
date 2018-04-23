---
title: Tyre Computers
author: jdieter
description: Installing LESSON in a new school
type: post
date: 2009-09-27T18:03:54+00:00
url: /posts/2009/09/27/tyre-computers
categories:
  - Computers
tags:
  - fedora
  - lesson
  - linux
  - php
  - tyre

---
I&#8217;ve just spent the last three days setting up LESSON (our web based marking system) at our sister school in Tyre.  In the process, I&#8217;ve learned several things about web applications:

  1. **Make sure to get your database right at the beginning**.  I&#8217;ve been working on LESSON on and off over the last five years, and there are some things that have been added onto it.  Most of the time, I&#8217;ve extended the database in a nice, clean way, but there were a few times where I didn&#8217;t.  I decided to fix these problems before doing a new deployment, and there have been several things I&#8217;ve had to fix as a result.
  2. **Make sure your frontend is modular**.  I seem to have a real problem with writing modular code.  I don&#8217;t know why it is, but my normal tendency is to write One Big Page.  In writing LESSON&#8217;s frontend, I do include things like the header and footer, but I have liberally copied and pasted similar pages rather than abstracting out common functions.  When I changed the database, it took 30 minutes to make the changes to the necessary tables and convert the data.  It took 5 hours to get the frontend back into a semi-working state.  I spent another few hours over the weekend on it.  And I will need to spend even more time over the coming weeks, mainly doing search and replace (with enough issues that much of it is manual).
  3. **Don&#8217;t take shortcuts**.  So, yeah, at some point our school needed a way of checking past days&#8217; attendance.  I was obviously in a hurry to implement it and somehow decided that the fastest way was to create a &#8220;calendar&#8221; table.  This table contained every day from January 1, 2005 (shortly before LESSON was deployed in our school) to January 1, 2065.  When I saw this over the weekend, I almost threw myself over the balcony (five stories up).  I ended up fixing the one(!) page that used this table and running a DROP TABLE.

The good news is that everything seems to have come together with few glitches, and, along with their new Fedora 11 desktop roll-out, Tyre has a great new system.
