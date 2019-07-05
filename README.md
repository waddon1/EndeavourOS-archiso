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

If you added the old endeavour repo, please uninstall

`sudo pacman -Rns endeavour-keyring endeavour-mirrorlist`

`remove the old repo from /etc/pacman.conf`

OBS: Do in this order!


install keyring package:

`wget wget https://github.com/endeavouros-team/repository/releases/download/repository/endeavouros-keyring-1-1-any.pkg.tar.xz`

`wget https://github.com/endeavouros-team/repository/releases/download/repository/endeavouros-mirrorlist-1-1-any.pkg.tar.xz`

`sudo pacman -U endeavouros-keyring-1-1-any.pkg.tar.xz`

`sudo pacman -U endeavouros-mirrorlist-1-1-any.pkg.tar.xz`

add the repo bellow to your /etc/pacman.conf

`[endeavouros]`\
`SigLevel = PackageRequired`\
`Include = /etc/pacman.d/endeavouros-mirrorlist`\


`sudo pacman -Syy`

![LiveISO Screenshot](https://raw.githubusercontent.com/endeavouros-team/artwork-images-logo/master/ISO-Shot.png "LiveISO Screenshot")
