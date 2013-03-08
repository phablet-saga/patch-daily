#!/bin/sh
rm /tmp/daily-patch -R
mkdir /tmp/daily-patch
mkdir /tmp/daily-patch/out
mkdir /tmp/daily-patch/tarball
mkdir /tmp/daily-patch/new
wget http://cdimage.ubuntu.com/ubuntu-touch-preview/daily-preinstalled/current/quantal-preinstalled-phablet-armhf.zip -O /tmp/daily-patch/quantal-preinstalled-phablet-armhf.zip

unzip /tmp/daily-patch/quantal-preinstalled-phablet-armhf.zip -d /tmp/daily-patch/out
cp ./updater-script /tmp/daily-patch/out/META-INF/com/google/android/updater-script

tar -C /tmp/daily-patch/tarball -xvzf /tmp/daily-patch/out/manhattan-quantal-armhf-tar*
patch /tmp/daily-patch/tarball/binary/casper/filesystem.dir/usr/bin/ubuntu-session ./saga-screen.patch

startdir=`pwd`
cd /tmp/daily-patch/new
cp /tmp/daily-patch/out/* . -R
for f in *.tar.gz
do
	rm $f
	tar -cvf - /tmp/daily-patch/tarball --strip=3 | gzip > manhattan-quantal-armhf-tar.tar.gz 
done

zip -r quantal-preinstalled-phablet-armhf.zip *
mv quantal-preinstalled-phablet-armhf.zip $startdir
