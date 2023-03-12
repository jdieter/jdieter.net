---
title: Duct tape in the datacenter
author: jdieter
description: Best practices for dealing with duct tape in the datacenter
type: post
date: 2023-03-12T21:15:17+00:00
url: /posts/2023/03/12/duct-tape-in-the-datacenter
categories:
  - Computers
tags:
  - fedora
  - devops
  - platform engineering
  - sre
  - duct tape
  - red green
---

{{<imgproc "duct_tape" Resize "x200" left />}}

When I was growing up, on Thursday nights we would watch [the Red Green Show](https://en.wikipedia.org/wiki/The_Red_Green_Show), a comedy show set in very rural Canada.  One of the regular segments on the show was [the Handyman Corner](https://www.youtube.com/watch?v=NWzPCLcbExo), where Red Green would build something impressive out of the spare parts and garbage he had sitting around the shop, along with copious amounts of “the Handyman’s secret weapon,” duct tape, to hold everything together.  To this day, whenever I see duct tape I think about the Red Green Show.

Lately I’ve had cause to think about duct tape when looking into IT infrastructure issues, some that I’ve had to handle at work, and some that we’ve all gotten to see from the outside.  I don’t think I’ve ever actually used physical duct tape on the job, but there’s more than one kind of duct tape.

The thing about duct tape is that it is an incredibly useful tool for holding things together that perhaps were never intended to be connected (the [Apollo 13 duct tape and cardboard scene](https://www.youtube.com/watch?v=f6F6MzMT2g8) comes to mind here).  The problem is when duct tape is used as a core part of the design (as per most of Red Green’s builds).

When working with infrastructure, we may not normally be using physical duct tape, but there are plenty of things we do that correspond with duct tape.  At my day job, our infrastructure is built using a GitOps model where server deployments are managed using Ansible playbooks and, more recently, Terraform configuration, all stored in git repositories.  We also have development environments where we can test infrastructure and code changes before pushing to production.

The primary advantages of using the GitOps model are documentation and repeatability.  Documentation in git comes pretty easily because when changes are made, it’s easy to see what was changed, and (assuming we’ve been disciplined when writing commit messages) why it was changed.  Repeatability is there because, If we deploy one server with a specific configuration and need to re-deploy it at a later point, the second deployment will be identical to the first.  We don’t need to worry about missing steps because it’s all automatically done when deploying the playbooks.

So what happens when we bypass our processes?  When we manually deploy a server?  When we manually make a change?  Well, that’s our duct tape.  It’s sometimes very necessary.  If an important service has crashed, the first priority is to get it back up and running, not have [a committee discussion](https://www.youtube.com/watch?v=SmQjJ_hzz-4).  The problem is when duct tape becomes permanent.

We’ve seen far too much of this in the news recently, the main case in point being Twitter.  It’s unclear whether [the latest outage](https://www.theverge.com/2023/3/6/23627875/twitter-outage-how-it-happened-engineer-api-shut-down) is due to bypassed processes or whether the infrastructure was brittle to begin with (or, most likely, some combination of both), but, either way, the systems there are breaking down, and it just seems to be getting worse.

So how do you deal with duct tape in the datacenter?  Here are some thoughts:
1. **Design your infrastructure to be extensible and your services to be highly available.**  One of the biggest causes of duct tape maintenance is brittle infrastructure.  When there’s an outage, repairs are of the highest urgency, and fixing it now is more important than fixing it correctly.  Unfortunately, emergency fixes are like layers of duct tape applied on top of each other, weakening the overall structure.

    Far better to have an infrastructure design where failures have no negative effect beyond letting your team know that something needs to be fixed.  Without the urgency, fixes can be planned and implemented correctly.  Upper management is happy because customers aren’t affected.  You’re happy because the problem is being fixed properly and permanently.

2. **Be disciplined about your processes.**  When there are urgent tasks or problems, there’s the temptation to skip steps in the process and just apply a bit of duct tape to fix the problem. *Sometimes you won’t have a choice*, but, if you can avoid it, don’t take the shortcut.

3. **When you have to come up with quick and dirty hacks, ensure that they are done with an eye towards the long-term solution.**  While the ideal is to always design things properly from the beginning, in the real world, we sometimes have to get something done right now, without worrying about how correct it is.

    The common mistake is to build a quick solution without thinking about how you’ll replace it later.  Once the urgency is over, you quickly realize that a proper fix will involve completely changing how your solution works.

    Far better to take a few minutes (or more if possible) to think through what you would want the long term solution to look like, and then assess how best to build the quick solution in a way that the duct tape can be easily replaced later.

4. **Document your duct tape.**  If you absolutely *must* make manual changes or break processes, document it.  You may not think it’s necessary, but documentation ensures that the duct tape doesn’t get forgotten.  There’s nothing worse than trying to fix a massive disaster and realizing that there’s some duct tape hanging around and you don’t know what it’s supposed to be attached to.

    I have been in a couple of situations recently where processes were bypassed (or never created in the first place) when creating a service, and the person responsible for the service has no idea how to manage it.  We've ended up needing to spend tens of hours reverse engineering the service configuration, compared to a couple of minutes of documentation.

Like duct tape, the ability to make manual infrastructure changes is a useful, even vital, tool.  Don’t throw it away just because it can be abused.  The key is to ensure that it’s only used when absolutely necessary and that you know where your duct tape is.


*Photo [Polyken Duct Tape](https://commons.wikimedia.org/wiki/File:Polyken_Duct_Tape.jpg) by Markbritton used under the [CC BY-SA 3.0 license](https://creativecommons.org/licenses/by-sa/3.0/deed.en)*
