These are the basic needed files and folders to build EndeavourOS system.

# Install necessary packages first
`sudo pacman -S archiso arch-install-scripts git`

Clone:\
`git clone https://gitlab.com/EndeavourOS/endeavour_archiso.git`

`cd endeavour_archiso`

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
adding:

`[endeavour]`\
`SigLevel = PackageRequired`\
`Server = https://github.com/EndeavourOS/repository/releases/download/repository/`

to your /etc/pacman.conf
install keyring package:
`sudo pacman -U https://github.com/EndeavourOS/repository/releases/download/repository/endeavour-keyring-1-1-any.pkg.tar.xz`
`sudo pacman -Syy`
