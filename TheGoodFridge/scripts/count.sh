#!/bin/bash

files=`find TheGoodFridge -name '*.swift' | xargs wc -l`
echo $files
