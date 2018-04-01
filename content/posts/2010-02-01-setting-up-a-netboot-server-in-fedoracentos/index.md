---
title: Setting up a netboot server in Fedora/CentOS
author: jdieter
type: post
date: 2010-02-01T20:18:14+00:00
url: /posts/2010/02/01/setting-up-a-netboot-server-in-fedoracentos
categories:
  - Computers
tags:
  - centos
  - fedora
  - linux
  - pxe
  - pxelinux
  - syslinux
  - tftp
  - xinetd

---
I&#8217;ve had a request for an explanation on how we use PXE and syslinux in our school. In a [previous post][1], I talked a bit about chain-loading pxe, but didn&#8217;t explain much on how our system is set up.

So here goes&#8230;

Our primary goal in setting up a PXE environment was to have some way of imaging our computers without having to screw around with an ancient version of Norton Ghost and without having to put a floppy in every computer.

The problem was that we really didn&#8217;t want students to be able to reimage the computers whenever they wanted to, and there were other tools we wanted to use that we wanted restricted.

The solution was PXELINUX&#8217;s simple menu, and it works beautifully! This post will walk you through the process of setting up PXELINUX (and gPXE while we&#8217;re at it).

For this post, I am assuming that you already have a DHCP server and a web server set up.

There are three things we need to set up:

  1. TFTP server
  2. gPXE
  3. Syslinux

The first step is to set up a TFTP server to carry our gPXE images.

  1. Run
     ```
     yum install tftp-server
     ```
  2. Edit /etc/xinetd.d/tftp and change the line that says
     ```
     disable = yes
     ```
     to
     ```
     disable = no
     ```
  3. If this is the initial installation of xinetd, you may need to run `chkconfig --levels 2345 xinetd on`
     ```
     service xinetd start
     ```
     at this point. Otherwise, it might be a good idea to run
     ```
     service xinetd reload
     ```

Now, for the next step, we need to download our gPXE images. gPXE is an extended version of PXE that allows you to load images over http and https in addition to the usual tftp. As most (all?) network cards don&#8217;t come with gPXE drivers, we will be using PXE to download and bootstrap our gPXE drivers.

As mentioned in my previous post, some of our motherboards seem to have issues mixing PXE and their normal PXE UNDI drivers, so I prefer to use gPXE&#8217;s native drivers rather than its UNDI driver.

However, we have four computers whose network cards just don&#8217;t work with gPXE&#8217;s native drivers, so we will direct those four computers to the gPXE UNDI driver.

So let&#8217;s grab and setup these drivers:

  1. Go to [ROM-o-matic][2] and choose the latest production release
  2. For output format, choose &#8220;PXE bootstrap loader image \[Unload PXE stack\] (.pxe)&#8221;
  3. Choose NIC type &#8220;all-drivers&#8221;
  4. Click on &#8220;Customize&#8221;
  5. Check the box that says &#8220;DOWNLOAD\_PROTO\_HTTPS&#8221;
  6. Click on the button that says &#8220;Get Image&#8221;
  7. Save file to /tftpboot/gpxe.pxe
  8. Change NIC type to &#8220;undionly&#8221;
  9. Click on the button that says &#8220;Get Image&#8221;
 10. Save file to /tftpboot/undi.pxe

I&#8217;m assuming you&#8217;re running the ISC dhcp server (dhcp package on both Fedora and CentOS). If not, you&#8217;ll have to work out these next steps yourself.

You need to edit /etc/dhcpd.conf and add the following lines:
```
next-server     ip address;

if exists user-class and option user-class = "gPXE" {
    filename "http://webserver/netboot/pxelinux.0";
} else {
    filename "/gpxe.pxe";
}
```

Where _ip address_ is the ip address of your TFTP server and _webserver_ is the name/ip address of your web server.

If you have some computers that won&#8217;t pxeboot using gPXE&#8217;s native drivers (you&#8217;ll be able to tell because the computers will show the gPXE loading screen, but won&#8217;t be able to get an IP address using DHCP while in gPXE), change the last five lines above to:

```
if exists user-class and option user-class = "gPXE" {
    filename "http://webserver/netboot
} else {
    if binary-to-ascii(16, 8, ":",
       substring(hardware, 1, 6)) = "mac address 1"
    or binary-to-ascii(16, 8, ":",
       substring(hardware, 1, 6)) = "mac address 2" {
        filename "/undi.pxe";
    } else {
        filename "/gpxe.pxe";
    }
}
```

Where &#8220;mac address 1&#8221; and &#8220;mac address 2&#8221; are the MAC addresses of the computers that don&#8217;t work with gPXE&#8217;s native drivers. Please note the MAC address are **without** leading zeros (i.e. 00:19:d1:3a:0e:4b becomes 0:19:d1:3a:e:4b).

At this point, if you boot any computer on your network off the NIC, you should see something like this:

{{< imgproc "gpxe" Resize "500x" none />}}

The next step is to setup PXELINUX, a part of the [Syslinux Project][4]. PXELINUX is a small bootloader designed for booting off a network.

  1. On your web server, create a directory called &#8220;netboot&#8221; in your web root (normally /var/www/html on Fedora/CentOS).

  2. Run
     ```
     yum install syslinux
     ```

     or, as an alternative, build a newer version of syslinux. I recommend at least 3.75 (the version in Fedora 12), though I&#8217;m using 3.82 at the school.

  3. Copy (at minimum) chain.c32, menu.c32, vesamenu.c32 and pxelinux.0 to &#8220;netboot&#8221; in your web root. (These files will be located in /usr/share/syslinux if you installed the package using yum.) At this point, you&#8217;ll probably want to check for [other modules][5] that might have some potential. We use ifcpu64.c32 to decide between 32-bit and 64-bit Fedora on the computers.

  4. Run:
     ```
     yum install memtest86+
     cp /boot/elf-memtest86+-4.00 \
     your_web_root/netboot/memtest
     ```

     (Note that &#8220;your\_web\_root&#8221; will most likely be /var/www/html)

  5. Download [this picture][6] and save it to your\_web\_root/netboot

  6. Change directory to your\_web\_root/netboot

  7. Run
     ```
     mkdir pxelinux.cfg
     cd pxelinux.cfg
     ```

  8. Create a file called &#8220;default&#8221; that contains the following:
     ```
     default vesamenu.c32
     timeout 40
     prompt 0
     noescape 1
     menu title Boot Options
     menu background menu.png
     menu master passwd $4$tek7ROr8$xzFCb2QVEWsc2msx3QsErbRuo0Y$
    
     label local
     menu label ^Boot from hard drive
     kernel chain.c32
     append hd0
    
     label admin
     menu label ^Administrative tools
     kernel vesamenu.c32
     append pxelinux.cfg/admin
     menu passwd $4$tek7ROr8$xzFCb2QVEWsc2msx3QsErbRuo0Y$
     ```
    
  9. Create a file called &#8220;admin&#8221; that contains the following:
     ```
     default vesamenu.c32
     timeout 40
     prompt 0
     noescape 1
     menu title Administrative Tools
     menu background menu.png
     menu master passwd $4$tek7ROr8$xzFCb2QVEWsc2msx3QsErbRuo0Y$
        
     label memtest
     menu label ^Memory tester
     kernel memtest
     ```
        
If you boot any computer on your network off the NIC, you should see something like this:
       
{{< imgproc "boot-menu.png" Resize "500x" none >}}Main boot menu{{< /imgproc >}}
{{< imgproc "boot-menu-password" Resize "500x" none >}}Enter your password for Admin tools{{< /imgproc >}}
{{< imgproc "admin-tools" Resize "500x" none >}}Admin tools{{< /imgproc >}}
        
So now you have a double layered menu system with a password required to get to the second layer. For reference&#8217; sake, the current password is &#8220;purple&#8221;, and you can generate your own password by running sha1pass (included in the syslinux package).
        
If you wanted to add other administrative tools, you would add them to the file &#8220;admin&#8221; in netboot. For more information on how to add items to the menu, see [this page][10].

 [1]: /posts/2009/10/09/pxe-and-gpxe/
 [2]: http://rom-o-matic.net
 [4]: http://syslinux.zytor.com
 [5]: http://syslinux.zytor.com/wiki/index.php/Category:Comboot
 [6]: menu.png
 [10]: http://syslinux.zytor.com/wiki/index.php/Comboot/menu.c32
