#!/bin/bash

set -euf -o pipefail

MEMLIMIT=$(awk '/memory-limit-kb/ {print $2}' < options.txt)
JAVAMEMSTART=$(awk '/java-start-memory/ {print $2}' < options.txt)
JAVAMEMMAX=$(awk '/java-max-memory/ {print $2}' < options.txt)
TIMELIMIT=$(awk '/time-limit-seconds/ {print $2}' < options.txt)

if [ $1 = "make-commands" ]; then
    mkdir -p intermediate
    rm -rf intermediate/commands.txt
    cat instance-lists/instances.txt | while read family f; do
        echo $f
        cat program-commands.txt | while read program_name program_command; do
            OUTFILE=program-output/$f-${program_name}.out
            PROGRAM_COMMAND=$(echo ${program_command} | sed -e "s/JAVAMEMSTART/${JAVAMEMSTART}/" -e "s/JAVAMEMMAX/${JAVAMEMMAX}/")
            echo "time (ulimit -v ${MEMLIMIT}; timeout --preserve-status $((TIMELIMIT+1)) ${PROGRAM_COMMAND} < instances/$f.gr > ${OUTFILE} 2>/dev/null || echo FAIL \$? > ${OUTFILE}) 2>program-output/$f-${program_name}.time" >> intermediate/commands.txt
        done
    done
fi

if [ $1 = "run" ]; then
    MOD=$2
    RES=$3
    rm -rf program-output
    mkdir -p program-output
    echo $(cat intermediate/commands.txt | awk "NR % ${MOD} == ${RES}" | wc -l) "jobs to run."
    cat intermediate/commands.txt | awk "NR % ${MOD} == ${RES}" | parallel --progress
fi

if [ $1 = "summarise" ]; then
    rm -rf results
    mkdir -p results
    rm -rf plots
    mkdir -p plots

    PROGRAMS=$(cut -d' ' -f1 program-commands.txt)
    echo family instance n m ${PROGRAMS} | tr ' ' '\t' > results/results.txt

    cat instance-lists/instances.txt | while read family f; do
        cat program-commands.txt | while read program_name program_command; do
            cat program-output/$f-${program_name}.{out,time} | \
                awk '$1=="FAIL" {print '$((TIMELIMIT+5))';exit} $1=="real" {print $2;exit}' | scripts/time-to-seconds.sh
        done | \
            awk -v family=${family} -v f=$f \
                    -v n=$(cat instances/$f.gr | grep -v '^c' | head -n1 | cut -d' ' -f3) \
                    -v m=$(cat instances/$f.gr | grep -v '^c' | head -n1 | cut -d' ' -f4) \
             '{x[i++] = $1} END {printf "%s %s %s %s", family, f, n, m; for (j=0;j<i; j++) printf " %s", x[j]; print}'
    done | tee -a results/results.txt

    cat results/results.txt | awk -f scripts/tidy-results.awk -v timelimit=${TIMELIMIT} -v OFS="\t" | sort -g -k3,4 | sort -s -k1,1 > results/results-formatted.txt

    python scripts/summarise-random.py ${TIMELIMIT} < results/results-formatted.txt
    python scripts/summarise-famous.py ${TIMELIMIT} < results/results-formatted.txt
    python scripts/summarise-pace.py ${TIMELIMIT} < results/results-formatted.txt
    python scripts/summarise-standard.py ${TIMELIMIT} < results/results-formatted.txt

    ./scripts/make_plot.sh

    ./scripts/tidy-up-tables.sh ${TIMELIMIT}
fi
