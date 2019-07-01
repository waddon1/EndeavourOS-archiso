These are the basic needed files and folders to build EndeavourOS system.

# Install necessary packages first
`sudo pacman -S archiso arch-install-scripts git`

Clone:\
`git clone https://github.com/endeavouros-team/archiso-offlineinstaller.git`

`cd archiso-offlineinstaller`

# Run fix permissions script
`sudo ./fix_permissions.sh`

# Build
`sudo ./build.sh -v`

# The iso appears at out folder

Uses archiso from archlinux as base.

xfce4 as live environment
Basic tools for a livecd
Installer

*
you will need to add and enable endeavour Repository at your system

OBS: Do in this order!


install keyring package:


`sudo pacman -U https://github.com/EndeavourOS/repository/releases/download/repository/endeavour-keyring-1-1-any.pkg.tar.xz`


`sudo pacman -U https://github.com/EndeavourOS/repository/releases/download/repository/endeavour-mirrorlist-1-3-any.pkg.tar.xz`

add the repo bellow to your /etc/pacman.conf

`[endeavour]`\
`SigLevel = PackageRequired`\
`Include = /etc/pacman.d/endeavour-mirrorlist`


`sudo pacman -Syy`

![LiveISO Screenshot](https://raw.githubusercontent.com/endeavouros-team/artwork-images-logo/master/ISO-Shot.png "LiveISO Screenshot")
