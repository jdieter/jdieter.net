---
title: Multiseat in Fedora 19
author: jdieter
type: post
date: 2013-11-30T20:22:34+00:00
url: /posts/2013/11/30/multiseat-in-fedora-19
categories:
  - Computers
tags:
  - amd
  - ati
  - fedora
  - lesbg
  - multiseat
  - systemd
  - USB hubs

---
This year in our main computer room, we switched from single-seat systems to multiseat systems. Our old single-seat systems cost us roughly $300 a system, and we would generally buy 20 a year. The goal with our multiseat systems was to see if we could do better than $300/seat. I also had a number of requirements, some of which would raise the cost, while others couldn&#8217;t be met the last time I looked into multiseat systems.

My first requirement was 3D acceleration on all seats. I know someone&#8217;s been working on separating OpenGL processing from the display server, which would theoretically allow us to use [Plugable devices][1], but until that&#8217;s done, we need a separate video card for each seat. We also need motherboards that can support more than one PCIE video card (as well as preferably supporting the built-in GPU). This is the main extra expense for our multiseat systems.

My second requirement was plug-and-play USB. The last time I looked into multiseat, that wasn&#8217;t supported under Linux; USB devices would only be detected if they were plugged in when the X server started. But, thanks to some relatively new code in systemd which is now controlling logins using [logind][2], USB ports can be directed to specific seats, with the devices plugged into them appearing in the correct seat when they&#8217;re plugged in.

In June, we bought a test system that came to just under $600. To our normal order we added a gaming motherboard, three of the cheapest PCIE AMD Radeon 5xxx/6xxx series cards we could find, extra RAM, and four USB hubs. The idea with the USB hubs was to place one next to each monitor and create our own wannabe-Plugable devices. I then wrote [a small program][3] that would deterministically assign each USB hub to a different monitor on bootup. An extra bonus to this program is that we can daisy chain the USB hubs. Once the program was working, I let the students play with the test system&#8230; and it worked!

So, during the summer, we bought ten more systems and put them in our main computer room. At four seats per system, we are saving 50%, so we were able to replace all forty computers in the main room in one year (and add four more seats as a bonus).

The main annoyance we&#8217;re still dealing with is that the USB hubs we got aren&#8217;t that great, and we&#8217;ve had a few fail on us. But they&#8217;re easy (and cheap) to replace. I also had to make some changes to X, like re-enabling Ctrl+Alt+Backspace as a solution for a stuck seat, which is better than rebooting the whole computer. And we do have the occasional hang where all four seats stop working, which I think is tied to the number of open files, but I haven&#8217;t tracked it down yet.

I&#8217;ve been very happy with our multiseat systems and would like to extend a huge thank you to the [systemd][4] developers for their work on logind.

**Edit:** More details are available in [this post][5].

 [1]: http://plugable.com/products/dc-125/
 [2]: http://www.freedesktop.org/wiki/Software/systemd/logind/
 [3]: https://koji.lesbg.com/koji/packageinfo?packageID=64
 [4]: http://www.freedesktop.org/wiki/Software/systemd/
 [5]: /posts/2013/12/02/setting-up-a-multiseat-system/
