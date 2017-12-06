#!/bin/bash

# ARK: Survival Evolved Mod Updater
# Written by: Eric Mathison
# https://github.com/ericmathison007/gaming/edit/master/tools/ark/ark-updatemods.sh

# Store ARK mod IDs space delimited
mods=( 630601751 693416678 708807240 731604991 793605978 895711211 924933745 )

# ARK installation dir
arkdir="/home/ark/server"

rm -rf $arkdir/steamapps/workshop/appworkshop_346110.acf

for i in "${mods[@]}"
do
        # Delete mod dir if it already exists
        if [ -d "$arkdir/ShooterGame/Content/Mods/$i" ]; then
                rm -r $arkdir/ShooterGame/Content/Mods/$i
        fi

        # Download latest files for mod
        /usr/games/steamcmd +login anonymous +force_install_dir $arkdir +workshop_download_item 346110 $i +quit
done

mv $arkdir/steamapps/workshop/content/346110/* $arkdir/ShooterGame/Content/Mods/

rm -rf $arkdir/steamapps/workshop/content/346110

# Decompress ARK zlib files
for file in $(find "$arkdir/ShooterGame/Content/Mods" -type f -name '*.z')
do
        python /home/ark/z_unpack.py $file "${file%.*}"
        rm -rf $file $file.uncompressed_size
done
