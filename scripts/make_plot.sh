#!/bin/bash

set -e

cat results/results-formatted.txt | awk 'NR==1 {print "#" $0}
/famous/ {$1=1; print}
/standard/ {$1=2; print}
/random/ {$1=3; print}
/pace/ {$1=4; print}
' > results/results-for-plot.txt

gnuplot scripts/scatter.gnuplot
(cd plots
sed -i -e '5,20s/^\(\\path.*\)/\% \1/' scatter.tex
latexmk -pdf scatter.tex)
(cd plots
sed -i -e '5,20s/^\(\\path.*\)/\% \1/' scatter2.tex
latexmk -pdf scatter2.tex)
(cd plots
sed -i -e '5,20s/^\(\\path.*\)/\% \1/' scatter3.tex
latexmk -pdf scatter3.tex)
