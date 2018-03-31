---
title: Migrating from wordpress.com to Hugo
author: jdieter
type: post
url: /posts/2018/03/31/migrating-from-wordpress-com-to-hugo
date: 2018-03-31
timeline_notification:
  - 1522518773
categories:
  - Computers
tags:
  - wordpress
  - hugo
---
{{< imgproc "IMG_20180208_101922" Resize "300x" >}}Refreshing changes{{< /imgproc >}}

When I started this blog back in 2009, I chose to publish it on [Wordpress][1] because it was easy to use and maintain.  I hosted it using wordpress.com's free tier, and it has worked well enough for me since then, but when it came time to move the blog off of wordpress.com and onto something self-hosted, I wasn't convinced that Wordpress was still the best solution for me.

As a system administrator, my biggest concern regarding Wordpress is its security.  When our school's website switched from some 90's era framework to Wordpress a couple of years ago, it wasn't long before our site was compromised.  We switched from a web host to a [DigitalOcean][2] instance running the latest version of Fedora and a system copy of Wordpress (both kept up-to-date), which has (at least for now) kept our site from being compromised again, but that is one more service that we have to keep our eyes on.

The problem is that, as nice as it is to have a pretty GUI for inputting posts and the like, there's a potential security hole with any public server that allows changes.  [Hugo][3] works on a completely different basis.  Instead of creating and editing posts online, Hugo allows you to create a site using text files and a git repository, and then publishes static web pages, greatly reducing the attack surface.  There are some costs (I think I'm going to go without public comments, at least for the moment), but I think it's well worth it.

The migration has consisted of a number of steps.  First I exported my site from wordpress.com, created a local instance, and imported my site.  I did this because wordpress.com doesn't allow you to use custom plugins unless you're ready to pay large amounts of money.  Second, I used the [Wordpress to Hugo exporter][5] plugin to export my site to Hugo.  I had already configured a new Hugo site, so I only copied the `content/posts` directory across from my blog export.

Finally came the time-consuming process of checking each post and changing how pictures are embedded.  I've followed the steps in Hugo's [image processing page][4] to automatically generate smaller versions of my images to post in the blog, with a hyperlink to the full-size image, and I've also checked each url to make sure that it matches the url on the old site.  I am currently about half-way through my posts, and it sure has been interesting to see some of the things I wrote about over the last nine years.

Once I'm finished updating my posts, I'm going to pay wordpress.com ($13 a year, I think it is) to redirect everything on my old site to this new one.  Then it's a matter of updating my site information using the major search engines' webmaster tools, and the conversion should be done.

The source for this site is published on https://github.com/jdieter/jdieter.net

 [1]: https://wordpress.org
 [2]: https://www.digitalocean.com
 [3]: https://gohugo.io
 [4]: https://gohugo.io/content-management/image-processing/
 [5]: https://github.com/SchumacherFM/wordpress-to-hugo-exporter
