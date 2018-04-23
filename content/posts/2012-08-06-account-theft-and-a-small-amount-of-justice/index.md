---
title: Account theft (and a small amount of justice)
author: jdieter
description: A conversation with a scammer
type: post
date: 2012-08-06T20:33:33+00:00
url: /posts/2012/08/06/account-theft-and-a-small-amount-of-justice
categories:
  - Computers
tags:
  - 419
  - account theft
  - fraud
  - hacked email
  - scam

---
{{< imgproc "padlock" Resize "300x" />}}

So, there I was in my office working hard (during summer break, no less, I hope my boss reads this) on <a href="http://github.com/lesbg/lesson-backend" target="_blank">LESSON</a> (our school&#8217;s marking system) when I received a distressing email from a friend of mine.

Apparently he had been mugged during a trip to Spain (something I found very surprising as we&#8217;d just had dinner with him on Thursday, and he hadn&#8217;t mentioned a trip then), and the miscreants had stolen everything but his passport. All my friend needed was a small loan of €2000 to cover his hotel bills and taxi to the airport. Sent via Western Union, that admirable institution that takes such pains to make sure that money <a href="http://www.courthousenews.com/2010/04/07/26193.htm" target="_blank">ends up</a> where <a href="http://www.complaints.com/2009/october/6/WESTERN_UNION_LOST_MONEY_AND_WONT_DO_ANYTHING_216898.htm" target="_blank">it&#8217;s supposed to</a>.

{{< imgproc "scam" Resize "83x" left >}}<em>Transcript</em><br/><strong>Burgundy:</strong><br/>Scammer<br/><strong>Black:</strong><br/>Me{{< /imgproc >}}

Yeah. This particular friend would have trouble racking up a €200 hotel bill, much less ten times that amount. I immediately got on the phone and called his wife. Sure enough, their Yahoo account had been compromised and she could no longer access it. I talked her through Yahoo&#8217;s compromised account process, and she was able to reset her password using her security questions (apparently the scammer hadn&#8217;t changed those yet). Checking the original email showed that the scammer was accessing Yahoo&#8217;s webmail through a web proxy, hidemyass.com.

When she finally got into their account, all of their contacts had been deleted along with the last few months of their sent mail. She sent an email to Yahoo explaining the situation and got an automated reply saying that she would be contacted within 24 hours. In the meantime, she has no way of letting her contacts know the message is a fraud. Even worse, the &#8220;SOS from Spain&#8221; email had a reply-to address that was subtly different from the original, an added i between first initial and last name. This means that, even though she has regained control of her own account, anyone replying to her email will be replying to an account still under the control of the scammer.

I didn&#8217;t want all that effort by the scammer to go to waste, so I sent an email to the fake account asking how I could help my dear friend in Spain. To make a long story short, I went back and forth with my &#8220;friend&#8221; for three and a half hours, finally offering to loan him €1000. I only ended the fun when the scammer insisted on having the Western Union confirmation number.

I ended the conversation with a supposed link to the confirmation number, but which was actually a tasteful picture of a donkey braying. I then contacted a technician at hidemyass.com and forwarded them the emails along with the log of the scammer accessing the donkey picture. Surprisingly, the originating IP was from Nigeria. What a shock!

It did turn out that the scammer was actually paying to use the web proxy, so the technician suspended their account. Which means that instead of making money of this particular scam, the scammer actually lost money. It&#8217;s not much of a win, but I&#8217;ll take what I can get.

_Padlocked gate credit &#8211; [Padlock][3] by [Ian Britton][4]. Used under the [CC BY-NC-ND 3.0][5] license._

 [3]: http://www.freefoto.com/preview/9911-03-3621/Padlock
 [4]: http://www.ianbritton.co.uk/
 [5]: http://creativecommons.org/licenses/by-nc-nd/3.0/
