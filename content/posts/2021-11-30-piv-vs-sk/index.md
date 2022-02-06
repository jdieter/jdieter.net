---
title: Yubikey - PIV vs Security Key
author: jdieter
description: A look at the options when securing SSH connections with a Yubikey
type: post
date: 2021-11-30T22:33:54+00:00
url: /posts/2021/11/30/piv-vs-sk
categories:
  - Computers
tags:
  - openssh
  - yubikey
  - piv
  - sk
---

{{<imgproc "key" Resize "x300" />}}

At my day job, we’ve just purchased Yubikeys for my team to help in the neverending process of securing our infrastructure.  While we’re looking at implementing MFA in a number of places, the starting point is securing our SSH connections to our servers.  We use FreeIPA to manage authorization and authentication through SSH, so key management is pretty straightforward.   The real question is how best to secure an SSH key using a Yubikey.  There are two main options: setting up a PIV key on the Yubikey or creating an OpenSSH Security Key (SK) key that requires the Yubikey to login.

I tried out the SK key first because [the documentation](https://n3x0.com/2020/02/17/openssh-now-supports-fido-u2f-security-keys-for-2-factor-authentication/) made it look like it was easiest to set up, and (perhaps surprisingly) it was!  Generating the key was a piece of cake.  From a security point of view, I prefer it because the key is stored on my laptop and can be protected with a passphrase.  Theft of the Yubikey alone isn’t enough to compromise the key.  Using the key is simple too.  I just need to have my Yubikey plugged into my laptop and tap on it after initiating the SSH session.

The first problem that came up is that our servers run an in-house rpm-ostree distribution based off of AlmaLinux 8, and the [latest release](http://mirror.webworld.ie/almalinux/8.5/BaseOS/x86_64/os/Packages) of OpenSSH there doesn’t support SK keys.  This problem was easily resolved by taking [Fedora’s OpenSSH builds](https://koji.fedoraproject.org/koji/packageinfo?packageID=96) and rebuilding them for our distribution.

The second problem could not be as easily solved, and has, unfortunately, caused me to abandon SK keys.  My team uses Ansible extensively, and we always deploy our changes using our own SSH keys so we can audit who has performed the changes.  Due to the way that Ansible re-uses SSH connections, you only have to tap the Yubikey once when deploying a change to a single server.  However, when deploying a change to many servers (we have over 100 call servers around the world), you have to tap the Yubikey for every. single. server.  This turns a minor speed bump into an insurmountable road block.

This brought me to our second option, PIV keys.  I'd passed them up because [setting them up](https://developers.yubico.com/PIV/Guides/SSH_with_PIV_and_PKCS11.html) is anything but simple, but most of the pain can be abstracted away, and the extra libraries are only required on the system that has the Yubikey connected.  The downside is that PIV keys are stored directly on the Yubikey (as a certificate, if I understand correctly), which means I now need to set a PIN on the Yubikey (otherwise someone can just plug the Yubikey in their computer and use my SSH key) and run extra commands to load the key into my SSH agent every time I insert my Yubikey.  I’m also limited to storing a single SSH key on my Yubikey.

PIV keys are more difficult to setup and maintain than OpenSSH SK keys, but they have one major advantage - Yubikey supports a [touch “cache”](https://docs.yubico.com/yesdk/users-manual/application-piv/pin-touch-policies.html) with PIV authentication.  This means that any SSH connections made within fifteen seconds of a Yubikey touch will be allowed to connect without requiring a second touch.  After configuring Ansible to perform up to 200 simultaneous connections, this reduces a full deployment from 100+ touches to 3, all within the first minute of the deployment.

If we could somehow get either the Yubikey or OpenSSH to support a touch cache for SK keys, I would switch to them in a heartbeat, but, until that feature is added (or we can find a workaround), we’re going to have to stick with PIV authentication.

As always, if you have any suggestions or comments, please either email me or ping me on twitter.
