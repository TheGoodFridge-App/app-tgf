#!/bin/bash

for NUM in 2 3 4 5 6 7 8 9 10
do
	find .. -name "* $NUM*" -delete
done
