---
title: A brave new world (of traffic shaping)
author: jdieter
description: Why traffic shaping is important, especially when you have a slow internet link
type: post
date: 2012-02-04T20:01:42+00:00
url: /posts/2012/02/04/a-brave-new-world-of-traffic-shaping
categories:
  - Computers
tags:
  - centos
  - pfsense
  - qos
  - traffic shaping

---
{{< imgproc "traffic" Resize "300x" >}}Traffic through a bottleneck{{< /imgproc >}}

When administering a network of hundreds of computers, phones and tablets that all share a 3 Mbit/s link, one of the more important requirements is some form of traffic shaping. In fact, when you&#8217;re watching your emails download at a cool rate of five words a minute because someone is uploading the complete works of Shakespeare (the Blu-ray edition) onto YouTube, the choice becomes that of traffic shaping or homicide. While homicide is the easy option, unfortunately it has become illegal in most countries, so we have to go with the hard option if we want to avoid jail time.

The idea behind traffic shaping isn&#8217;t that complex. Imagine that each packet you send and receive is a car and your internet connection is the highway. Now, imagine that your highway has no lines painted on it and that every car pushes its way through as fast as possible. If you only have a few cars on the highway, this setup works fine. Traffic gets through as quickly as possible as there&#8217;s no build-up at either end. This is a normal connection with no traffic shaping.

Now, imagine this same highway with a huge amount of traffic. Two words: Traffic jam. Traffic gets backed up at the end of the highway, and, due to the lack of organization, everybody (including the emergency services) has to wait until they&#8217;ve managed to push their way through. Obviously not a very optimal way to organize traffic. This is a normal connection when you&#8217;re uploading or downloading a movie. Everything else slows to a crawl.

The thing is, not all traffic is created equal. In the real world, we&#8217;d like to think that emergency services will be able to make it through any traffic jam quickly, and most of us wish that the truck convoys would get off the road when traffic is really bad. In the same way, some internet traffic depends on being delivered in realtime (think Skype, video conferencing or SSH sessions), while normal traffic should be reasonably fast (think web browsing), and some traffic is best allowed through only when the road is empty (think large downloads or P2P stuff).

Traffic shaping allows us to separate our metaphorical highway into multiple lanes that can expand or shrink depending on need within limits that we set. And in our school, we need _lots_ of lanes. You see, normally you would split your traffic into the three segments listed above, but we want to have our traffic split among teachers, students and guests, with each of their lanes further split in the above segments (realtime, normal, slow).

For the last few years we&#8217;ve used a CentOS 5 box running a customized version of the [Wonder Shaper][2] script to shape our traffic, but (mainly because of my deficiencies) it&#8217;s not quite been the wonder we&#8217;ve been looking for. Slow teacher traffic was put into the fast student lane and a guest watching a YouTube video would slow down the net for everyone else.

After some major problems adopting our Wonder Shaper script to multiple WANs (we have two ISPs, one giving us 2M/1M and the other 1M/512K), I finally decided to look around and see what the alternatives were. [PfSense][3] is something that I had been playing around with and I decided to try its traffic shaping capabilities.

It&#8217;s amazing! You create queues (lanes in our metaphorical highway), and each queue can contain other queues. So we have a teacher&#8217;s queue, a student&#8217;s queue, a guest queue and a few other top level queues. Inside each top-level queue is a set of child queues for realtime, normal and slow internet. For example, our teachers get an average bandwidth of 30% and a maximum bandwidth of 50%. In other words, if our internet connection is being fully utilized, teachers will get 30%. If nobody is on the net at all, teachers can get up to 50%. But, it gets even better. Within these percentages, realtime stuff gets 30% of the teacher&#8217;s bandwidth, normal web stuff gets another 30%, junk (Facebook, YouTube) gets 25% with a hard limit of 60% of the teachers&#8217; maximum bandwidth, and any bulk stuff gets 15% with a hard limit of 30% of the teachers&#8217; maximum bandwidth.

Duplicate the same percentages for the students, and then again for our guests (except they get a lower average bandwidth and much lower maximum bandwidth) and you get the picture. Add in the bandwidth set aside for our servers, and you end up with lane rules that are incredibly complex, but with smoothly-moving traffic that doesn&#8217;t get piled up at either end of the highway. And you didn&#8217;t have to kill anyone to achieve it.

If there&#8217;s interest, I&#8217;ll publish a more technical post including a partial rule list and explain how I got this mess to work with squid (which was necessary for being able to sort the different web destinations into different queues).

 [2]: http://lartc.org/wondershaper/
 [3]: http://www.pfsense.org/
