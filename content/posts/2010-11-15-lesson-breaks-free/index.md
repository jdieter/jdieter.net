---
title: LESSON breaks free
author: jdieter
type: post
date: 2010-11-15T11:19:15+00:00
url: /?p=272
categories:
  - Computers

---
<figure id="attachment_273" style="max-width: 225px" class="wp-caption alignright">[<img class="size-medium wp-image-273" title="Which way? Both!" src="http://cedarandthistle.files.wordpress.com/2010/11/confused-sign.jpg?w=225" alt="Sign pointing left and right" width="225" height="300" srcset="/images/2010/11/confused-sign.jpg 768w, /images/2010/11/confused-sign-225x300.jpg 225w" sizes="(max-width: 225px) 100vw, 225px" />][1]<figcaption class="wp-caption-text">Which way? Both!</figcaption></figure> 

Seven years ago, I got pretty annoyed with keeping my students&#8217; computer grades in a spreadsheet, so I wrote a small web application tied to a MySQL database. Over the last few years, this program, called the Lebanon Evangelical School Scoring Online Network, or LESSON (yes, I know the name is ugly, but I like the acronym), has grown to the point that it&#8217;s being used by two of our sister schools and is used by parents to see how their kids are doing in realtime (or something close to it).

One of the early requirements was that LESSON would run \*fast\*, which meant that it had to be run internally (our internet just isn&#8217;t fast enough for it to run externally). We do have a static IP address, so we allowed external access to LESSON, but it was designed to be primarily accessed from within school.

In the wake of [Firesheep][2]&#8216;s release, I decided (rather belatedly) that LESSON should be running completely under https. It only took a few minutes to set up the appropriate Apache configuration, but within a day, the complaints started pouring in. &#8220;LESSON is too slow.&#8221; &#8220;It took me three minutes to log in!&#8221; &#8220;What did you do to LESSON?&#8221;

Well that&#8217;s not cool. It turns out that establishing a https connection requires far more bandwidth and a few more round-trips then a normal http connection. Our bandwidth is no longer enough to make accessing LESSON reasonable.

We can&#8217;t increase our bandwidth (long story, but we&#8217;re maxed out at 128/875kbps). I don&#8217;t want to go back to an insecure connection. But I can&#8217;t leave LESSON unusable.

After I bit of research, I found that MySQL supports [master/master replication][3]. We do have a dedicated server running in the States, so, after making [some changes][4] to make sure that I wouldn&#8217;t have conflicting keys if the the servers lost connection, we were up and running.

And, not a minute too soon. Within a few hours of LESSON going live on our US server, we lost our internet here for roughly 24 hours. When we finally got it back, within two minutes our local master had synchronized the changes from the US server (and vice versa). As far as anyone outside of school was concerned, LESSON was running faster than ever before (when it would have normally been unavailable). And inside of school, LESSON is still as fast as it&#8217;s ever been.

_Signs credit: [Slightly confusing signs][5] by [Dano][6]. Used under [CC BY][7]_

 [1]: http://cedarandthistle.files.wordpress.com/2010/11/confused-sign.jpg
 [2]: http://codebutler.github.com/firesheep/
 [3]: http://www.howtoforge.com/mysql_master_master_replication
 [4]: http://www.howtoforge.com/mysql_master_master_replication#comment-12927
 [5]: http://www.flickr.com/photos/mukluk/241256203/
 [6]: http://www.flickr.com/photos/mukluk/
 [7]: http://creativecommons.org/licenses/by/2.0/deed.en