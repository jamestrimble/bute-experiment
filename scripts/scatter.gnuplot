# vim: set et ft=gnuplot sw=4 :

set terminal tikz standalone color size 9cm,8cm font '\scriptsize' preamble '\usepackage{times,microtype,algorithm2e,algpseudocode,amssymb}'

set key off
set border 3
set grid x y front lc rgb "#999999" lw 1 lt 0
set xtics nomirror
set ytics nomirror
set tics front
set size square
set xrange [1:1e6]
set yrange [1:1e6]
#set x2range [-0.5:50.5]
#set y2range [-0.5:50.5]
set logscale x
set logscale y
set format x '$10^{%T}$'
set format y '$10^{%T}$'

set label 1 "Famous" at 20000,32 point pt 5 ps 1.2 lc 1 offset 0,-0.175 left
set label 2 "Standard" at 20000,16 point pt 7 ps 1.2 lc 2 offset 0,-0.175 left
set label 3 "Random" at 20000,8 point pt 9 ps 1.2 lc 3 offset 0,-0.175 left
set label 4 "PACE" at 20000,4 point pt 11 ps 1.2 lc 4 offset 0,-0.175 left

set output "plots/scatter.tex"
set xlabel 'Bute'
set ylabel 'SMS'
plot \
  x w l lc rgb '#999999' lw 1 lt 0, \
  "< awk 'NR==1 || $1 == 1' results/results-for-plot.txt" u ($5*1000):($6*1000):1 w points notitle pt 5 ps .8 lc var, \
  "< awk 'NR==1 || $1 == 2' results/results-for-plot.txt" u ($5*1000):($6*1000):1 w points notitle pt 7 ps .8 lc var, \
  "< awk 'NR==1 || $1 == 3' results/results-for-plot.txt" u ($5*1000):($6*1000):1 w points notitle pt 9 ps .8 lc var, \
  "< awk 'NR==1 || $1 == 4' results/results-for-plot.txt" u ($5*1000):($6*1000):1 w points notitle pt 11 ps .8 lc var

set output "plots/scatter2.tex"
set xlabel 'Bute'
set ylabel 'SMS-mini'
plot \
  x w l lc rgb '#999999' lw 1 lt 0, \
  "< awk 'NR==1 || $1 == 1' results/results-for-plot.txt" u ($5*1000):($7*1000):1 w points notitle pt 5 ps .8 lc var, \
  "< awk 'NR==1 || $1 == 2' results/results-for-plot.txt" u ($5*1000):($7*1000):1 w points notitle pt 7 ps .8 lc var, \
  "< awk 'NR==1 || $1 == 3' results/results-for-plot.txt" u ($5*1000):($7*1000):1 w points notitle pt 9 ps .8 lc var, \
  "< awk 'NR==1 || $1 == 4' results/results-for-plot.txt" u ($5*1000):($7*1000):1 w points notitle pt 11 ps .8 lc var

set output "plots/scatter3.tex"
set xlabel 'SMS'
set ylabel 'SMS-mini'
plot \
  x w l lc rgb '#999999' lw 1 lt 0, \
  "< awk 'NR==1 || $1 == 1' results/results-for-plot.txt" u ($6*1000):($7*1000):1 w points notitle pt 5 ps .8 lc var, \
  "< awk 'NR==1 || $1 == 2' results/results-for-plot.txt" u ($6*1000):($7*1000):1 w points notitle pt 7 ps .8 lc var, \
  "< awk 'NR==1 || $1 == 3' results/results-for-plot.txt" u ($6*1000):($7*1000):1 w points notitle pt 9 ps .8 lc var, \
  "< awk 'NR==1 || $1 == 4' results/results-for-plot.txt" u ($6*1000):($7*1000):1 w points notitle pt 11 ps .8 lc var
