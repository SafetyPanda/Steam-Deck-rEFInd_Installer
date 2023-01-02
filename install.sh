#!/bin/bash

refind_config_location="/boot/efi/efi/refind/"

#Check for Privs
if [[ "$EUID" -gt 0 ]]; then
    echo "ERROR: This operation requires escalated privileges. Exiting!"
    exit 1
fi

#Determine Package Manager
declare -A osInfo;

osInfo[/etc/fedora-release]=dnf
osInfo[/etc/arch-release]=pacman
osInfo[/etc/gentoo-release]=emerge
osInfo[/etc/SuSE-release]=zypp
osInfo[/etc/debian_version]=apt-get
osInfo[/etc/alpine-release]=apk

for f in ${!osInfo[@]}
do
    if [[ -f $f ]];then
        package_manager=${osInfo[$f]}
    fi
done

#Install Needed Package
${package_manager} install refind -y

#Copy (and Overwrite if needed) Refind and Icons
/bin/cp -f ./refind.conf.deck "${refind_config_location}/refind.conf"
/bin/cp -f ./icons/* "${refind_config_location}/icons/"

echo "Finished. Reboot to confirm it worked!"