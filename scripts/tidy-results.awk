NR == 1 {
    print
}
NR > 1 {
    for (i=5;i<=NF;i++) {
        if ($i == "TO" || $i > timelimit) {
            $i = timelimit;
        }
        $i = sprintf("%.3f", $i);
    }
    print
}
