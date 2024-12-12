#==========================================================
# SMART Monitoring
#   https://pve.proxmox.com/wiki/Disk_Health_Monitoring
# Edit this loop to enable SMART monitoring

for I in a b c d e f g h
do
   echo "/dev/sd${I}"
   echo "    `smartctl -a /dev/sd${I} | grep 'Accumulated power on time'`"
   echo "    read GB: `smartctl -a /dev/sd${I} | grep '^read:' | awk '{print $7}'`"
   echo "    write GB: `smartctl -a /dev/sd${I} | grep '^write:' | awk '{print $7}'`"
done
