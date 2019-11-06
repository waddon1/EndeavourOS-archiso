These are the basic needed files and folders to build EndeavourOS system.

To get more info on how we put everything together read here:
https://github.com/endeavouros-team/EndeavourOS-archiso/wiki/EndeavourOS-ISO

[![Maintenance](https://img.shields.io/maintenance/yes/2019.svg)]()

## Add and enable endeavour Repository at your system

If you added the old endeavour repo, please uninstall

`sudo pacman -Rns endeavour-keyring endeavour-mirrorlist`

`remove the old repo from /etc/pacman.conf`

OBS: Do in this order!


install keyring package:


*bellow is an example, you may need to change to the latest package version. Please check https://github.com/endeavouros-team/mirrors/releases/tag/mirror2

`wget https://github.com/endeavouros-team/mirrors/releases/download/mirror2/endeavouros-keyring-1-4-any.pkg.tar.xz`

`wget https://github.com/endeavouros-team/mirrors/releases/download/mirror2/endeavouros-mirrorlist-1-6-any.pkg.tar.xz`

`sudo pacman -U endeavouros-keyring-1-4-any.pkg.tar.xz`

`sudo pacman -U endeavouros-mirrorlist-1-6-any.pkg.tar.xz`

add the repo bellow to your /etc/pacman.conf

`[endeavouros]`\
`SigLevel = PackageRequired`\
`Include = /etc/pacman.d/endeavouros-mirrorlist`

If you want to add calamares package add it's repo to your /etc/pacman.conf

`[endeavouros_calamares]`\
`SigLevel = PackageRequired`\
`Server = https://github.com/endeavouros-team/mirrors/releases/download/endeavouros_calamares/`\


If you want to add the developer repo add to your /etc/pacman.conf

`[endeavouros_developer]`\
`SigLevel = PackageRequired`\
`Server = https://github.com/endeavouros-team/mirrors/releases/download/mirror3-developer/`


* Uses the same signature that normal repo and has no mirrors package to install.


`sudo pacman -Syy`

## Install necessary packages
`sudo pacman -S archiso arch-install-scripts git --needed`

Clone:\
`git clone https://github.com/endeavouros-team/EndeavourOS-archiso.git`

`cd EndeavourOS-archiso`

## Run fix permissions script
`sudo ./fix_permissions.sh`

## Build
`sudo ./build.sh -v`

## The iso appears at out folder

Uses archiso from archlinux as base.

xfce4 as live environment
Basic tools for a livecd
Installer


![LiveISO Screenshot](https://raw.githubusercontent.com/endeavouros-team/artwork-images-logo/master/ISO-Shot.png "LiveISO Screenshot")
