from collections import Counter
import sys

timelimit = float(sys.argv[1])

lines = [line.strip().split() for line in sys.stdin.readlines()]

line0 = lines[0]

lines = [line for line in lines[1:] if line[0]=="random"]

programs = line0[4:]

print programs

n_values = sorted(set(int(line[2]) for line in lines))
print n_values

p_values = sorted(set(int(line[1].split("-")[1]) for line in lines))
print p_values

c = Counter((int(line[2]), int(line[1].split("-")[1]), program) for line in lines for i, program in enumerate(programs) if float(line[i+4]) < timelimit)

for n in n_values:
    with open("results/random{}.tex".format(n), "w") as f:
	f.write("\\begin{table}[tb]\n")
#	f.write("\\scriptsize\n")
	f.write("\\centering\n")
	f.write(" \\begin{{tabular}}{{l{}}} \n".format(" r" * len(p_values)))
	f.write(" \\toprule\n")
	f.write(" Program & {} \\\\ [0.5ex] \n".format(" & ".join("0.{}".format(p) for p in p_values)))
	f.write(" \\midrule\n")
	for program in programs:
	    row = [c[(n, p, program)] for p in p_values]
	    print n, program, row
	    f.write("{} & {} \\\\ \n".format(program, " & ".join(str(c[(n, p, program)]) for p in p_values)))
	f.write(" \\bottomrule\n")
	f.write(" \\end{tabular}\n")
	f.write(" \\caption{{Results for random graphs with {} vertices TODO: make caption better}}\n".format(n))
	f.write(" \\label{{table:random{}}}\n".format(n))
	f.write("\\end{table}\n")

