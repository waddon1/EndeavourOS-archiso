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
sed -i 's~\#GRUB_BACKGROUND=.*~GRUB_BACKGROUND=\/usr\/share\/endeavour\/splash.png~g' /etc/default/grub
echo 'GRUB_DISABLE_SUBMENU=y' >> /etc/default/grub
pacman -U /etc/skel/calamares_installer-1-1-x86_64.pkg.tar.xz --noconfirm
rm /etc/skel/calamares_installer-1-1-x86_64.pkg.tar.xz
rm /home/liveuser/calamares_installer-1-1-x86_64.pkg.tar.xz
chmod +x /usr/bin/cleaner_script.sh"

}

do_pacman_fix(){

arch_chroot "pacman-key --init
pacman-key --add /usr/share/pacman/keyrings/endeavour.gpg && sudo pacman-key --lsign-key 497AF50C92AD2384C56E1ACA003DB8B0CB23504F
pacman-key --populate
pacman-key --refresh-keys
pacman -Syy"

}

#do_dconf_dump(){
#arch_chroot "export DISPLAY=:0.0
#dbus-launch dconf load / < /etc/skel/dconf.conf
#sudo -H -u liveuser bash -c 'dbus-launch dconf load / < /etc/skel/dconf.conf'
#rm /etc/skel/dconf.conf
#rm /home/liveuser/dconf.conf"
#}

do_grub_config(){

arch_chroot "sed -i 's~\#GRUB_BACKGROUND=.*~GRUB_BACKGROUND=\/usr\/share\/endeavour\/splash.png~g' /etc/default/grub
echo 'GRUB_DISABLE_SUBMENU=y' >> /etc/default/grub"

}

do_install_extra(){

arch_chroot "pacman -U /etc/skel/calamares_installer-1-1-x86_64.pkg.tar.xz --noconfirm
rm /etc/skel/calamares_installer-1-1-x86_64.pkg.tar.xz
rm /home/liveuser/calamares_installer-1-1-x86_64.pkg.tar.xz"

}

#################################
########## STARTS HERE ##########
#################################

do_merge
#do_pacman_fix
#do_dconf_dump
#do_grub_config
#do_install_extra
