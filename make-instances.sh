#!/bin/bash

rm -f instance-lists/*-instances.txt
rm -f instances/*.gr

for n in $(seq 10 10 50); do
    python ../graph-generators/path_graph.py $n | python ../graph-generators/random_reorder.py > instances/path$n.gr
    python ../graph-generators/cycle_graph.py $n | python ../graph-generators/random_reorder.py > instances/cycle$n.gr
    python ../graph-generators/clique_graph.py $n | python ../graph-generators/random_reorder.py > instances/clique$n.gr
    python ../graph-generators/binary_tree.py $n | python ../graph-generators/random_reorder.py > instances/binarytree$n.gr
    python ../graph-generators/complete_bipartite.py $n | python ../graph-generators/random_reorder.py > instances/completebipartite$n.gr
    echo standard path$n >> instance-lists/standard-instances.txt
    echo standard cycle$n >> instance-lists/standard-instances.txt
    echo standard clique$n >> instance-lists/standard-instances.txt
    echo standard binarytree$n >> instance-lists/standard-instances.txt
    echo standard completebipartite$n >> instance-lists/standard-instances.txt
done

for k in $(seq 2 6); do
    python ../graph-generators/square_grid.py $k | python ../graph-generators/random_reorder.py > instances/squaregrid${k}x${k}.gr
    echo standard squaregrid${k}x${k} >> instance-lists/standard-instances.txt
done

for p in $(seq 1 9); do
    for n in $(seq 12 4 20); do
        for i in $(seq 1 10); do
            python ../graph-generators/random_graph.py $n 0.$p > instances/random$n-$p-$i.gr
            echo random random$n-$p-$i >> instance-lists/random-instances.txt
        done
    done
done

cp ../famous-graphs-shuffled/*.gr instances/
ls ../famous-graphs-shuffled/*.gr | xargs -n1 basename -s .gr | sed 's/^/famous /' > instance-lists/famous-instances.txt

cat instance-lists/standard-instances.txt instance-lists/random-instances.txt \
    instance-lists/famous-instances.txt instance-lists/pace-instances.txt > instance-lists/instances.txt

sed -i 's/p td /p tdp /' instances/*.gr
