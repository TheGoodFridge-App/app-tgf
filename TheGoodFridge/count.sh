#!/bin/bash

files=`find TheGoodFridge -name '*.swift'`

count=0
for file in $files
do
	temp=`cat $file | wc -l`
	count=$(($count+temp))
done

echo $count
