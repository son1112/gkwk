#!/bin/bash

# TODO:
## create org file for practicing tangling of this script in org-mode
## add option to take user input for the filename variable, currently a constant "geek"
# FUNCTION example: import -window root png:$HOME/mnt/home/lintian/my_geek_week/xwd-$(date +%s)$$.png")

NAME=$1
GEEKWK=$HOME/gkwk
PAD_LENGTH=5
SHRT_LENGTH=3
NUM_TEST=$GEEKWK/num.test

# check for the num.test file for counting
if [ ! -e ${NUM_TEST} ] ; then
	echo "0" > $NUM_TEST
fi

# set up the counter as whatever the num.test file says it should be
COUNTER=$(cat $NUM_TEST)

# set up the naming convention for the file, using the counter variable for incrimental numbering, 
# take the screenshot and name it accordingly, increase the number and echo it back to the 
# counter/numtest file    
OUTFILE=$(printf "${NAME}%0${PAD_LENGTH}i\n" "${COUNTER}")

import -window root png:${GEEKWK}/${OUTFILE}.png


let COUNTER++

echo $COUNTER > $NUM_TEST


