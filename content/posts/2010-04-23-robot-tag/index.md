---
title: Robot Tag
author: jdieter
description: Our robot club had robots playing "Robot Tag" on the stage during our school's 150th anniversary celebrations
type: post
date: 2010-04-23T20:06:19+00:00
url: /posts/2010/04/23/robot-tag
categories:
  - Computers
tags:
  - fedora
  - lego
  - lesbg
  - mindstorms
  - nxc
  - nxt
  - robots
  - StopTask

---
{{< imgproc "150years" Resize "500x" none />}}
  
The Lebanon Evangelical School for Boys and Girls is celebrating its 150th anniversary, and, today, as part of the festivities, we had an exhibition of our students&#8217; work, followed by a &#8220;Lebanese Night&#8221; (which still seems to be going strong, judging by the music blasting through my living room windows).

Our robot club had robots playing &#8220;Robot Tag&#8221; on the stage. The idea of &#8220;Robot Tag&#8221; is that you have two robots inside of an arena that chase each other, while being careful not to cross the white lines that mark the border of the arena. A robot &#8220;tags&#8221; the other robot when it uses the ultrasonic sensor to detect that it&#8217;s within 20cm of it (though, given the small size of the robots, it normally gets closer than that before the ultrasonic sensor says that it&#8217;s within range).

{{< imgproc "robotag1" Resize "500x" none />}}

It was quite a hit with both students and parents, and I was very pleased with how well the robots did, especially given the problems I ran into getting everything set up. But that&#8217;s a LONG story&#8230;

{{< imgproc "robotag2" Resize "500x" none />}}

**The LONG story**
  
At the beginning of the year, our principal bought three [LEGO Mindstorms Golfbots][4], and I started a robotics club with a few of my students. It started out with a couple of older students, and then expanded when a few of my eighth-graders got interested, and then one of my seventh-graders.

We started by making the robots a bit like remote-control cars using [nxt_python][5] and the bluetooth on my laptop. We then moved on to actually writing programs that executed on the robots using [NXC][6].

About six weeks ago, the principal asked me to put together something for the exhibition using the robots. I brainstormed with my students, and we came up with the idea of &#8220;Robot Tag&#8221;.

The only reasonable way to make something like this work is to have multiple threads (called tasks in NXC), and, since my students are still very much beginners when it comes to programming, I decided to put together a library to do the heavy lifting, while letting them write the procedures that would determine the robot&#8217;s strategy.

I decided to go with a four-thread design:

  1. A bluetooth thread in which the two robots communicate which is &#8220;it&#8221; and which isn&#8217;t.
  2. A light sensor thread, which determines when the robot has crossed the white line, and does the necessary work to get the robot back into the arena.
  3. A &#8220;check it&#8221; thread that checks whether the robot has tagged the other robot or been tagged by the other robot and starts and stops the appropriate student threads.
  4. One of four control threads.

The control threads are:

  1. _it_ &#8211; the thread run while the robot is &#8220;it&#8221;.
  2. _notit_ &#8211; the thread run while the robot is not &#8220;it&#8221;.
  3. _run_ &#8211; the thread run when the robot has just tagged the other robot, before _notit_ is run. It&#8217;s only purpose is to turn the robot around.
  4. _wait_ &#8211; the thread run after a robot has been tagged. This thread should only spin the robot around or flash its lights or the like. It will automatically be stopped after 10 seconds, and _it_ will be run.</li> </ol> 

The beauty of this design is that my students don&#8217;t have to understand the concept of semaphores, mutexes (mutexi?), or even threads. They get to write four separate procedures, only one of which will be running at any time. Their threads will be automatically stopped whenever the robot crosses the white line, tags the other robot, or gets tagged itself. I thought it sounded very elegant. Unfortunately, reality got in the way.

You see, this whole design is dependent on the ability to start and stop threads at will. And, though NXC does have StartTask() and StopTask() functions (the latter only works if you&#8217;re running the NXC Enhanced firmware on your robots), I ran into a couple of rather&#8230; strange&#8230; problems. First, StopTask() doesn&#8217;t work at all with the Enhanced NXC 2.0 firmware (v1.28), which I later found out is because of a change in how NXC deals with the Wait() function.

When I figured this out, I thought, &#8220;No problem, I&#8217;ll just install the latest enhanced 1.0x firmware.&#8221; And, sure enough, StopTask() did work fine under the 1.05 firmware&#8230; most of the time. And therein lies the problem. It&#8217;s very difficult to work with a function that only works &#8220;most&#8221; of the time, especially when there&#8217;s no way to see whether a thread is running or not. It was very interesting to watch two robots playing tag when one would suddenly decide to ignore little niceties like staying in the arena. You could almost hear the other robot saying, &#8220;Wait, that&#8217;s not how you&#8217;re supposed to play!&#8221;

In the end, I had to write my own solution, which sledgehammered the problem. I decided that each thread would be running all the time (bypassing StopTask() completely), but that the motors would only respond to the tasks that were supposed to be &#8220;on&#8221;. I wrote a wrapper for every motor and sound function that would ensure that the motor would ignore any commands from any tasks that were officially &#8220;stopped&#8221;.

So, after weeks of working on something that should have only taken a few days, I finally got the library finished and the students were able to write their procedures. They did an excellent job and came up with very creative ways of getting their robot in close enough to the other robot to tag it.

The code for my library is available [here][7]. You must create `user.h` which will contain the four user tasks. See `user.h.example` for help. To compile, all you should need to do is write `nbc -S=usb -d -safecall tag.nxc`. You will need two NXT robots connected via bluetooth to make it work.

 [4]: http://www1.lego.com/education/search/default.asp?l2id=0_1&page=7_1&productid=9797
 [5]: http://home.comcast.net/~dplau/nxt_python/
 [6]: http://bricxcc.sourceforge.net/nbc/
 [7]: http://www.lesbg.com/jdieter/tag-2.0.tar.gz
