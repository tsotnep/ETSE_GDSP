import time
import os
os.system("octave -p ../matlab/range_matrix_mult.m")
time.sleep(1)
os.system("range_matrix_mult(2,9)")
