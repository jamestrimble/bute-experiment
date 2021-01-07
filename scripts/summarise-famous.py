import sys

timelimit = float(sys.argv[1])

lines = [line.strip().split() for line in sys.stdin.readlines()]

line0 = lines[0]

lines = [line for line in lines[1:] if line[0]=="famous"]

program_map = {
    "c": "All",
    "LB": "-LB",
    "Sym": "-Sym",
    "Dom": "-Dom",
    "g": "SAT"
}

programs = [program_map[token] if token in program_map else token for token in line0[4:]]

print programs

with open("results/famous.tex", "w") as f:
    f.write("\\begin{table}[tb]\n")
#    f.write("\\scriptsize\n")
    f.write("\\centering\n")
    f.write(" \\begin{{tabular}}{{l{}}} \n".format(" r" * (len(programs) + 2)))
    f.write(" \\toprule\n")
    f.write(" Instance & n & m & {} \\\\ [0.5ex] \n".format(" & ".join(programs)))
    f.write(" \\midrule\n")
    for line in lines:
        row = line[1:]
        f.write("{} \\\\ \n".format(" & ".join(row)))
    f.write(" \\bottomrule\n")
    f.write(" \\end{tabular}\n")
    f.write(" \\caption{{Solving times in seconds for famous graphs}}\n")
    f.write(" \\label{table:famous}\n")
    f.write("\\end{table}\n")



