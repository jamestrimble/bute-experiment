#!/bin/bash

TIMEOUT=$1

awk -f scripts/add_optima.awk optima.txt results/famous.tex \
    | sed 's/l r r r/l r r r r/' \
    | sed 's/n & m &/$n$ \& $m$ \& $\\mathit{td}$ \&/' \
    | sed 's/-LB & -Sym & -Dom/$-$LB \& $-$Sym \& $-$Dom/' \
    | grep -v '^tri' \
    | grep -v '^path4' \
    | grep -v '^3x3' \
    | grep -v '^4x4' \
    | sed 's/centering/footnotesize\n\\centering/' \
    | sed 's/\[tb\]/[htb]/' \
    | sed "s/for famous graphs/for famous graphs.  An asterisk indicates timeout at ${TIMEOUT} s./" \
    | sed "s/${TIMEOUT}.000/*/g" \
    | sed 's/Watsin/WatkinsSnark/g' \
    > results/famous-tidied.tex

awk -f scripts/add_optima.awk optima.txt results/pace.tex \
    | sed 's/l r r r/l r r r r/' \
    | sed 's/n & m &/$n$ \& $m$ \& $\\mathit{td}$ \&/' \
    | sed 's/-LB & -Sym & -Dom/$-$LB \& $-$Sym \& $-$Dom/' \
    | grep -v '^tri' \
    | grep -v '^path4' \
    | grep -v '^3x3' \
    | grep -v '^4x4' \
    | sed 's/centering/footnotesize\n\\centering/' \
    | sed 's/\[tb\]/[htb]/' \
    | sed "s/for famous graphs/for PACE Challenge graphs.  An asterisk indicates timeout at ${TIMEOUT} s./" \
    | sed "s/${TIMEOUT}.000/*/g" \
    | sed 's/exact_/exact\\_/g' \
    > results/pace-tidied.tex

awk -f scripts/add_optima.awk optima.txt results/standard.tex \
    | sed 's/l r r r/l r r r r/' \
    | sed 's/n & m &/$n$ \& $m$ \& $\\mathit{td}$ \&/' \
    | sed 's/-LB & -Sym & -Dom/$-$LB \& $-$Sym \& $-$Dom/' \
    | grep -v 'squaregrid1' \
    | sed '/binarytree50/a \\\addlinespace[0.5em]' \
    | sed '/clique50/a \\\addlinespace[0.5em]' \
    | sed '/completebipartite50/a \\\addlinespace[0.5em]' \
    | sed '/cycle50/a \\\addlinespace[0.5em]' \
    | sed '/path50/a \\\addlinespace[0.5em]' \
    | sed 's/binarytree/Binary tree /g' \
    | sed 's/clique/Clique/g' \
    | sed 's/completebipartite/Complete bipartite /g' \
    | sed 's/cycle/Cycle /g' \
    | sed 's/path/Path /g' \
    | sed 's/squaregrid/Square grid /g' \
    | sed 's/2x2/$2\\times2$/g' \
    | sed 's/3x3/$3\\times3$/g' \
    | sed 's/4x4/$4\\times4$/g' \
    | sed 's/5x5/$5\\times5$/g' \
    | sed 's/6x6/$6\\times6$/g' \
    | sed 's/centering/footnotesize\n\\centering/' \
    | sed 's/\[tb\]/[htb]/' \
    | sed "s/for standard graphs/for standard graphs.  An asterisk indicates timeout at ${TIMEOUT} s./" \
    | sed "s/${TIMEOUT}.000/*/g" \
    > results/standard-tidied.tex


