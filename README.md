These are the basic needed files and folders to build EndeavourOS system.

# Install necessary packages first
`sudo pacman -S archiso arch-install-scripts git`

Clone:
`git clone https://gitlab.com/EndeavourOS/endeavour_archiso.git`

`cd endeavour_archiso`

# Run fix permissions script
`sudo ./fix_permissions.sh`

# Build
`sudo ./build.sh -v`

# The iso appears at work folder

Uses archiso from archlinux as base.

xfce4 as live environment
Basic tools for a livecd
Installer

*
package signing at tempoary repository is not fixed yet.
need to change pacman.conf entry to:
`[endeavour]<br>
#SigLevel = PackageRequired
SigLevel = Optional TrustAll<br>
Server = https://github.com/EndeavourOS/repository/releases/download/repository/<br>
`


