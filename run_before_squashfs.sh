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
sed -i 's~\#GRUB_BACKGROUND=.*~GRUB_BACKGROUND=\/usr\/share\/endeavouros\/splash.png~g' /etc/default/grub
echo 'GRUB_DISABLE_SUBMENU=y' >> /etc/default/grub
wget https://github.com/Portergos/calamares/raw/master/cleaner_script.sh
chmod +x cleaner_script.sh
mv cleaner_script.sh /usr/bin/cleaner_script.sh"
#injecting Desktop settings for LiveUser:
git clone https://github.com/endeavouros-team/liveuser-desktop-settings.git
cd liveuser-desktop-settings
cp -R .config /home/liveuser/
cd .. 
rm -R liveuser-desktop-settings
}

#################################
########## STARTS HERE ##########
#################################

do_merge

