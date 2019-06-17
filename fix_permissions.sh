#!/bin/bash


# For all folders
find ./airootfs -type d -exec chmod -R 755 {} \;
#find ./airootfs -type d -exec chown root:root {} \;
chown root:root $(find ./airootfs |grep -v "/etc/skel")

chmod 700 ./airootfs/root
chmod -R 755 airootfs/etc/sudoers.d
chmod 755 ./airootfs/etc/sudoers.d
chmod 755 ./airootfs/root

# The iso creation will handle the file later, otherwise uploading to git gets complicated
chmod 444 ./airootfs/etc/sudoers.d/g_wheel
#chmod 644 ./airootfs/etc/systemd/system/*.service
chown 0 ./airootfs/etc/sudoers.d
chown 0 ./airootfs/etc/sudoers.d/g_wheel
chown root:root ./airootfs/etc/sudoers.d
chown root:root ./airootfs/etc/sudoers.d/g_wheel
chmod 755 ./airootfs/etc

chmod +x ./airootfs/offline_installer/installer
#chmod +x ./airootfs/etc/skel/Desktop/{offline.desktop}
#,online.desktop}
#,calamares.desktop}
#chmod +x ./airootfs/usr/bin/cleaner_script.sh

# Just in case
chmod +x ./{build.sh,mkarchiso,run_before_squashfs.sh,inject_repo.sh}


