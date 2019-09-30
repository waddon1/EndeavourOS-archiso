#!/bin/bash

# Download and install keyring and mirrorlist
wget https://github.com/EndeavourOS/repository/releases/download/repository/endeavour-keyring-1-1-any.pkg.tar.xz
pacman -U endeavour-keyring-1-1-any.pkg.tar.xz
wget https://github.com/EndeavourOS/repository/releases/download/repository/endeavour-mirrorlist-1-2-any.pkg.tar.xz
pacman -U endeavour-mirrorlist-1-2-any.pkg.tar.xz
rm endeavour-keyring-1-1-any.pkg.tar.xz endeavour-mirrorlist-1-2-any.pkg.tar.xz

# Comment antegos repos
cat /etc/pacman.conf |grep "antergos" >/dev/null
[[ $? == 0 ]] && sed -i "/\[antergos\]/,/antergos-mirrorlist/"'s/^/#/' /etc/pacman.conf; sed -i "/\[antergos-staging\]/,/antergos-mirrorlist/"'s/^/#/' /etc/pacman.conf

# Inject Endeavour config at /etc/pacman.conf
cat <<EOF>> /etc/pacman.conf

[endeavour]
SigLevel = PackageRequired
Server = https://github.com/EndeavourOS/repository/releases/download/repository/
EOF

pacman -Syy
