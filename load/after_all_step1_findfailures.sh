#!/bin/bash
rm failures
for i in *.csv; do cat $i  | awk 'NR==3' | awk -F "," '{print $2}' >> failures; done
awk '{ sum += $1 } END { print "failures: " sum }' failures

