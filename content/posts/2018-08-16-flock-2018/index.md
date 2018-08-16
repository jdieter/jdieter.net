---
title: Flock 2018
author: jdieter
description: I had the privilege of attending Flock 2018 in Dresden.  Here's a post on the things that I learned there.
type: post
date: 2018-08-16T11:15:23+00:00
url: /posts/2018/08/16/flock-2018
categories:
  - Computers
tags:
  - fedora
  - modularity
  - flock
  - dresden
  - ansible
  - zchunk

---
{{< imgproc "clock" Resize "300x" >}}Dresden{{< /imgproc >}}

Last week, I had the opportunity to be at [Flock][1], Fedora's contributer conference, in Dresden.  As I was preparing to leave for Flock, I seriously wondered whether it was going to be worth it, given that I've just moved countries and am still in the process of getting settled in and of job-searching.  But as I got on the plane after it was over, I knew that it was definitely worth it!  This year was, by far, the best Flock I've been too.  There were a number of great talks, but the thing I appreciated the most was the sense of community evident at the conference.

Over the last few months, I've been working on getting [Fedora's metadata zchunked][2], so this was a great chance to meet with Igor Gnatenko and Neal Gompa, who have both been helping me.  I was also able to talk with some of the DNF and Fedora Infrastructure guys, and got a lot of good feedback.  A huge thank you to everyone who listened (sometimes unwillingly, I'm sure) to me talk about [zchunk][5]!  (And kudos to Randy Barlow and Jeremy Cline who are thinking about doing a zchunk implementation in Rust!)

### Talks

I made it to quite a number of talks, but there were three that really stood out to me.

#### The power of one: For the good of the community - Rebecca Fernandez

This was a great talk, mainly because it focuses on the soft skills that we geeks can sometimes be very weak on.  She talked about how important it is to speak up, especially when someone is being offensive in the community and gave great ideas on how to speak up in a way that moves the conversation forward rather than increasing drama.  She didn't give us any magic wands that will supernaturally change people's behavior, but, as a teacher who's been stuck mediating many a student dispute, I think her methods are far more effective than most realize.

I'd love to be able to point to a video of her talk, but it doesn't look like it's online yet.

#### Ansible

I made it to a couple of the ansible talks, and they were quite fascinating.  We've been [using ansible][3] in the school for workstation deployment for a few years now, but the talks quickly made it clear how little I actually know about ansible.

The first revelation was that you can use templates for configuration files, something that I had never caught onto.  You can create a template for foo.conf, set a {{ variable }} in the template, and then watch as the the variable is replaced in the deployed file.  This is the kind of thing that makes deployment *so* much easier.

We've been using roles for our ansible playbooks since the beginning, but my second revelation was that you could change the default task that runs in a role.  When running a role, normally the default task is `main.yaml`, but, by setting the **tasks_from:** attribute in **include_role**, you can change that to any task you want.  This allows us to specify different sets of tasks within a role, so we can just run the correct set when including the role.

The final revelation is that ansible allows you to create plugins that run on the controller for various purposes.  These plugins can be used for purposes that range from writing a custom connection method for connecting to your hosts, to creating a custom strategy for running ansible on the hosts, to loading external data into your playbooks.  This allows you to extend ansible far beyond its normal limitations.

The beauty of ansible is that you don't have to be an expert to create functional playbooks, but it's nice to see ways that I could make our playbooks more efficient.

#### Modularity

My [last post][4] deals with my experience building a module for Fedora, so I'm not going to spend much time discussing it, but I do have a lot of hope for where modularity could take us, especially as it relates to server packaging.

For those who want to try my LizardFS development module, on F28 server or Rawhide, run the following:
```
# dnf --enablerepo=updates-testing-modular module enable lizardfs:devel
# dnf --enablerepo=updates-testing-modular list "lizardfs*"
```

You'll see and be able to install the 3.13.0 release candidate packages rather than the default 3.12 packages.  To go back to 3.12, just run:
```
# dnf --enablerepo=updates-testing-modular module disable lizardfs:devel
# dnf --enablerepo=updates-testing-modular distro-sync "lizardfs*"
```

Once the LizardFS module has been in updates-testing-modular for a week, I'll push it to stable and you'll be able to remove "--enablerepo=updates-testing-modular" from your commands.

#### Lightning talks

I also gave a lightning talk explaining how zchunk works, and got to hear a lot of quick interesting things that people are working on.  Luka described a new project called ignition that's meant to be an interpreter-free replacement for cloud-init, Praveen shared about building a Fedora minishift ISO, Florian made an interesting proposal to remove the changelog from the spec file and automatically generate it from git, and Adam S. spoke about using Fedora containers in MacOS.  Adam's proposal is to try to make Fedora the default choice when a developer wants to use containers on MacOS, which could greatly expand the userbase.

### Evening events

There were a few evening events, but the two that stuck out were the Dresden treasure hunt and the Roller Coaster Restaurant.  For the treasure hunt, we were placed in teams of seven or eight and sent around the city center, filling in a "treasure" map.  I was lucky enough to be on a team that included Matej, who was in charge of AV at Flock and is quite competitive, along with a couple of guys from Dresden.  With Matej pushing us forward and the local guys acting as guides, we were the first team finished (though we came in second overall due to missing bonus tasks).

{{< youtube E-SaDmOVHvI >}}
<figcaption><small><center>The Roller Coaster Restaurant</center></small></figcaption>

The second memorable event was the dinner organized at the Roller Coaster Restaurant.  I was mildly concerned that we would be expected to eat on a roller coaster, but it turns out that the food is sent on a roller coaster to you.  My first thought was, "What could possibly go wrong?"  The answer, as it turns out, is that a beer bottle might just fall from five meters up, you might have flaming sparklers dropping sparks on your head, and your food might get stuck.  Other than that, though...  In all seriousness, it was a fun place to hang out at, and I got the opportunity to chat with Igor a bit and then with Zbigniew for quite a while.  Definitely made up for the slight risk of having a bottle dropped on your head or being lit on fire.

### Summary

I feel like this year's Flock was the best that I've been to yet.  I got the opportunity to get to know a number of the people that I normally only see on IRC or the mailing lists.  Putting faces to names and getting a feel for personalities is important, so I'm really glad that I was able to make it again this year!  I would strongly recommend that anyone who wants to be part of the Fedora community makes a point of being there if at all possible.  A huge thank you to everyone involved in putting Flock together!


 [1]: https://flocktofedora.org/
 [2]: https://fedoraproject.org/wiki/Changes/Zchunk_Metadata
 [3]: https://github.com/lesbg/ansible
 [4]: /posts/2018/08/11/building-a-module
 [5]: /posts/2018/05/31/what-is-zchunk