These are the basic needed files and folders to build EndeavourOS system.

To get more info on how we put everything together read here:
https://github.com/endeavouros-team/EndeavourOS-archiso/wiki/EndeavourOS-ISO

--> This is configured to run the build process inside an actual installed EndeavourOS system.

[![Maintenance](https://img.shields.io/maintenance/yes/2020.svg)]()
---
[![](https://sourcerer.io/fame/killajoe/endeavouros-team/EndeavourOS-archiso/images/0)](https://sourcerer.io/fame/killajoe/endeavouros-team/EndeavourOS-archiso/links/0)
[![](https://sourcerer.io/fame/killajoe/endeavouros-team/EndeavourOS-archiso/images/1)](https://sourcerer.io/fame/killajoe/endeavouros-team/EndeavourOS-archiso/links/1)
[![](https://sourcerer.io/fame/killajoe/endeavouros-team/EndeavourOS-archiso/images/2)](https://sourcerer.io/fame/killajoe/endeavouros-team/EndeavourOS-archiso/links/2)
[![](https://sourcerer.io/fame/killajoe/endeavouros-team/EndeavourOS-archiso/images/3)](https://sourcerer.io/fame/killajoe/endeavouros-team/EndeavourOS-archiso/links/3)
[![](https://sourcerer.io/fame/killajoe/endeavouros-team/EndeavourOS-archiso/images/4)](https://sourcerer.io/fame/killajoe/endeavouros-team/EndeavourOS-archiso/links/4)
[![](https://sourcerer.io/fame/killajoe/endeavouros-team/EndeavourOS-archiso/images/5)](https://sourcerer.io/fame/killajoe/endeavouros-team/EndeavourOS-archiso/links/5)
[![](https://sourcerer.io/fame/killajoe/endeavouros-team/EndeavourOS-archiso/images/6)](https://sourcerer.io/fame/killajoe/endeavouros-team/EndeavourOS-archiso/links/6)
[![](https://sourcerer.io/fame/killajoe/endeavouros-team/EndeavourOS-archiso/images/7)](https://sourcerer.io/fame/killajoe/endeavouros-team/EndeavourOS-archiso/links/7)
---

## Add and enable EndeavourOS Repository at your system

Add calamares package repo to your /etc/pacman.conf

`[endeavouros_calamares]`\
`SigLevel = PackageRequired`\
`Server = https://github.com/endeavouros-team/mirrors/releases/download/endeavouros_calamares/`

* Uses the same signature that normal repo and has no mirrors package to install.

`sudo pacman -Syy`

## Install necessary packages
`sudo pacman -S archiso mkinitcpio-archiso git squashfs-tools --needed`

Clone:\
`git clone https://github.com/endeavouros-team/EndeavourOS-archiso.git`

`cd EndeavourOS-archiso`

## Run fix permissions script
`sudo ./fix_permissions.sh`

## Build
`sudo ./build.sh -v`

## The iso appears at out folder

Uses archiso from archlinux as base.

* xfce4 as live environment
* Basic tools for a livecd
* Installer
* rescue tools included:

## liveiso.rescue-tools
* grsync
* dd
* ddrescue
* dd_rescue
* testdisk
* clonezilla
* partclone
* partimage
* gftp
* hdparm
* fsarchiver
* mc
* gparted

![LiveISO Screenshot](https://raw.githubusercontent.com/endeavouros-team/artwork-images-logo/master/EndeavourOS-ISO-2020.png "LiveISO Screenshot")
