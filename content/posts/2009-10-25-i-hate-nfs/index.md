---
title: I hate NFS
author: jdieter
description: I describe the problems we ran into when setting up our NFS servers
type: post
date: 2009-10-25T18:16:35+00:00
url: /posts/2009/10/25/i-hate-nfs
categories:
  - Computers
tags:
  - centos
  - drbd
  - fedora
  - lesbg
  - nfs
  - samba

---
On our network we have about 100 client computers, most of which are running Fedora 11.  We have two real servers running CentOS 5.4, using DRBD to keep the virtual machine data on the two real machines in sync and Red Hat&#8217;s cluster tools for starting and stopping the virtual machines.

We have five virtual machines running on the two real machines, only one of which is important to this post, our fileserver.

Under our old configuration, `/networld` was mounted on one of the real servers, and then shared to our clients using NFS. Our virtual machine, fileserver, then mounted `/networld` over NFS and shared it using Samba for our few remaining Windows machines (obviously, a non-optimal solution).

{{< imgproc "servers-old" Resize "500x" none >}}Old configuration (click on image for full size){{< /imgproc >}}

There were a couple of drawbacks to this configuration:

  1. I had to turn on and off a number of services as the storage clustered service moved from storage-server01 to storage-server02
  2. Samba refused to share a nfs4-mounted `/networld`, and, when mounted using nfs3, the locking daemon would crash at random intervals (I suspect a race condition as it mainly happened when storage-server0x was under high load).

My solution was to pass the DRBD disks containing `/networld` to fileserver, and allow fileserver to share `/networld` using both NFS and Samba, which seemed a far less hacky solution.

{{< imgproc "servers-new" Resize "500x" none >}}Current configuration (click on image for full size){{< /imgproc >}}

I knew there would be a slight hit in performance, though I&#8217;m using virtio to pass the hard drives to the virtual machine, so I would expect a maximum of 10-15% degradation.

Or not. I don&#8217;t have any hard numbers, but once we have a full class logging in, the system slows to a crawl. My guess would be that our Linux clients are running at 1/2 to 1/3 of the speed of our old configuration.

The load values on fileserver sit at about 1 during idle times and get pumped all the way up to 20-40 during breaks and computer lessons.

So now I&#8217;m stuck. I really don&#8217;t want to go back to the old configuration, but I can&#8217;t leave the system as slow as it is. I&#8217;ve done some NFS tuning based on miscellaneous sites found via Google, and tomorrow will be the big test, but, to be honest, I&#8217;m not real hopeful. 

(To top it off, I spent three hours Friday after school tracking down [this bug][3] after updating fileserver to CentOS 5.4 from 5.3. I&#8217;m almost ready to switch fileserver over to Fedora.)

 [3]: https://bugzilla.redhat.com/show_bug.cgi?id=524520
