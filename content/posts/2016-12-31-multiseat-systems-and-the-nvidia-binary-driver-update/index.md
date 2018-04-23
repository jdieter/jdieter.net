---
title: Multiseat systems and the NVIDIA binary driver (update)
author: jdieter
description: An update on how to make using different graphics drivers on the same computer just work
type: post
date: 2016-12-31T20:20:00+00:00
url: /posts/2016/12/31/multiseat-systems-and-the-nvidia-binary-driver-update
categories:
  - Computers
tags:
  - fedora
  - libglvnd
  - mesa
  - multiseat
  - nvidia
  - xorg

---
{{< imgproc "fireworks" Resize "300x" />}}

Last month I wrote about [using the NVIDIA binary driver with multiseat systems][2]. There were a number of crazy tweaks that we had to use to make it work, but with some recent updates, the most egregious are no longer necessary. Hans de Goede [posted about an Xorg update][3] that removes the requirement for a separate Xorg configuration folder for the NVIDIA card, and I&#8217;ve created [a pull request][4] for negativo17.org&#8217;s NVIDIA driver that uses the updated Xorg configs in a way that&#8217;s friendly to multiseat systems.

To make it Just Work™, all you should need is [xorg-x11-server-1.19.0-3.fc25][5] from F25 updates-testing, my [mesa build][6] ([source here][7], Fedora&#8217;s mesa rebuilt with libglvnd enabled), my [NVIDIA driver build][8] ([source here][9]), and the [negativo17.org nvidia repository][10] enabled.

With the above packages, Xorg should use the correct driver automagically with whatever video card you have.

 [2]: /posts/2016/11/30/multiseat-systems-and-the-nvidia-binary-driver/
 [3]: http://hansdegoede.livejournal.com/2016/12/12/
 [4]: https://github.com/negativo17/nvidia-driver/pull/10
 [5]: https://koji.fedoraproject.org/koji/buildinfo?buildID=828388
 [6]: http://lesloueizeh.com/jdieter/mesa-x86_64/
 [7]: http://lesloueizeh.com/jdieter/mesa-13.0.2-3.fc25.src.rpm
 [8]: http://lesloueizeh.com/jdieter/nvidia-x86_64/
 [9]: http://lesloueizeh.com/jdieter/nvidia-driver-375.26-4.fc25.src.rpm
 [10]: http://negativo17.org/repos/fedora-nvidia.repo
