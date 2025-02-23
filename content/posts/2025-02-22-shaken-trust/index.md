---
title: Shaken trust
author: jdieter
description: My son's laptop was compromised by his school's IT vendor
type: post
date: 2025-02-23T00:22:54+00:00
url: /posts/2025/02/23/shaken-trust
categories:
  - Computers
tags:
  - fedora
  - windows
  - ireland
  - Wriggle
  - security
---

{{<imgproc "ruins" Resize "x200" right />}}

I spent fifteen years running the IT infrastructure for a relatively large (1600+ student) school, so I understand that it can be a really thankless task.  Because of this, I have done what I can to work with my kids' school and their device policies.  I trust that the people in the school are doing things with the best intentions, but earlier this month my trust in the school was severely shaken when I discovered that my son's laptop had been compromised... by the school's IT vendor!

To give some background, when my second daughter moved up to secondary school (the Irish equivalent of junior high and high school combined) a few years ago, hers was the first class to be asked to buy laptops that would be used in place of physical books.  The school was very specific that the laptops be a certain model and have a specific version of Windows installed on them.  An opportunity was provided to buy the laptops through Wriggle, an Irish IT company that the school used to manage this process.  Wriggle sweetened the pot by offering three years of support and promising that the laptops would be securely locked down so students wouldn't be able to access inappropriate websites, etc.

The thing is, I am not going to entrust my childrens' IT security to random third parties.  While I'm sure that Wriggle provides a useful service for the vast majority of the population, it's not useful for me, and I really appreciate that the school didn't mandate buying the laptop through Wriggle.  I bought the laptop externally with the required version of Windows and allowed the school to install MS Office and their ebook software onto it.  I then joined the laptop to my Microsoft Family Safety account, and set up screen time limits and sane web security and application limits.  This worked fine for the last couple of years.  The laptop ran into the usual Windows problems, but nothing out of the ordinary, and was reliable enough for my daughter to get her classwork done.

Last September, my son started secondary school and I went through the same process again.  This time the spec was for a much nicer system, and, once again, I purchased the laptop externally, joined it to my Microsoft Family Safety account, and set up all the necessary security configuration before sending him to school to have them to install MS Office and their ebook software.  I never heard any complaints, so I assumed everything was fine.

At some point earlier this month, I noticed that I hadn't received any of the Microsoft Family Safety emails for my son's laptop in months, so I decided to take a look at his laptop.  Imagine my surprise when I went to the login screen to see two users, his own and a... `wriggle24` user?  No, make that a `wriggle24` *administrator*?!  He then logged into his account and a message popped up saying that Microsoft Family Safety was disabled due to the group policies put in place by the administrator.  And, to top it off, TeamViewer (a remote access tool, commonly used for support) had been installed!  In other words, a new admin had been created on the laptop, all of the restrictions that I had setup had been disabled, and remote access to the laptop had been set up, all without my knowledge!

Now, I do want to be clear that I don't think this was done maliciously by either the school or Wriggle.  My suspicion is that Wriggle has provided the school with a script of some kind and said that if anyone's laptop wasn't set up correctly, they should just run the script.  This is entirely legitimate... if the laptop is managed by Wriggle.  The failure here is that Wriggle took control of my son's laptop, even though his was not a Wriggle-managed laptop.  This is a major breach of trust!  I intentionally purchased the laptop outside of Wriggle to ensure that *I* had control, and that control was usurped without my consent.  Even worse, this was done without even *informing* me!  

This was completely unacceptable, so I informed the school that I was re-establishing control of both of my kids' laptops, and then took the somewhat extreme step of wiping Windows and installing [Fedora Silverblue](https://fedoraproject.org/atomic-desktops/silverblue/) on them instead.  It turns out that the school's ebooks are all available online, so my kids are using the online versions of the books.  And the MS Office web applications work just as well as the Windows versions, so they haven't had any document compatibility issues.  Aside from the learning curve that comes with switching from Windows to Fedora, there have been two main issues:

1. Flatpaks and printing.  Why is it so hard?  Chrome is unable to print anything, so the kids are having to "Save to PDF" and then print the PDF using document viewer.
2. My son gets homework in the form of a PDF that he's supposed to fill in using the laptop's digitizer.  I started him with Inkscape, but it's UI is really complex and he's looking for something as simple as MS Paint.  There are plenty of simpler offerings out there on Flathub, but the main feature he's looking for is that the eraser restores the original PDF rather than leaving a white background, and none of the simple options offer that functionality.

So what have I taken away from this?  First, Wriggle needs to have safeguards against taking control of devices not purchased through them.  There should be no way that their configuration ends up on a laptop not purchased through them, if for no other business reason than it's not in their interest to waste their resources supporting non-Wriggle devices.

Second, schools need to think carefully about how they provide student hardware.  While I completely understand the desire for standardized hardware, there's a danger of conflict of interest in pushing parents to purchase hardware through the same vendor that provisions the software required for the school.  If nothing else, they need to ensure that there's a process for getting the school's required software onto laptops not purchased through the hardware vendor without giving control of the laptop to the hardware vendor.

Finally, as a parent, I will not be allowing the school or its proxies to manage my kids' laptops.  When my last child reaches secondary school, his laptop will have Fedora on it from the first day, and, if that requires more work on my side to ensure it does what he needs, that's a small price to pay for the peace of mind.

Questions or comments, please reply on [Bluesky](https://bsky.app/profile/jonathan.dieter.ie/post/3lisl67wack2l).
