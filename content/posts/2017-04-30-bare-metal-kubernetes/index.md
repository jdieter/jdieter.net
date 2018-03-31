---
title: Bare-metal Kubernetes
author: jdieter
type: post
date: 2017-04-30T17:36:48+00:00
url: /posts/2017/04/30/bare-metal-kubernetes/
categories:
  - Computers
tags:
  - kubernetes
  - lesbg
  - ovirt

---
{{< imgproc "broken-wagon-wheel" Resize "300x" />}}

A few years ago, I attended my first Linux conference, [DevConf 2014][2]. Many of the speakers talked about containers and how wonderful they were, and my interest was piqued, but I&#8217;ve never really had an opportunity to use them.

As the sysadmin for a school, there just isn&#8217;t much need for the scalability provided for by containers. Our internal web site runs on a single VM, and the short downtimes required for system updates and upgrades are not a problem, especially if I plan them for the weekends. On the flip side, having something that we can use to spin up web services quickly isn&#8217;t a bad idea, so, over the last few months, I&#8217;ve been experimenting with Kubernetes.

My main goal was to get something running that was easy to set up and Just Works™. Well, my experience setting up Kubernetes was anything but easy, but, now that it&#8217;s up, it does seem to just work. My main problem was that I wanted to use my three oVirt nodes (running CentOS 7) as both Kubernetes nodes and masters, which meant the tutorials took a bit of finessing to get working.

I mostly followed [this guide][3] for the initial setup, and then [this guide][4], but I did run into a few problems that I&#8217;d like to document. The first was that my containers were inaccessible on their cluster IP range, the primary symptom being that the kube-dashboard service couldn&#8217;t connect to the kubernetes service. It turned out that I, rather stupidly, forgot to start kube-proxy, which does all the iptables magic to direct traffic to the correct destination.

The second problem I ran into was that I couldn&#8217;t get pretty graphs in kube-dashboard because the heapster service wouldn&#8217;t start because I hadn&#8217;t set up the cluster DNS service, kube-dns. To be fair, the instructions for doing so are pretty unclear. In the end, I downloaded [skydns-rc.yaml.sed][5] and [skydns-svc.yaml.sed][6], and replaced $DNS\_DOMAIN and $DNS\_SERVER_IP with the values I wanted to use.

The final problem I ran into is that I&#8217;m using our school&#8217;s local Certificate Authority for all the certificates we use, and I&#8217;ve had to keep on adding new subject alternative names to the server cert and then regenerate it. At the moment, it&#8217;s got the following:
  
```
DNS:kubernetes.example.com
DNS:node01.example.com
DNS:node02.example.com
DNS:node03.example.com
DNS:localhost
DNS:localhost.localdomain
DNS:kubernetes.default.svc.local
```
*Where I replaced $DNS_DOMAIN with &#8220;local&#8221;*
  
```
DNS:kubernetes.local
DNS:kubernetes.default
IP Address:127.0.0.1
IP Address:172.30.0.1
```
*Where our cluster IP range is 172.30.0.0/16*

I suspect I could now get rid of some of those hostnames/addresses, and I&#8217;m not even sure if this method is best practice, but at least it&#8217;s all working.

So I&#8217;m at the point now where I need to see if I can setup our MikroTik router as a load balancer and then see if I can get our web based marking system, LESSON, moved over to a container with multiple replicas. Hurrah for redundancy!

_[Broken Wagon Wheel][7] by [Kevin Casper][8] is in the public domain / used under a [CC0 license][9]_

 [2]: /posts/2014/01/28/devconf-2014/
 [3]: https://kubernetes.io/docs/getting-started-guides/fedora/flannel_multi_node_cluster/
 [4]: https://kubernetes.io/docs/getting-started-guides/fedora/fedora_manual_config/
 [5]: https://github.com/kubernetes/kubernetes/blob/release-1.5/cluster/addons/dns/skydns-rc.yaml.sed
 [6]: https://github.com/kubernetes/kubernetes/blob/release-1.5/cluster/addons/dns/skydns-svc.yaml.sed
 [7]: http://www.publicdomainpictures.net/view-image.php?image=91572&picture=broken-wagon-wheel
 [8]: http://www.publicdomainpictures.net/browse-author.php?a=59163
 [9]: https://creativecommons.org/publicdomain/zero/1.0/
