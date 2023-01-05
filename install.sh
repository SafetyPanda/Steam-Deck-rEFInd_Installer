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
osInfo[/etc/debian_version]=apt-get

for f in ${!osInfo[@]}
do
    if [[ -f $f ]];then
        package_manager=${osInfo[$f]}
    fi
done
echo ${package_manager}
#Install Needed Package
case ${package_manager} in
    dnf)
        #Current version downloaded from Source: 050123
        wget -O refind-0.13.3.1-1.x86_64.rpm https://sourceforge.net/projects/refind/files/0.13.3.1/refind-0.13.3.1-1.x86_64.rpm/download
        ${package_manager} install refind-0.13.3.1-1.x86_64.rpm -y
        ;;
    apt-get)
        ${package_manager} install refind -y
        ;;
    pacman)
        ${package_manager} -S refind -y
        ;;
    emerge)
        ${package_manager} refind
        ;;
    *)
        echo "Unknown Package Manager"
        exit 1
        ;;
esac


#Copy (and Overwrite if needed) Refind and Icons
/bin/cp -f ./refind.conf.deck "${refind_config_location}/refind.conf"
/bin/cp -f ./icons/* "${refind_config_location}/icons/"

echo "Finished. Reboot to confirm it worked!"