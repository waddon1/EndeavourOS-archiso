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

arch_chroot "

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen
ln -sf /usr/share/zoneinfo/UTC /etc/localtime
usermod -s /usr/bin/bash root
cp -aT /etc/skel/ /root/
chmod 700 /root
! id liveuser && useradd -m -p \"\" -g users -G 'adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel' -s /bin/bash liveuser
git clone https://github.com/endeavouros-team/liveuser-desktop-settings.git
cd liveuser-desktop-settings
rm -R /home/liveuser/.config
cp -R .config /home/liveuser/
cp LICENSE /home/liveuser/
chown -R liveuser:users /home/liveuser/.config
cd .. 
rm -R liveuser-desktop-settings
chmod 755 /etc/sudoers.d
mkdir -p /media
chmod 755 /media
chmod 440 /etc/sudoers.d/g_wheel
chown 0 /etc/sudoers.d
chown 0 /etc/sudoers.d/g_wheel
chown root:root /etc/sudoers.d
chown root:root /etc/sudoers.d/g_wheel
chmod 755 /etc
sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i 's/#Server/Server/g' /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf
sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf
systemctl enable NetworkManager.service vboxservice.service vmtoolsd.service vmware-vmblock-fuse.service systemd-networkd-wait-online systemd-timesyncd
systemctl set-default multi-user.target

cp -rf /usr/share/mkinitcpio/hook.preset /etc/mkinitcpio.d/linux.preset
sed -i 's?%PKGBASE%?linux?' /etc/mkinitcpio.d/linux.preset

pacman-key --init
pacman-key --add /usr/share/pacman/keyrings/endeavouros.gpg && sudo pacman-key --lsign-key 497AF50C92AD2384C56E1ACA003DB8B0CB23504F
pacman-key --populate
pacman-key --refresh-keys
pacman -Syy
sed -i 's|^GRUB_CMDLINE_LINUX_DEFAULT=\"\(.*\)\"$|GRUB_CMDLINE_LINUX_DEFAULT=\"\1 nowatchdog\"|' /etc/default/grub
sed -i 's?GRUB_DISTRIBUTOR=.*?GRUB_DISTRIBUTOR=\"EndeavourOS\"?' /etc/default/grub
sed -i 's?\#GRUB_THEME=.*?GRUB_THEME=\/boot\/grub\/themes\/EndeavourOS\/theme.txt?g' /etc/default/grub
echo 'GRUB_DISABLE_SUBMENU=y' >> /etc/default/grub
wget https://github.com/endeavouros-team/install-scripts/raw/master/cleaner_script.sh
wget https://github.com/endeavouros-team/install-scripts/raw/master/chrooted_cleaner_script.sh
wget https://github.com/endeavouros-team/install-scripts/raw/master/calamares_switcher
wget https://github.com/endeavouros-team/install-scripts/raw/master/pacstrap_calamares
wget https://raw.githubusercontent.com/endeavouros-team/install-scripts/master/update-mirrorlist
wget https://github.com/endeavouros-team/install-scripts/raw/master/calamares_for_testers
wget https://github.com/endeavouros-team/install-scripts/raw/master/rank_pacman_key.sh
chmod +x cleaner_script.sh chrooted_cleaner_script.sh calamares_switcher pacstrap_calamares update-mirrorlist calamares_for_testers rank_pacman_key.sh
mv cleaner_script.sh chrooted_cleaner_script.sh calamares_switcher update-mirrorlist pacstrap_calamares calamares_for_testers rank_pacman_key.sh /usr/bin/
wget https://raw.githubusercontent.com/endeavouros-team/liveuser-desktop-settings/master/dconf/mousepad.dconf
dbus-launch dconf load / < mousepad.dconf
sudo -H -u liveuser bash -c 'dbus-launch dconf load / < mousepad.dconf'
rm mousepad.dconf
chmod -R 700 /root
chown root:root -R /root
chown root:root -R /etc/skel
chmod 644 /usr/share/endeavouros/*.png
rm -rf /usr/share/backgrounds/xfce/xfce-stripes.png
ln -s /usr/share/endeavouros/backgrounds/endeavouros-wallpaper.png /usr/share/backgrounds/xfce/xfce-stripes.png
chsh -s /bin/bash"
}

#################################
########## STARTS HERE ##########
#################################

do_merge
