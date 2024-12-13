DTG=` date +%y%m%d`
FILE=/root/fio_output_${DTG}
echo "" > ${FILE}

echo "=========================================================================================" >> ${FILE}
echo "====== randwrite iodepth=64                                                     =========" >> ${FILE}
fio --name=RWTest --ioengine=sync --bs=4k --iodepth=64 --size=4G --runtime=60 --group_reporting=1 --randrepeat=1 --direct=1 --gtod_reduce=1 --filename=random_read_write.fio --readwrite=randrw --rwmixread=75 >>${FILE}
echo "=========================================================================================" >> ${FILE}
