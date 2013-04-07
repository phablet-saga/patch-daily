#!/bin/sh
rm /tmp/daily-patch -Rf
mkdir /tmp/daily-patch
mkdir /tmp/daily-patch/out
mkdir /tmp/daily-patch/tarball
mkdir /tmp/daily-patch/new
wget http://cdimage.ubuntu.com/ubuntu-touch-preview/daily-preinstalled/current/quantal-preinstalled-phablet-armhf.zip -O /tmp/daily-patch/quantal-preinstalled-phablet-armhf.zip

unzip /tmp/daily-patch/quantal-preinstalled-phablet-armhf.zip -d /tmp/daily-patch/out
cp ./updater-script /tmp/daily-patch/out/META-INF/com/google/android/updater-script

mv /tmp/daily-patch/out/manhattan-quantal-armhf-tar-*.tar.gz /tmp/daily-patch/out/manhattan-quantal-armhf-tar.tar.gz
gunzip -c /tmp/daily-patch/out/manhattan-quantal-armhf-tar.tar.gz > /tmp/daily-patch/out/manhattan-quantal-armhf-tar.tar

#New method, https://wiki.ubuntu.com/Touch/Porting#Screen_Pixel_Ratio
tar -rvf /tmp/daily-patch/out/manhattan-quantal-armhf-tar.tar binary/casper/filesystem.dir/etc/ubuntu-session.d/saga.conf

gzip -c /tmp/daily-patch/out/manhattan-quantal-armhf-tar.tar > /tmp/daily-patch/out/manhattan-quantal-armhf-tar.tar.gz
rm /tmp/daily-patch/out/manhattan-quantal-armhf-tar.tar

startdir=`pwd`
cd /tmp/daily-patch/new
cp /tmp/daily-patch/out/* . -R

zip -r quantal-preinstalled-phablet-armhf.zip *
mv quantal-preinstalled-phablet-armhf.zip $startdir
