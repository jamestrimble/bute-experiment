#!/bin/bash

cat instance-lists/instances.txt | while read family i; do
	cat program-output/$i-* | grep -E 'Depth|final treedepth' \
		| awk '/Depth/ {print $2} /final treedepth/ {print $4}' \
		| sed 's/.*-//' \
		| tr -d ']' \
		| sort | uniq -c | wc -l
done | sort | uniq -c
