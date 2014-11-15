#!/bin/bash
tail -n +2 "$FILE"
rm failures
for i in *.csv; do tail -n +2  $i; done

