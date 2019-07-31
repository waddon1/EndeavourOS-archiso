#!/bin/bash

# Made by Fernando "maroto"
# Run anything in the filesystem right before being "mksquashed"

script_path=$(readlink -f ${0%/*})
work_dir=work

# Adapted from AIS. An excellent bit of code!
arch_chroot(){
    arch-chroot $script_path/${work_dir}/airootfs /bin/bash -c "${1}"
}  

do_merge(){

arch_chroot "pacman-key --init
pacman-key --add /usr/share/pacman/keyrings/endeavouros.gpg && sudo pacman-key --lsign-key 497AF50C92AD2384C56E1ACA003DB8B0CB23504F
pacman-key --populate
pacman-key --refresh-keys
pacman -Syy
#sed -i 's~\#GRUB_BACKGROUND=.*~GRUB_BACKGROUND=\/usr\/share\/endeavouros\/splash.png~g' /etc/default/grub
sed -i 's~\#GRUB_THEME=.*~GRUB_THEME=\/boot\/grub\/themes\/EndeavourOS\/theme.txt~g' /etc/default/grub
echo 'GRUB_DISABLE_SUBMENU=y' >> /etc/default/grub
wget https://github.com/endeavouros-team/install-scripts/raw/master/cleaner_script.sh
wget https://github.com/endeavouros-team/install-scripts/raw/master/pacstrap_endeavouros
wget https://github.com/endeavouros-team/install-scripts/raw/master/calamares_switcher
chmod +x cleaner_script.sh pacstrap_endeavouros calamares_switcher
mv cleaner_script.sh pacstrap_endeavouros calamares_switcher /usr/bin/
wget https://raw.githubusercontent.com/endeavouros-team/liveuser-desktop-settings/master/dconf/mousepad.dconf
dbus-launch dconf load / < mousepad.dconf
sudo -H -u liveuser bash -c 'dbus-launch dconf load / < mousepad.dconf'
rm mousepad.dconf"

}

#################################
########## STARTS HERE ##########
#################################

do_merge
