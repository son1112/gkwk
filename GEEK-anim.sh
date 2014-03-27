#!/bin/bash

# GEEK-anim.sh 
# creates a movie from a series of png files

NAME=$1
RATE=$2
PAD_LENGTH=5
SHRT_LENGTH=3
GKWK=$HOME/gkwk
WORK=$GKWK/$NAME

set -e

if [ ! -d $GKWK/$NAME ] ; then
    mkdir $GKWK/$NAME
fi


if [ "$(ls $GKWK | grep $NAME | grep png)" ] ;then
    mv -v $GKWK/$NAME*.png $WORK
fi

cd $WORK &&
ffmpeg -y -framerate $RATE -pattern_type glob -i '*.png' -c:v libx264 -pix_fmt yuv420p $NAME.mp4 &&
ffmpeg -y -i $WORK/$NAME.mp4 $HOME/son-pub/vids/$NAME.webm










## GRAVEYARD #########################################################

# if [ ! -d small ] ; then
#     mkdir small
# fi


# create smaller versions of the png files within the small directory
# mogrify -verbose -path small -resize 50% *.png 

# for file in *.png; do
#     if [ ! -e small/$file ] ; then
# 	convert -resize 50% "$file" "small/$file"
#     fi
# done
# # change to the small directory and create an animated gif using the smaller pngs
# cd small

# convert -delay 5 -loop 0 $NAME$COUNTER*.png anim-$NAME$COUNTER.gif 
