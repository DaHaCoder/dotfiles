#!/bin/bash
#
# taken from https://www.dev47apps.com/droidcam/linux/

echo "First, Droidcam is going to be refreshed."
echo "========================================="

sudo apt install linux-headers-`uname -r` gcc make
cd ~/MyPrograms/Droidcam/
sudo ./install-video
cd ~

echo "Droidcam is now refreshed."
echo "=========================="

sudo rmmod v4l2loopback_dc
echo "Insert resolution width (i.e., '1280' for 720p/HD or '1920' for 1080p/Full-HD): "
read WIDTH
echo "Insert resolution height (i.e., '720' for 720p/HD or '1080' for 1080p/Full-HD): "
read HEIGHT

sudo insmod /lib/modules/`uname -r`/kernel/drivers/media/video/v4l2loopback-dc.ko width=$WIDTH height=$HEIGHT

echo "Want to make the change permanent ? [y/n] "
read answer
if [[ $answer == "y" ]]; then
    echo "options v4l2loopback_dc width=$WIDTH height=$HEIGHT" | sudo tee /etc/modprobe.d/droidcam.conf ;
    echo "Change is now permanent and saved in '/etc/modprobe.d/droidcam.conf'."
fi
echo "Restart all Droidcam instances."
echo "================================================================================"
