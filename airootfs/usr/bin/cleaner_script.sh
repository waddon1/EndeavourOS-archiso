#!/bin/bash

    # Clean up installation
    rm -rf /vomi 2>>/tmp/.errlog
    #rm -rf ${BYPASS} 2>>/tmp/.errlog
    rm -rf /source 2>>/tmp/.errlog
    rm -rf /src 2>>/tmp/.errlog
    rmdir /bypass 2>>/tmp/.errlog
    rmdir /src 2>>/tmp/.errlog
    rmdir /source 2>>/tmp/.errlog
    rm -f /etc/sudoers.d/g_wheel 2>>/tmp/.errlog
    rm -f /var/lib/NetworkManager/NetworkManager.state 2>>/tmp/.errlog
    sed -i 's/.*pam_wheel\.so/#&/' /etc/pam.d/su 2>>/tmp/.errlog
    #mv -f /etc/skel/.xsession /etc/skel/.xsession.bak
    #mv -f /home/$USER/.xsession /home/$USER/.xsession.bak
  
    # clean out archiso files from install 
    find /usr/lib/initcpio -name archiso* -type f -exec rm '{}' \;

    rm -Rf /etc/systemd/system/{choose-mirror.service,pacman-init.service,etc-pacman.d-gnupg.mount,getty@tty1.service.d}
    rm -Rf /etc/systemd/scripts/choose-mirror
    rm -f /etc/systemd/system/getty@tty1.service.d/autologin.conf
    rm -f /root/{.automated_script.sh,.zlogin}
    rm -f /etc/mkinitcpio-archiso.conf
    rm -Rf /etc/initcpio
    rm -Rf /etc/udev/rules.d/81-dhcpcd.rules
    rm -rf /home/$USER/scripts/fix_boot_iso.sh
    rm -rf /etc/systemd/system/fix_boot_iso.service

    # Clean installer stuff
    rm -rf /offline_installer
    rm -rf /etc/skel/.local/share/applications/offline_installer.desktop
    rm -rf /home/$USER/.local/share/applications/offline_installer.desktop

    rm -rf /home/$USER/{.xinitrc,.xsession} 2>>/tmp/.errlog
    rm -rf /home/$USER/.portergos_configs/{.xinitrc_i3,.xinitrc_xfce4,.xinitrc_openbox,.welcome_screen} 2>>/tmp/.errlog
    rm -rf /etc/skel/{.xinitrc,.xsession} 2>>/tmp/.errlog
    rm -rf /etc/skel/.portergos_configs/{.xinitrc_i3,.xinitrc_xfce4,.xinitrc_openbox,.welcome_screen} 2>>/tmp/.errlog

    #.welcome_screen,
    sed -i sed "/if/,/fi/"'s/^/#/' /home/$USER/.bash_profile
    sed -i sed "/if/,/fi/"'s/^/#/' /home/$USER/.zprofile

    # Journal
    sed -i 's/volatile/auto/g' /etc/systemd/journald.conf 2>>/tmp/.errlog

    # Fix NetworkManager
    systemctl enable NetworkManager -f 2>>/tmp/.errlog
    systemctl disable multi-user.target 2>>/dev/null
    #systemctl enable sddm 2>>/dev/null
    systemctl enable lightdm 2>>/dev/null
    systemctl enable vboxservice 2>>/dev/null
    systemctl enable org.cups.cupsd.service 2>>/dev/null
    systemctl enable avahi-daemon.service 2>>/dev/null
    systemctl disable pacman-init.service choose-mirror.service

    rm -rf /usr/bin/cleaner_script.sh
 
