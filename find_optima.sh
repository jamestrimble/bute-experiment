#!/bin/bash

cat instance-lists/instances.txt | grep -E 'standard|famous' | cut -d' ' -f2 | while read i; do
  echo $i $(timeout 30 ../competition-divide-and-conquer-version/solve < instances/$i.gr | tail -n1 | cut -d' ' -f2)
done | tee optima.txt
