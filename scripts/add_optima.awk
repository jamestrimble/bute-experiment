NR == FNR {
    # Read in optima
    if (NF == 2) {
        optima[$1] = $2;
    } else {
        optima[$1] = -1; 
    }
}

NR != FNR {
    # Add optima to table
    if (optima[$1] > 0) {
        $6 = "& " optima[$1] " &";
    } else if (optima[$1] == -1) {
        $6 = "& &";
    }
    print;
}
