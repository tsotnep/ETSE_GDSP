from __future__ import print_function
import re
import sys
import numpy
import os

m=3
M=50
testbenchName='tb_matrix_mul_ip_core_s_int'

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

    #matlab results
    F_matlab = open('../matlab/r/' + str(SZ) + '.txt', 'r')
    R_matlab = map(int,re.findall(r"-*\d+\.*\d*", F_matlab.read()))

    #simulation results
    F_vhdl = open('../results/r/tb_matrix_mul_ip_core_s_int/' + str(SZ) + '.txt', 'r')
    R_vhdl = map(int,re.findall(r"-*\d+\.*\d*", F_vhdl.read()))

    #calculate absolute values, mb not necesary
    numpy.absolute(R_matlab)
    numpy.absolute(R_vhdl)

    #subtract arrays
    R_sub = list(numpy.array(R_matlab) - numpy.array(R_vhdl))

    #open/create file for storing results
    directory='../diff/r/'+testbenchName+'/'
    if not os.path.exists(directory):
        os.makedirs(directory)
    F_diff = open(directory + str(SZ) + '.txt', 'w+')

    for ind, val in enumerate(R_sub):
        #print single value and space
        print (str(val) + " ", end='', file = F_diff)

        #if the whole matrix is finished print message
        if ((1+ind)%(SZ*SZ)==0):
            print ("\n%s of Matrix with size %d X %d\n" % (comment[(1+ind)/(SZ*SZ)-1],SZ,SZ), file = F_diff)

        #if one line is finished, print new line
        if (1+ind)%SZ == 0:
            print ("", file = F_diff)
