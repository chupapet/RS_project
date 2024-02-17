#!/bin/sh
jffs2reset -y
wget http://github.com/chupapet/RS_project/raw/main/r281_firmware.bin -O /tmp/firmware.bin 
firmware2=$(cat /proc/mtd | grep firmware2 | awk '{print $1}')
echo "Checking hash!"
hash=$(md5sum /tmp/firmware.bin | awk '{print $1}')
echo "$hash = d7e732e73675976c0268e4c9aba56d79"
if [ $hash == 'd7e732e73675976c0268e4c9aba56d79' ]
then
echo "Firmware upgrading on process..."
if [ $firmware2 == 'mtd7:' ];
then
echo "Wait for the modem to reboot..."
mtd -r write /tmp/firmware.bin /dev/mtd4
exit
fi
echo "Wait for the modem to reboot..."
mtd -r write /tmp/firmware.bin /dev/mtd5
exit
else
echo "Not same!"
fi