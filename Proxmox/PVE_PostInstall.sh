#==========================================================
# PVE Host build script
# Allen Vonderschmidt
# 12/10/24
# 


#==========================================================
# Define variables

NOSUBSOURCE=/etc/apt/sources.list.d/pve-no-enterprise.list
ENTSOURCE=/etc/apt/sources.list.d/pve-enterprise.lis
CEPHSOURCE=/etc/apt/sources.list.d/ceph.list
#GRUB_FILE=/etc/default/grub
#VFIO_MOD=/etc/modules
# These 2 are set for testing.
GRUB_FILE=/root/tmp/grub
VFIO_MOD=/root/tmp/modules

#==========================================================
#  Create PVE Subscription files

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
#==========================================================
# Run updates
echo "Running updates"

apt update
apt -y install openvswitch-switch net-tools lshw nmap htop fio zfsutils zfs-initramfs
apt -y dist-upgrade



#==========================================================
#  Create Ice Admin account
echo "Creating IceAdmin account and group"

groupadd pveadmin -g 900
useradd -g 900 -u 1000 -c "Administrator for Ice Systems" -m -d /home/iceadmin -s /usr/bin/bash iceadmin
echo "iceadmin:iceadmin" | chpasswd

#==========================================================
# Remove subscription for non-production
echo "Removing Subscription"

sed -Ezi.bak "s/(function\(orig_cmd\) \{)/\1\n\torig_cmd\(\);\n\treturn;/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart pveproxy.service

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


