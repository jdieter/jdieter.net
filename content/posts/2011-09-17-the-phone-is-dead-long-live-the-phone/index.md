---
title: The phone is dead, long live the phone
author: jdieter
type: post
date: 2011-09-17T06:54:01+00:00
url: /?p=383
tagazine-media:
  - 'a:7:{s:7:"primary";s:59:"http://cedarandthistle.files.wordpress.com/2011/09/veer.png";s:6:"images";a:2:{s:59:"http://cedarandthistle.files.wordpress.com/2011/09/n900.jpg";a:6:{s:8:"file_url";s:59:"http://cedarandthistle.files.wordpress.com/2011/09/n900.jpg";s:5:"width";s:3:"500";s:6:"height";s:3:"389";s:4:"type";s:5:"image";s:4:"area";s:6:"194500";s:9:"file_path";s:0:"";}s:59:"http://cedarandthistle.files.wordpress.com/2011/09/veer.png";a:6:{s:8:"file_url";s:59:"http://cedarandthistle.files.wordpress.com/2011/09/veer.png";s:5:"width";s:3:"660";s:6:"height";s:3:"880";s:4:"type";s:5:"image";s:4:"area";s:6:"580800";s:9:"file_path";s:0:"";}}s:6:"videos";a:0:{}s:11:"image_count";s:1:"2";s:6:"author";s:6:"664943";s:7:"blog_id";s:7:"9493963";s:9:"mod_stamp";s:19:"2011-09-17 06:54:01";}'
categories:
  - Computers
  - Personal
tags:
  - hp
  - linux
  - n900
  - nokia
  - touchpad
  - touchstone
  - veer

---
[<img src="http://cedarandthistle.files.wordpress.com/2011/09/n900.jpg?w=200" alt="Nokia N900" title="N900" width="200" height="155" class="alignleft size-medium wp-image-384" srcset="/images/2011/09/n900.jpg 500w, /images/2011/09/n900-300x233.jpg 300w" sizes="(max-width: 200px) 100vw, 200px" />][1]

**The phone is dead**
  
I bought my first smartphone, a [Nokia N900][2], just before Christmas, 2009. Chosen because its OS was the closest thing to a stock Linux distro I could find, the N900 has stood me in good stead for the last almost two years. I&#8217;ve used it to ssh into servers and restart failed services, stream video from a LEGO robot to my laptop, and Skype my family in the States while I was in Lebanon (if I remember correctly, it was the first smartphone to include Skype, though I may be wrong).

So fast-forward to a few weeks ago, with me sitting at my home in southwest Washington, enjoying my [sabbatical][3]. I glanced down at my phone and noticed something strange: The phone signal bar was gone, and in its place was a funky symbol that I finally realized was a SIM card with a red line through it. Restarting the phone fixed the problem. But over the next few days, the red SIM of death (RSOD) appeared more and more often and I finally reached the end of my rope.

Some research on the web, and a `dmesg` or two later revealed that the phone&#8217;s modem was constantly resetting, and, given the reset rate, was probably going bad. As I bought the phone in the US, it only had a one year warranty&#8230; and I was screwed. Bummer. Less than two years after buying it, my $550 phone had become an expensive unimpressive tablet. Thanks, Nokia. And now I had to replace it. 

[<img src="http://cedarandthistle.files.wordpress.com/2011/09/veer.png?w=224" alt="" title="Veer" width="224" height="300" class="alignright size-medium wp-image-388" srcset="/images/2011/09/veer.png 660w, /images/2011/09/veer-225x300.png 225w" sizes="(max-width: 224px) 100vw, 224px" />][4]

**Long live the phone**
  
During the [HP Touchpad][5] firesale, I managed to get ahold of one, and was really impressed by its ease of use, especially when it comes to multitasking. So I went to see what kind of WebOS phone I could get for cheap, and came up with the [HP Veer][6]. I managed to get it and a [touchstone][7] for just over $100, including shipping.

So far, I&#8217;ve been fairly impressed with it. Like Android, WebOS uses the Linux kernel, but not much of the higher stack. It doesn&#8217;t use X or any of the other standard applications that make up a normal Linux distro. Having said that, WebOS has strengths of its own. The N900 was great at multitasking, but the Veer takes it to a new level. WebOS&#8217;s card interface is not only easy to use, but also quite fun. There&#8217;s community-created software available from [preware.org][8], and I&#8217;ve managed to overclock both the Touchpad and the Veer.

My main annoyance with the Veer is that it can sometimes be a bit unresponsive; I&#8217;ll tap the hang up button and it will flash, I&#8217;ll tap it again and it will flash again, but it won&#8217;t hang up until the third or fourth tap. I can understand that it may be thinking, but I find it a bit annoying to have the phone act like it received the event and then ignore it.

The most common complaint you&#8217;ll hear about the Veer is that it&#8217;s too small. And it is small, very small. But I&#8217;ve got small hands, so I don&#8217;t find the keyboard hard to use, and they do make good use of the space they&#8217;ve got on the display. And, after carrying around the brick that is the N900, it&#8217;s nice to have something so light that I can barely feel it in my pocket.

All in all, I find the Veer to be more fun and more intuitive than my wife&#8217;s new Android phone (which she is rapidly falling in love with).

**Conclusion**
  
So now I get to work out whether to try to get a few bucks by putting my N900 on ebay (but who would buy what&#8217;s essentially a two-year-old 5 inch tablet when there&#8217;s far better available), or keep it as a remote control for my media center in Lebanon.

And I get to see whether I can do the same kind of cool things with the Veer that I could do with the N900. Unfortunately the Veer doesn&#8217;t seem to come with gstreamer, so the LEGO robot idea might be out. But, I have hopes that the Veer will be at least somewhat as hackable as the N900 was.

**Offtopic**
  
For those who have been following along, Naomi (my wife) and I are currently on sabbatical in the States, following a month in Ireland. I was hoping for more time to work on Fedora stuff, but the last couple of months have been a bit crazy and I can&#8217;t realisticly expect the next few to be much different. I should be able to continue fixing the [bugs][9] that have [popped up][10] in yum-presto, but not much more than that.

I would love to meet any Fedora people in the area (I&#8217;m about an hour north of Portland on I-5), but haven&#8217;t had the time to track down if anyone&#8217;s actually in the area. I&#8217;d also love to do a conference, but, again, don&#8217;t know what&#8217;s in the area.

For those in Lebanon, we will be back at the end of this year, and I&#8217;m already looking forward to seeing you again.

 [1]: http://cedarandthistle.files.wordpress.com/2011/09/n900.jpg
 [2]: http://europe.nokia.com/find-products/devices/nokia-n900
 [3]: /2011/05/20/sabbatical/
 [4]: http://cedarandthistle.files.wordpress.com/2011/09/veer.png
 [5]: http://www.hp.com/united-states/webos/us/en/tablet/touchpad.html
 [6]: http://www.hp.com/united-states/webos/us/en/smartphone/veer.html
 [7]: http://www.hp.com/united-states/webos/us/en/accessories-veer.html#touchstone
 [8]: http://preware.org/
 [9]: https://bugzilla.redhat.com/show_bug.cgi?id=735649
 [10]: https://bugzilla.redhat.com/show_bug.cgi?id=739092