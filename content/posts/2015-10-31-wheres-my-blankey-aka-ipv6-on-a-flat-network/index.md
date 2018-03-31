---
title: Where’s my blankey? (aka IPv6 on a flat network)
author: jdieter
type: post
date: 2015-10-31T21:33:23+00:00
url: /posts/2015/10/31/wheres-my-blankey-aka-ipv6-on-a-flat-network
categories:
  - Computers
tags:
  - dhcp
  - DHCP server
  - dhcpy6d
  - IPv6
  - ISC dhcpd

---
{{< imgproc "comfort" Resize "300x" >}}Familiarity is comforting{{< /imgproc >}}

_At the Lebanon Evangelical School &#8211; Loueizeh, we try to push the envelope when it comes to testing new technology.  [Our website][2] makes efficient use of some of the latest CSS technology from 1996, and we have just started experimenting with this new-fangled IPv6 technology, also from the mid 90&#8217;s.  Cue [Macarena][3] single&#8230;_

&lt;tl;dr&gt;
If you&#8217;re on a flat network and want to match MAC addresses to IPv6 addresses, ditch [ISC&#8217;s DHCPv6 server][4], and instead use [dhcpy6d][5]
&lt;/tl;dr&gt;

After years of asking, our [ISP][6] has finally given us an IPv6 /48 prefix, so I finally have the privilege of setting up an IPv6 network to coexist with our IPv4 network.  Yay!  As an aside, I think we&#8217;re one of the first organizations in Lebanon to be working with IPv6.  A couple of years ago, I asked our old ISP about getting an IPv6 address and was told that they didn&#8217;t have any.  There were plenty of IPv4 addresses to go around, so why bother?  But I digress&#8230;

Our current IPv4 topology is&#8230; flat.  Very flat.  We use a single 10._x_._y_._z_ internal IP range, given out by [two DHCP servers][7], where _x_ is a fixed number, _y_ is the category of the device and _z_ is the individual address.  The categories allow us to divide devices into guest, staff and student groups.  We are very aware that MAC addresses can be easily spoofed, so these categories are primarily used for traffic shaping and nothing security related.  I am aware of (and would like to start working with) VLANs, but not all of our networking equipment supports them.

So our primary requirement for IPv6 is that we are able to set up corresponding categories to match our IPv4 categories (_y_ in 10._x_._y_._z_).  Another requirement is that we use some form of static IP addresses for logging purposes and that these static addresses be somehow tied to a device&#8217;s corresponding IPv4 address, mainly for convenience.

My first plan was to use [SLAAC][8], which allows us to use 16 bits to specify categories (double what we have with our IPv4 addresses), while still allowing the client 64 bits to use in coming up with its own address.  Unfortunately, SLAAC falls down for us on both categories and static addresses.  To implement categories properly, we&#8217;d need to divide our network into VLANs, and we still have a few unmanaged switches that don&#8217;t know how to handle them.  And, while some devices just use their MAC addresses to generate their unique address, others (especially the more modern mobile OS&#8217;s which automatically implement [RFC4941][9]) will generate random unique addresses, which causes problems if we want to track who&#8217;s doing what.

Plan B was to use [DHCPv6][10], which isn&#8217;t that much of a stretch, seeing as we&#8217;re already using DHCP on our IPv4 network.  Granted, since Android [doesn&#8217;t work with DHCPv6][11] (really, Google?), that means all of the Android devices on our network will be stuck on IPv4, but, since we&#8217;re still in the experimental stage, I&#8217;m ok with that.  With DHCPv6 I can choose which address each device gets, allowing me to specify both categories and static (randomly generated) IP addresses.  So I started putting together an ISC DHCPv6 server, looked at the examples, and&#8230; &#8220;Where the heck am I supposed to put the MAC address?&#8221;

You see, in their infinite wisdom, the [IETF][12] decided that MAC addresses were no longer sufficient to tell the DHCPv6 server what IP address we should get.  No, now we get to use these new things called [DUIDs][13] which last forever like MAC addresses, but stay the same for all interfaces on a system, unlike MAC addresses.  Woo-hoo!  There are some small exceptions, especially with a computer or phone as opposed to an embedded device.  The DUID will not be automatically be the same if you dual boot.  Or if you wipe the OS.  Or, if like us, you make extensive use of netbooting for system maintenance.  But other than that, DUIDs will last forever.

The best part is that there are multiple ways of generating a DUID (including straight from the MAC address), but the server doesn&#8217;t have any say in telling the clients how it wants its DUIDs generated.  That means that clients like NetworkManager will quite happily generate a DUID based on `/etc/machine-id`, which is itself randomly generated the first time a system is booted.  Not very useful if you want to pass the same IP address whether a system is being netbooted into maintenance mode or booting normally off of the hard drive.

Now, all this wouldn&#8217;t be insurmountable, except for the fact that I currently have a database of MAC addresses matched with IPv4 addresses (complete with categories), but, because DUIDs don&#8217;t necessarily have anything to do with the MAC address, I have no idea how to match that same device to the IPv6 address I want to give it.

Apparently [ISC&#8217;s DHCPv6 server][4] has implemented a relatively new [specification][14] that allows link-local addresses to be sent to the DHCPv6 server through a relay, but our network is already flat, so I shouldn&#8217;t need to screw around with a relay.

There&#8217;s also some ambiguity about the [Confirm message][15] in DHCPv6.  The specific section says:

> When the server receives a Confirm message, the server determines whether the addresses in the Confirm message are appropriate for the link to which the client is attached. If all of the addresses in the Confirm message pass this test, the server returns a status of Success. If any of the addresses do not pass this test, the server returns a status of NotOnLink.

The question is, if I&#8217;ve changed the static IP address for a client, is the old address still appropriate for the link?  As the sysadmin, my answer is, &#8220;No, please discontinue use of the old address immediately.&#8221;  Unfortunately, the ISC DHCPv6 server disagrees with me and will happily confirm the old addresses until the cows come home.

After a bit of searching, I&#8217;ve found a solution that I&#8217;m actually quite happy with.  The Leibniz Institute for Solid State and Materials Research in Dresden has released a DHCPv6 server called [dhcpy6d][5] written in Python that allows you to match based on MAC address, DUID or a combination of both.  There have been a few bugs in it, and it&#8217;s not yet handling Confirm messages the way I&#8217;d like it to, but [upstream][16] has been very responsive, and I&#8217;m looking forward to having an IPv6 system that works for us.

We&#8217;re not quite up and running 100% yet, but I hope to be there by the second week of November.  Of course, I had hoped to get some work done during this long weekend, but God had other plans (at least, judging by the lightning that destroyed quite a bit of my networking equipment at home just before school let out for the weekend).

 [2]: http://www.lesbg.com
 [3]: https://play.google.com/store/music/album?id=Bqtevkvi5dkmiusngpaqxv7ieyq&tid=song-Tmbbtdhu6vosbo3d4272zqymrhi
 [4]: https://www.isc.org/downloads/dhcp/
 [5]: https://dhcpy6d.ifw-dresden.de
 [6]: http://wise.net.lb
 [7]: /posts/2014/10/22/using-freeipa-as-a-backend-for-dhcp/
 [8]: https://en.wikipedia.org/wiki/IPv6#Stateless_address_autoconfiguration_.28SLAAC.29
 [9]: https://tools.ietf.org/html/rfc4941
 [10]: https://en.wikipedia.org/wiki/DHCPv6
 [11]: https://code.google.com/p/android/issues/detail?id=32621#c53
 [12]: https://en.wikipedia.org/wiki/Internet_Engineering_Task_Force
 [13]: https://en.wikipedia.org/wiki/DHCPv6#DHCP_Unique_Identifier
 [14]: https://tools.ietf.org/html/rfc6939
 [15]: https://tools.ietf.org/html/rfc3315#section-18.2.2
 [16]: https://github.com/HenriWahl/dhcpy6d
