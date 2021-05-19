#!/bin/bash

DOUBLE_PROGRAM="./build/double.out"
FLOAT_PROGRAM="./build/float.out"

FLOAT_FILE=test\/float.txt
FLOAT_SEQ=test\/float_seq.txt
DOUBLE_FILE=test\/double.txt
DOUBLE_SEQ=test\/double_seq.txt
TEMP_FILE=test\/temp.txt

N=(1024 2048 4096 8192) # Add more if we use Pekin
EVENTS_FLAGS="warps_launched,local_store,global_store,local_load,global_load,shared_load,shared_store"

METRICS_FLAGS="system_utilization,shared_load_transactions_per_request,shared_store_transactions_per_request,\
local_load_transactions_per_request,local_store_transactions_per_request,\
shared_store_transactions,shared_load_transactions,local_load_transactions,\
local_store_transactions,gld_transactions,gst_transactions"

NVPROF=$(echo "sudo nvprof --log-file " $TEMP_FILE  "-m " \
$METRICS_FLAGS "-e " $EVENTS_FLAGS)


# Check if we are sudoers
if [[ "sudo" -eq  0 ]]
then
	read -p "Delete the previous results?" answer
	if [[ $answer -eq "yes" ]]
	then
		rm -rf test/*
		echo "hola"
	fi
	# Iterate for every matrix size
	for i in ${N[@]}
	do
		# For every program
		for j in {0..4}
		do
			# Ten times every program
			for k in {1..10}
			do
				echo "It:" $k "Option:" $j "N:" $i >> $FLOAT_FILE
				$NVPROF $FLOAT_PROGRAM $j $i $i 0  >> $FLOAT_FILE
				#echo $NVPROF $FLOAT_PROGRAM $j $i $i 0
				sed -n 9,15p $TEMP_FILE | sed 's/  */ /g' >> $FLOAT_FILE
				sed -n 21,30p $TEMP_FILE | sed 's/  */ /g' >> $FLOAT_FILE
				echo "" >> $FLOAT_FILE

				echo "It:" $k "Option:" $j "N:" $i >> $DOUBLE_FILE
				$NVPROF $DOUBLE_PROGRAM $j $i $i 0 >> $DOUBLE_FILE
				sed -n 9,15p $TEMP_FILE | sed 's/  */ /g' >> $DOUBLE_FILE
				sed -n 21,30p $TEMP_FILE | sed 's/  */ /g' >> $DOUBLE_FILE
				echo "" >> $DOUBLE_FILE
			done
		done
			#Seq code doesnt generate NVPROF data so it's separate
			for k in {1..10}
			do
				echo "It:" $k "Option: 5 N:" $i >> $FLOAT_SEQ
				$FLOAT_PROGRAM 5  $i $i 0  >> $FLOAT_SEQ
				echo "" >> $FLOAT_SEQ

				echo "It:" $k "Option: 5 N:" $i >> $DOUBLE_SEQ
				$DOUBLE_PROGRAM 5  $i $i 0  >> $DOUBLE_SEQ
				echo "" >> $DOUBLE_SEQ
			done
	done
else
	echo "exec with root privilegies"
fi

exit 0
