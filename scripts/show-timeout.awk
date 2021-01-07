{print $0}
NF==0 {print "TO"}
END {if (NR==0) print "TO"}
