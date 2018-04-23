---
title: Electricity, electricity
author: jdieter
description: I am not an electrician. I do not wish to be an electrician.  This is why.
type: post
date: 2010-07-11T16:26:36+00:00
url: /posts/2010/07/11/electricity-electricity
categories:
  - Computers
tags:
  - electricity
  - lesbg

---
{{< imgproc "spark" Resize "300x" />}}

I am not an electrician. I do not wish to be an electrician. It is not one of my goals in life. Unfortunately, sometimes we have to do the things we don&#8217;t want to do.

On and off over the last couple of weeks, I&#8217;ve been working in our sister school up in the mountains, setting up a network. Their server was so old, it still had a ISA network card. I think they stopped using it sometime last century. Their desktops were a bit better, Celerons with 256MB of RAM.

Our sister school in Tyre offered to donate new equipment, so I&#8217;ve been spec&#8217;ing machines and setting up a _real_ server. Unfortunately, getting the server set up took a bit more effort than I originally expected. You see, power up in the mountains is a bit&#8230;erratic. Four hours on, four hours off, six hours on, six hours off, etc. The school did have a nice, massive UPS (being used to keep the bell system up when the power was off), but the batteries were old car batteries that could only keep the server up for 90 minutes.

So I order four 100aH marine batteries (the UPS is 48V, otherwise I would have gone with two 200aH batteries), receive them, and drive them up the mountain. Once I&#8217;m in the office, I shut off the UPS and unplug the old batteries. After swapping in the new batteries, I start rewiring them all together.

One, two, three batteries and no problems. I reach up to attach the final wire from the UPS to the positive terminal on battery #4 and&#8230; 

**_\*Spaaaaark\*_**

As I said, I&#8217;m not an electrician, but, as I understand it, a spark is a sign that there is a circuit. So I get down next to the UPS and make sure all of the various switches on it are actually off. Then, to be safe, I switch off all of the breakers in the UPS room. I reach up to attach the final wire again, and&#8230;

**_\*Spark\*_**

I call the principal of the school, and she comes down and verifies, that, yes, all of the breakers that power the UPS are off. There is a little red light on the UPS that is on, but rapidly fading. It finally dawns on us that the batteries are charged, and the circuit isn&#8217;t the UPS trying to charge the batteries, but rather the batteries trying to power the UPS. I now remove both of the fuses in the UPS and grab the wire again. 

**_\*Spark\*_**

The stupid UPS always completes the battery circuit, even when all of the switches are off and fuses pulled out! How am I supposed to do this? I call the resident electrical expert who wired our school down in Beirut. &#8220;All the switches are off and fuses out?&#8221; he asks. &#8220;Yes,&#8221; I reply. &#8220;Then you&#8217;ll just have to attach the wire as quickly as possible. The quicker you attach it, the less spark there will be.&#8221;

Famous last words. I tell the principal, &#8220;If I don&#8217;t make it, tell my wife I love her.&#8221; I then say a prayer, psych myself up, and slam the wire onto the battery. 

**_\*Spaaaaaaaark\*_**
  
_\*Huuuuummmmm\*_

The UPS comes to life and I gingerly tighten the wire onto the battery (using a rubber-handled wrench), put the fuses back in, flip the breaker back up, and turn all of the switches on the UPS back on. As I&#8217;m putting in the fuses, I notice a big label, &#8220;Made in Lebanon&#8221;.

Everything back up and running again, I turn to the principal and say, &#8220;If you ever need help with your UPS again&#8230; don&#8217;t call me.&#8221; I am not an electrician. I do not wish to be an electrician.

_Spark credit: [Spark][2] by [Phyzome][3]. Used under [CC BY-SA][4]_

 [2]: http://commons.wikimedia.org/wiki/File:Electrical_spark_from_a_shorted_camera_capacitor_P.2005.04.27.jpg
 [3]: http://commons.wikimedia.org/wiki/User:Phyzome
 [4]: http://creativecommons.org/licenses/by-sa/3.0/
