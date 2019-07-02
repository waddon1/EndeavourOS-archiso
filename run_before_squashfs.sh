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
pacman-key --add /usr/share/pacman/keyrings/endeavour.gpg && sudo pacman-key --lsign-key 497AF50C92AD2384C56E1ACA003DB8B0CB23504F
pacman-key --populate
pacman-key --refresh-keys
pacman -Syy
export DISPLAY=:0.0
#dbus-launch dconf load / < /etc/skel/dconf.conf
#sudo -H -u liveuser bash -c 'dbus-launch dconf load / < /etc/skel/dconf.conf'
#rm /etc/skel/dconf.conf
#rm /home/liveuser/dconf.conf
sed -i 's~\#GRUB_BACKGROUND=.*~GRUB_BACKGROUND=\/usr\/share\/endeavouros\/splash.png~g' /etc/default/grub
echo 'GRUB_DISABLE_SUBMENU=y' >> /etc/default/grub
pacman -U /etc/skel/calamares_installer-1-1-x86_64.pkg.tar.xz --noconfirm
rm /etc/skel/calamares_installer-1-1-x86_64.pkg.tar.xz
rm /home/liveuser/calamares_installer-1-1-x86_64.pkg.tar.xz
rm /root/calamares_installer-1-1-x86_64.pkg.tar.xz
rm /root/install.txt
wget https://github.com/Portergos/calamares/raw/master/cleaner_script.sh
chmod +x cleaner_script.sh
mv cleaner_script.sh /usr/bin/cleaner_script.sh"

}



#################################
########## STARTS HERE ##########
#################################

do_merge

