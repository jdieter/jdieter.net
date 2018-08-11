---
title: Building a Fedora module
author: jdieter
description: A quick guide on how to build a Fedora module.  I built my first module, and it was relatively painless
type: post
date: 2018-08-11T09:46:23+00:00
url: /posts/2018/08/11/building-a-module
categories:
  - Computers
tags:
  - fedora
  - modularity
  - lizardfs

---
{{< imgproc "dome" Resize "300x" >}}Dresden{{< /imgproc >}}

Today is the last day of [Flock][1] in Dresden, and it has been a really good Flock!  On Thursday, I got the opportunity to build my first module for Fedora Modularity, and I just wanted to document the experience.  As things go, it was quite easy, but there were a couple of things that tripped me up.

Please note that the tooling is still being worked on, so if you're reading this much after it was published, some things will have probably changed.

### Background

First, for those who haven't been following, Modularity is a system that allows the user to select different streams of software in the same release.  Traditionally in Fedora, there's only one available version of any given package.  There are situations where this can be limiting (say, if you need a particular version of a certain Python framework, or if you want to test drive the latest release of a package without upgrading your whole system to something unstable), and Modularity tries to fill this gap.

I thought this might be useful for [LizardFS][2] in Fedora.  The current stable version of LizardFS is 3.12.0 (available in all active Fedora releases and in EPEL), but a release candidate for 3.13.0 has been published, and I thought it would be useful for those who actively want to _test_ LizardFS to be able to install it.

On Thursday, I went to the [Expert Helpdesk: Module Creation][3] session and noticed that the room was fairly full.  I was a bit concerned that I might not get the expert help that I needed, but that worry was put to rest when I found out that I was the only person in the room that hadn't built a module before.

A certain Modularity developer (who shall remain unnamed to protect the guilty) volunteered me to go to the front and plug my laptop into the projector so the room full of experts could watch and advise me as I built my first module.  No pressure at all.

I was advised that for my suggested use-case, I should just keep packaging the stable releases in Fedora as usual, but create a _devel_ module stream for the unstable releases.

### The process

The first step in building a module is to read the [documentation][4].  If you're like me, you'll read the first step, see that it talks about getting your package into Fedora, and quickly move to the next step.  It turns out, though, that you do need to go back and read that section because you'll need to create a new branch in dist-git for each module stream you are going to create.

#### Branching

One thing that isn't (at the time of writing) documented is that, when requesting a branch, you must specify a service level, even though it seems that these aren't going to be used.  The date must end in 12-01 or 06-01, so I just made something up.

To request my branches, I ran:
```
fedpkg --module-name=lizardfs request-branch devel --sl rawhide:2020-12-01
```

Mohan approved my requests in record time (there are advantages to having everybody watching you), and I was ready to work with both dist-git, and the modulemd git repo.  I pushed the release candidate to my new devel branch in dist-git, and then it was time to create the module definition.

#### Creating the module definition

Step two, creating the module definition, should have been straightforward, but there was talk about using fedmod to automate the process, so I installed it, ran into problems getting it working, and we decided it would be easier to just generate the modulemd file manually.  I used the minimum template [here][5] as a starting point, saving it as lizardfs.yaml in the modulemd git repo.  It was pretty simple to setup and the only slightly tricky thing to remember is that the license is the license of the module definition, not the package itself.

One thing I didn't do, but really need to, is to setup some profiles for LizardFS.  A profile is a group of packages that fit a use-case, and make it easier for the end-user to install the packages they need.

#### Building the module

Once I had pushed the modulemd, it was time to build!  I pushed the build and waited... and waited...  The way my module was defined, it was going to be built for every Fedora release that has modules (currently F28 (Server) and F29), so it took a while.  Our time was running out, and we had a walking tour and scavenger hunt in Dresden (a brilliant idea, huge thanks to the organizers!), so that was the end of the workshop.

While on the scavenger hunt (our team placed second, thanks to some very competitive members of the team), I got a notification that the module build had failed.  I found that I was missing a dependency, so I fixed that and rebuilt, but ran into a rather strange problem: it tried to redo the first build rather than doing a new one.

It turns out that, [as documented][6], you need to push an empty commit to the modulemd git repo in order for it to build from the latest dist-git repo.

I had another failed build because lizardfs-3.13.0 [doesn't build against 32-bit architectures][7], so I wrote a small patch to fix that, pushed another empty commit to the modulemd git repo, and finally managed to build my very first module!  Cue slow clap.

### Thoughts

The module building process is actually quite simple and being able to build a module stream for all active Fedora releases simplifies the workload quite a bit.  I'm seriously thinking about retiring LizardFS in Rawhide and only providing it via modules (with the stable stream being the default stream that you would get if you ran dnf install lizardfs-client).

The workflow is still a bit clunky, especially with having to manage both dist-git and the modulemd git repo, and I'd love to see that simplified, if possible, but it's not nearly as difficult as I thought it might be.

A huge thanks to everyone (even Stephen) who put the time and effort into making modules work!  I think they have a lot of potential in making the distribution far more relevant to developers and users alike.  And a huge thanks to all the experts at the session.  I know how hard it is to sit and watch someone make mistakes as they try to use something you've created, and you all were very patient with me.

 [1]: https://flocktofedora.org/
 [2]: https://lizardfs.com/
 [3]: https://flock2018.sched.com/mobile/#session:2c29217fab2a9ab3119f5c11a71d2301
 [4]: https://docs.fedoraproject.org/en-US/modularity/making-modules/adding-new-modules/
 [5]: https://docs.fedoraproject.org/en-US/modularity/making-modules/defining-modules/#_an_absolute_minimum
 [6]: https://docs.fedoraproject.org/en-US/modularity/making-modules/updating-modules/#_step_2_bump_the_module_version
 [7]: https://github.com/lizardfs/lizardfs/pull/728