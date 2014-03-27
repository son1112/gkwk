#!/bin/bash

#PURPOSE:
#The purpose of GEEK-rapid.sh is to repeat the action of running GEEK.sh

#TESTS:
#test comment for symlink

while true
do
    $HOME/bin/GEEK.sh $1
    sleep 0.25
done

