---
title: How do you rank a sysadmin?
author: jdieter
description: TrueAbility's Linux Showdown review
type: post
date: 2013-09-25T18:49:38+00:00
url: /posts/2013/09/25/how-do-you-rank-a-sysadmin
categories:
  - Computers
tags:
  - competition
  - linux
  - linux showdown
  - sysadmin
  - system administrator
  - TrueAbility

---
{{< imgproc "messy_cables" Resize "200x" >}}Sysadmin at work{{< /imgproc >}}

When I heard about the [4th Linux Showdown][2], sponsored by [TrueAbility][3], I was pretty excited. I&#8217;m a pretty competitive guy, so the idea of competing in a sysadmin&#8217;s challenge sounded like fun.

In the Linux Showdown, you get 30 minutes to complete a certain number of sysadmin tasks. Some of the tasks are pretty simple, while some of the others become more difficult. I entered the first day and managed to get 9th place with a score of 100% and a time of just under 17 minutes.

The second day I ran into trouble. One of the tasks was to reset the mysql root password, and, though I followed the directions [here][4], twice, I was never able to log into mysql as root. The commands seemed to be running correctly, but I was locked out.

In my day-job as the system administrator for a [school][5], I would keep bashing away at the problem until I figured out what I was doing wrong. In the competition, I ran out of time after fifteen minutes of debugging and ended up with a lousy 40%. Ouch!

I was frustrated, but figured the third day&#8217;s competition should fit a bit better. The hint said that it was a scripting competition, and my python foo is pretty decent. Sure enough, day three involved finding files with modification times between two dates, adding them to a database, and then tarring them up.

I came up with a python script that found the necessary files and added them to the database. Except my clever &#8216;INSERT&#8217; statement didn&#8217;t actually work. If I manually copied and pasted it into mysql, it worked perfectly, but it didn&#8217;t run from the script. Grrr. I spent ten minutes debugging&#8230; and my time was up!

Well, that sucked. This time I got an impressive 20%. Double ouch!

After finishing the test, I went to bed and spent fifteen minutes ranting to my poor wife. The next day, after cooling off, I decided I was done. The hint for the last competition said that it had something to do with security, and I wouldn&#8217;t call myself an expert on that. If I&#8217;m getting 20% in the areas that I&#8217;m relatively good at, then what should I expect in areas that I&#8217;m less comfortable with.

Then it hit me. If I&#8217;m not comfortable with it, why not just do it for fun? If I know I&#8217;m probably going to get a zero, who cares? I checked the leaderboard, and the highest score at the time was 67%, so my zero wouldn&#8217;t be so bad. I went ahead and started the last competition.

Step one, secure the mail server. We don&#8217;t run our own mail servers here at the school and I know nothing about postfix, so I spent ten minutes or so Googling for some kind of solution, typed in what I thought was a partial fix, and then decided to give up.

Step two, secure a page on the webserver. This is something I have to do quite often, so I was able to get it done in five minutes or so.

Finally, step three, secure an FTP server. Who still uses FTP? We don&#8217;t! I wasn&#8217;t even sure what the ftp daemon&#8217;s name was, so I ran a &#8216;ps aux | grep ftp&#8217;. This was the only reason that I noticed that the ftp daemon wasn&#8217;t using the config file in /etc, but rather some config file in someone&#8217;s home directory. I did what I thought would secure the ftp server in both config files, and saw that I had a little over two minutes left.

Ok, I could have spent some more time on postfix, but I knew nothing about it, so I decided that I was finished. Worst case, I&#8217;d get 33% for the webserver (which was the only fix I&#8217;d actually tested). Best case, 67% for the ftp server, which I was pretty sure I&#8217;d fixed. If so, I might actually get in the top twenty. So, I logged in to the leaderboard, checked my ranking&#8230; First!??!? With 100%? _What?_

Apparently the random lines from Google that I put into my postfix config had secured it. Pure luck. As I followed the leaderboard for the rest of the day, it became obvious that many people with a lot of experience with apache, postfix and ftp were whipping right through the contest, missing the ftp config file in the home directory, and getting 67%, while I kept sitting on top with the lone 100%. I felt like such a fraud.

Finally, in the last hour before the contest ending, someone else found the solution five minutes faster than I did and got first place. Praise God! I still felt like a fraud, but at least first place was going to someone who knew what they were doing.

So, in four days of competitions, I got the highest score in the areas I was weakest in and the lowest score in the areas I was strongest in. That seems to indicate either that I don&#8217;t know what my strengths and weaknesses are, or that the competition needs some tweaking. Well, I think I&#8217;m at least reasonably aware of my strengths and weaknesses, and I&#8217;m very aware of how much of a role chance played in all four days of competition. So how can this competition be tweaked?

The strengths of the competition are pretty obvious. The whole point of TrueAbility is to winnow out people who talk the talk, but can&#8217;t walk the walk. When you get a résumé, you don&#8217;t know whether the applicant can actually do all the things they claim to be able to do, so, with TrueAbility, you give someone a VM and a list of tasks, and see whether or not they can do them. TrueAbility doesn&#8217;t care _how_ they do the tasks, they just check that the tasks are completed. Brilliant!

The biggest weakness in the competition is the time limit. A vast majority of the problems we face as sysadmins need to be fixed quickly, but rarely does a complex problem need to be solved within 30 minutes. This time limit in the competition introduces a bias against those who work methodically. While hiring fast workers is always nice, basing hiring decisions based on how _fast_ someone can code rather than how _well_ they code is not wise.

In addition, the marking (especially for the last few days) was extremely coarse, so ranking was heavily dependent on how quickly you finished. This was especially noticeable in the first day, where the only difference between 1st place and 28th place was whether you took 10 minutes to finish the job or 30 minutes. As was obvious in the last day&#8217;s competition, this emphasis on time caused people to rush so much that they made mistakes. Time makes a lousy basis for ranking.

So what&#8217;s the solution? I see two complementary things that could be done to improve the competition. The first is to break down the grading even more, and assign different values to the different tasks. I&#8217;d even add in some standard tasks (with a total score of a maximum of 20%) along the lines of &#8220;Make sure that you close any ports not needed for your task&#8221;, &#8220;Disallow password logins over ssh and set up the server to trust your ssh key&#8221;, and &#8220;Replace your Ubuntu install with the _real_ sysadmin&#8217;s OS: Fedora&#8221;. Ok, I&#8217;m half joking on that last one, but you get the idea. The key thing is that it should be almost impossible to get 100%, but a mediocre sysadmin should be able to hit 70% with only minor difficulty, and a talented sysadmin shouldn&#8217;t have much trouble reaching 90%.

The other thing that would help would be a removal of the hard deadline. Instead, allow candidates to continue working beyond the time limit, with a deduction of 1-2% for every minute. This introduces a cost to breaking the deadline without causing the candidate to completely fail because they needed ten more minutes.

With these two adjustments, time should become secondary to doing the job right. If I spend 10 minutes getting 90%, I&#8217;ll still get a lower score than someone who takes their time to do it right in 30 minutes. And, if I spend 40 minutes reaching 90%, I&#8217;ll only lose 20% for going over and end with a score of 70%, rather than sitting at zero because I just couldn&#8217;t finish my script within the deadline.

TrueAbility, thank you for the time and effort you&#8217;ve put into developing the problems for this competition, and thank you for the creative idea of a sysadmin&#8217;s competition in the first place.

And I really want to congratulate those who were able to consistently get high scores under the tough time limits.

Now I&#8217;m off to get some sleep before our first day of school.

_Messy wires credit &#8211; [Cisco Spaghetti][6] by [CHRISTOPHER MACSURAK][7]. Used under the [CC-BY 2.0][8] license._

 [2]: http://trueability.com/linuxshowdown/four
 [3]: https://trueability.com/
 [4]: http://dev.mysql.com/doc/refman/5.5/en/resetting-permissions.html#resetting-permissions-unix
 [5]: http://www.lesbg.com
 [6]: http://www.flickr.com/photos/macsurak/5020598359
 [7]: http://www.flickr.com/photos/macsurak/
 [8]: http://creativecommons.org/licenses/by/2.0/deed.en
