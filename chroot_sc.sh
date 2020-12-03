#!/bin/bash
if [ -z "$*" ]   
then 
    echo "usage: command chroot directory"
    exit 1
fi
comm=$(which $1 | grep '/')
chr_dir=$(pwd)/$2
mk_dir() {
    mkdir -p $chr_dir${1%/*}
}

if [ ! -d $2 ]
then
    mk_dir $chr_dir
fi

mk_dir $comm
cp $comm $chr_dir$comm

for i in $(ldd $comm| grep -o "/lib.*" | awk '{print $1}')
do 
    mk_dir $i
    cp  $i $chr_dir$i

done
echo "created chroot directory: $2 for app: $1 "
