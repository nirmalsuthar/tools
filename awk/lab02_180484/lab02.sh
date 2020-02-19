#!/bin/bash

function file_not_exists() {
	exit
}

function help() {
	echo "Usage: $0 input_file output_file"
	exit
}

if [ $# != 2 ]
then	
	help
fi

if [ ! -f $1 ]
then
	echo "Error: $1 does not exists"
	file_not_exists
fi

sed -r 's/;/@/g' $1

grep 'Japan' $1 | awk -F ";" '{print $1}' > $2

awk -F ";" '{ if ($6 > 4000 && $6 != "Weight") { print $1 ":" $6} }' $1 >> $2

awk -F ";" '{

if ($2 !="MPG") {
	origin=$9;
	count[origin]++;
	total[origin]+=$2
 	}
}
END {
	for (key in count) {
		print key;
		print total[key]/count[key];
	}
}' $1 >> $2



 
