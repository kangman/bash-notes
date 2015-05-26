#!/bin/bash

#this is to test the getopts pattern

cat <<- msg
type -k input
type -l input
type -a no input
type -b no input
msg

while getopts k:l:ab option; do
		case $option in
				k|K) kilo=$OPTARG;;
				l|L) lingo=$OPTARG;;
				a) echo "got the a flag";;
				b) echo "got the b flag";;
		esac
done

echo "K: $kilo / L: $lingo"

