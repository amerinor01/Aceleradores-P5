#!/bin/bash

DOUBLE_PROGRAM="./double.out"
FLOAT_PROGRAM="./float.out"

N=(1024 2048) # Add more if we use Pekin

for i in ${N[@]}
do
	for j in {0..5}
	do
		for k in {1..10}
		do
			echo "It:" $k "Option:" $j "N:" $i >> test\/float.txt
			$FLOAT_PROGRAM $j $i $i 0  >> test\/float.txt
			echo "" >> test\/float.txt

			echo "It:" $k "Option:" $j "N:" $i >> test\/double.txt
			$DOUBLE_PROGRAM $j $i $i 0 >> test\/double.txt
			echo "" >> test\/double.txt
		done
	done
done
