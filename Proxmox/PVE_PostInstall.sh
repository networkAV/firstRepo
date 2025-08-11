#!/bin/bash

#==========================================================
# PVE Host build script
# Allen Vonderschmidt
# 12/11/24
#


#==========================================================
# Define variables

NOSUBSOURCE=/etc/apt/sources.list.d/pve-no-enterprise.list
ENTSOURCE=/etc/apt/sources.list.d/pve-enterprise.list
CEPHSOURCE=/etc/apt/sources.list.d/ceph.list
GRUB_FILE=/etc/default/grub
VFIO_MOD=/etc/modules

#==========================================================
#  Create PVE Subscription files

read -p "Update Subscriptions? [Yy] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]
then
echo "Updating Subscription sources\n"

cat << 'EOF' > ${NOSUBSOURCE}
# not for production use
deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription
EOF

cat << 'EOF' > ${ENTSOURCE}
# For production enterprise use.
## #deb https://enterprise.proxmox.com/debian/pve bookworm pve-enterprise
EOF

cat << 'EOF' > ${CEPHSOURCE}
# For production enterprise use.
## #deb http://download.proxmox.com/debian/ceph-quincy bookworm no-subscription

# not for production use
deb http://download.proxmox.com/debian/ceph-quincy bookworm no-subscription
EOF

    # end Subcriptions
fi
#==========================================================
# Run updates
read -p "Run Updates? [Yy] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]
then

echo "Running updates"

apt update
apt -y install openvswitch-switch net-tools lshw nmap htop fio zfsutils zfs-initramfs snmp snmpd nut nut-client nut-server needrestart
# apt -y install iperf3 
apt -y dist-upgrade

    # end updates
fi



#==========================================================
#  Create Ice Admin account
read -p "Create IceAdmin user? [Yy] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]
then
echo "Creating IceAdmin account and group"
groupadd pveadmin -g 900
useradd -g 900 -u 1000 -c "Administrator for Ice Systems" -m -d /home/iceman -s /usr/bin/bash iceman
    # end IceAdmin account
fi

#==========================================================
# Remove subscription for non-production
read -p "Remove no subscriptions warning? [Yy] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]
then

echo "Removing no subscription warning..."

sed -Ezi.bak "s/(function\(orig_cmd\) \{)/\1\n\torig_cmd\(\);\n\treturn;/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart pveproxy.service

    # end Subcription warnings
fi

#==========================================================
# SMART Monitoring
#   https://pve.proxmox.com/wiki/Disk_Health_Monitoring
# Edit this loop to enable SMART monitoring

## #for I in a b c d e f g h i j
## #do
## #   echo "/dev/sd${I}"
## #   smartctl -s on /dev/sd${I}
## #done

#==========================================================
# PCI Passthrough

read -p "Update PCI Passthrough? [Yy] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]
then

echo "Updating GRUB"
sed -Ezi.bak "s/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet\"/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet intel_iommu=on iommu=pt\"/g" ${GRUB_FILE}

# VFIO modules
echo "Updating VFIO modules"

cat << 'EOF' >> ${VFIO_MOD}
vfio
vfio_iommu_type1
vfio_pci
vfio_virqfd
EOF

echo "Run update-iniramfs"
/usr/sbin/update-initramfs -u -k all

    # end PCI Passthrough
fi
