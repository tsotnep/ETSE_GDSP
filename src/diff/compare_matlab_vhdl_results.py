from __future__ import print_function
import re
import sys
import numpy

m=3
M=50

comment = [
"INITIAL DATA",
"RESULT of P * G",
"RESULT of P G * G",
"RESULT of P * Gt",
"RESULT of PG * Gt",
"RESULT of Pt * G",
"RESULT of [PG]t * G",
"RESULT of Pt * Gt",
"RESULT of [PG]t * Gt"
]
for SZ in range(m,M+1):
    #F_* file
    #R_* result

    F_matlab = open('../matlab/r/' + str(SZ) + '.txt', 'r')
    R_matlab = map(int,re.findall(r"-*\d+\.*\d*", F_matlab.read()))

    F_vhdl = open('../results/r/' + str(SZ) + '.txt', 'r')
    R_vhdl = map(int,re.findall(r"-*\d+\.*\d*", F_vhdl.read()))

    numpy.absolute(R_matlab)
    numpy.absolute(R_vhdl)
    R_sub = list(numpy.array(R_matlab) - numpy.array(R_vhdl))

    F_diff = open('../diff_of_results/r/' + str(SZ) + '.txt', 'w+')

    for ind, val in enumerate(R_sub):
        print (str(val) + " ", end='', file = F_diff)
        if ((1+ind)%(SZ*SZ)==0):
            print ("\n%s of Matrix with size %d X %d\n" % (comment[(1+ind)/(SZ*SZ)-1],SZ,SZ), file = F_diff)
        if (1+ind)%SZ == 0:
            print ("", file = F_diff)
