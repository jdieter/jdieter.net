---
title: About Me
description: I am the senior system administrator for the Lebanon Evangelical School, the lead computer teacher and a Fedora packager
date: 2018-03-31
type: about
showthedate: false
---
{{< imgproc "SAM_8909" Resize "300x" />}}

My CV is available [here][12]

I was the senior system administrator for the [Lebanon Evangelical School][1], where I accomplished the following:

 * Set up a [distributed filesystem][2] to store all school information including 2000+ home directories.  The filesystem was configured with three-way replication and daily snapshots
 * Implemented a three-way cluster of [FreeIPA][10] to store accounts of around 2000 students and staff, along with DNS configuration and DHCP IP mappings
 * Created an enterprise wireless network using [RADIUS][9] to grant users wireless network access, based on the account information in FreeIPA
 * Configured an [iPXE boot environment][8] to facilitate installation and configuration of our workstations
 * Automated configuration of our desktops using Ansible
 * Set up an [oVirt cluster][7] and virtualized most of our physical servers
 * Created and maintained a [web-based grading system][3] accessible by students, staff and parents, complete with an internal mirror kept up-to-date using MySQL replication
 * Converted workstations from Windows to [Fedora][6]
 * Automated notifications of outages and sub-normal service performance using Nagios
 * Migrated servers from Windows to [Fedora][4] and [CentOS][5]


As the lead computer teacher, I also accomplished the following:  

 * Created and maintained an engaging [six-year IT curriculum][11] that uses open source software
 * Designed and taught an after-school robotics course using Python, Legos and Nintendo Wiimotes to create self-steering cars, robots that played tag, and robot sumo wrestling


As a Fedora packager, I am responsible for the following:  

 * Created, packaged, and maintained a yum plugin called yum-presto that allowed users to download deltarpms rather than full rpms when updating their systems.  The plugin was eventually included by default in Fedora releases and was subsequently merged into Red Hat Enterprise Linux and is still available in RHEL 6.  Newer Fedora and RHEL releases have merged yum-presto’s functionality directly into yum and dnf.
 * Maintain the deltarpm package in Fedora and contribute upstream
 * Maintain the LizardFS distributed filesystem in Fedora and EPEL

 [1]: https://www.lesbg.com
 [2]: https://lizardfs.com
 [3]: https://lesson.lesbg.com
 [4]: https://getfedora.org/en/server
 [5]: https://www.centos.org
 [6]: https://getfedora.org/en/workstation
 [7]: https://www.ovirt.org
 [8]: https://ipxe.org
 [9]: https://freeradius.org
 [10]: https://www.freeipa.org
 [11]: https://fedoramagazine.org/fedora-teaches-makers-school
 [12]: CV.pdf
