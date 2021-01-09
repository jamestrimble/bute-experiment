#!/bin/bash

set -euf -o pipefail

cat instance-lists/instances.txt | cut -d' ' -f2 | while read i; do
  find program-output -name "$i-*.out" | while read f; do
    (grep '^[0-9]' $f || true) | head -n1
  done > tmp.txt
  if [[ $(cat tmp.txt | sort | uniq | wc -l) -gt 1 ]]; then
    echo "Results disagree for instance" $i 1>&2
    false
  fi
  if [[ $(cat tmp.txt | sort | uniq | wc -l) -eq 1 ]]; then
    echo $i $(head -n1 tmp.txt)
  fi
done | tee optima.txt

rm -f tmp.txt
