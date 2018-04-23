---
title: Flock 2017
author: jdieter
description: The highlights of Flock 2017&colon; Atomic Host, Modularity and some thoughts on deltas for repodata
type: post
date: 2017-09-11T20:25:56+00:00
url: /posts/2017/09/11/flock-2017
categories:
  - Computers
tags:
  - atomic host
  - flock
  - flock 2017
  - flock17
  - flock2017
  - modularity
  - rpm-ostree

---
{{< imgproc "img_20170831_130539" Resize "300x" >}}The conference center{{< /imgproc >}}

This summer we were in the States visiting my family, and that just happened to match up with the fact that Flock was in the States this year (granted, the wrong side of the country, but still well worth the travel). This was the second Flock I&#8217;ve attended, and, compared to the last one, had far more of a focus on action rather than just listening to talks.

Flock 2017 was held at the Hyannis Resort and Conference Center in Cape Cod, Massachusetts. I arrived fairly late in the evening on Monday, August 28th (meeting up on the bus with some friends from last year&#8217;s Flock). The sessions started early in the morning on Tuesday and continued until Friday at noon.

There were loads of excellent sessions, but I want to focus on two important new technologies that were a major focus of a number of the sessions at Flock, and that I believe are going to change the way we deliver Fedora in the coming years.

**Atomic Host**
  
The Atomic series of sessions was a great introduction to Fedora&#8217;s Atomic Host, a project that looks to create a more Android-like OS that starts with a read-only base and layers on applications using your container flavor of choice. On a server that flavor might be [Docker][2], while on a workstation, it would probably be [Flatpak][3]. The first session, _Atomic Host 101_, was led by Dusty Mabe who did an excellent job of putting together [practice material][4] so we could actually do what was being demonstrated during the session. (This material is available online and the workshop can be done at home, so, if you&#8217;re at all interested in Atomic Host, I strongly recommend going through it.)

The beauty of Atomic Host is that updates are, for lack of a better word, atomic. Fedora Atomic guarantees that the update process is either completely applied or not at all. The days of half-applied updates on systems suffering from unexpected power losses are over. There&#8217;s also verification that the OS you are running _is_ the OS you installed, complete with diff-like comparisons that show you what configuration files have been changed. And, as an added bonus, if there are problems with your current update, reverting to the previous one is as easy as a single command.

Atomic Host has a couple of experimental features that greatly expand its flexibility regarding the read-only status of the base. One its downsides was that, if you wanted a new or updated system-wide tool, you would have to completely regenerate the base image. Now, installing a new system-wide package is as easy as typing `rpm-ostree install <package>`, which layers that package on top of the base. Of course, this cool feature did require you to reboot the computer to get access to the new package&#8230; until they added the livefs feature which allows you to immediately access _newly installed_ packages without requiring a reboot.

{{< imgproc "dsc_0004" Resize "300x" left>}}Owen and Patrick discuss Atomic Workstation{{< /imgproc >}}

I looked at Atomic host and rpm-ostree a year or so ago for our school workstations (which should be a perfect fit for the concept), and abandoned it because there was no way to run scripts after the rpms were installed to the image. I have a number of [ansible plays][6] that must be run to get the workstation in shape, and, as [I documented here][7], there&#8217;s no way I&#8217;m going back to packaging up my configuration as rpms. The good news is that it appears that rpm-ostree has grown the ability to run a post-system-install script that can call ansible, so I think I&#8217;m going to give this another shot. Anything would be better than the home-grown scripts I&#8217;m currently using.

**Modularity**
  
The second new technology that had a strong showing at Flock was the (relatively) new Modularity initiative. I think the first I heard about Modularity was at last year&#8217;s Flock in Poland, where, if I recall correctly, Matthew Miller compared packages to individual Lego pieces and modules to prebuilt Lego kits. The idea behind it sounded cool, but it wasn&#8217;t until this Flock that I finally understood _how_ it&#8217;s supposed to work.

The key idea behind Modularity is that you can combine a group of packages into a module, and release multiple streams of that module in Fedora. So one might have a LibreOffice module with a `5.3` stream, a `5.4` stream and a `stable` stream. Each stream may have different lifecycle guarantees, which would mean the LibreOffice `5.3` stream would be updated until the last 5.3 stable release, while the `5.4` stream would go all the way to the last 5.4 stable release. The `stable` stream might track LibreOffice 5.3 until 5.4.0 comes out and then switch. The key limitation behind streams is that, while Fedora might have multiple streams available, you can only have one stream installed on your system at any given time. Streams can be seen as separate DNF mini-repositories with packages that are designed to work well together.

Each stream may also have different profiles, which, in our LibreOffice example, might be `default` and `full`. The `default` profile might include Writer, Calc and Impress, while `full` might also include Base and Draw. Individual packages might be added or removed from the stream, so you could install the `default` profile, and then add LibreOffice Draw or remove LibreOffice Calc. Unlike streams, multiple profiles from the same module can be installed on the same system. In this way, they are most similar to the current package groups we have in DNF.

At this Flock, there were daily Modularity feedback sessions where we were talked through some simple tasks (install a module, switch to a different stream, add another profile, etc), and then asked for feedback on the user experience. I found this very effective in getting an understanding on how Modularity works, and the Modularity group did an excellent job of improving on their code in response to the feedback they received.

I did attend a session on how to build a module, but, unfortunately, because of technical problems and our hotel&#8217;s high-quality _(cough, cough)_ internet, they didn&#8217;t quite have all the pieces in place in time for us to be able to practice making our own modules. I&#8217;d love to make a module for LizardFS, but it&#8217;s obvious that there&#8217;s still a lot of bootstrapping that has to happen before we can get there. Each library it uses needs to be made into a module, so we&#8217;re looking at lots of work before even a reasonably-sized fraction of the packages are available as modules. On the flip side, if done right, Modularity gives us the potential for a lot more flexibility in how we use Fedora.

**Other odds and ends**
  
A couple of days before Flock, Kevin Fenzi released a PSA about deltarpms being broken in Fedora 26. I attended the _Bodhi Hack session_ with Randy Barlow, and dove right in to try to fix the problem, even though I&#8217;ve never touched Bodhi before. I came up with [a pull request][9], but was hitting my head against a problem with the way we were fixing it when Dennis Gilmore made [a small change][10] in the mash configuration that fixed the problem in a far simpler way. I do really appreciate Randy&#8217;s help in understanding how Bodhi works, his guidance in pointing out the best way to fix the problem, and his patience with my questions. And I&#8217;ve come to appreciate his (and Adam Williamson&#8217;s) emphasis on making test cases for his code.

{{< imgproc "img_20170831_124228" Resize "300x" >}}Hyannis Beach{{< /imgproc >}}

I also had a chat with Patrick Uiterwijk and Kevin Fenzi about the feasibility of using [casync][12] for downloading our metadata. The advantage is that casync only downloads the chunks that are actually different, but there are major concerns about how much mirrors will appreciate the file churn inherent in using casync. The reductions in download size definitely make it worth further investigation.

All in all, Flock was an excellent place to match faces with names, learn new concepts, meet new friends, and find new ways of contributing back to Fedora. A huge thank you to everyone involved in organizing this conference!

 [2]: https://www.docker.com/what-docker
 [3]: http://flatpak.org/
 [4]: https://devel.dustymabe.com/2017/08/29/atomic-host-101-lab-part-0-preparation/
 [6]: https://github.com/lesbg/ansible
 [7]: /posts/2016/02/29/notes-on-a-mass-upgrade-to-fedora-23/
 [9]: https://github.com/fedora-infra/bodhi/pull/1780
 [10]: https://github.com/henrysher/fedora-infra-ansible/commit/53883944e8ac39412456f8b2462eca3702b2864c
 [12]: https://github.com/systemd/casync/
