readme for dir: ETSE_GDSP/src/


## List of Content

* diff/   -difference between results from Matlab, and results from VHDL simulation, and script that generates it.
* hdl/    -folder for source VHDL files used for synthesis
* ip/     -DSP and BRAM ip cores that are used in ISE and Vivado. used in tcl scripts and projects
* lib/    -libraries used for synthesis or simulation,
* matlab/ -matlab scripts and it's generated Input, Output and Result files
* tb/     -files for simulations, *.vhd and *.wcfg files
* tcl/    -tcl scripts



## More Details:

## diff/:

* ./r/  -in this folder, differences of calculations are stored.
* compare_matlab_vhdl_results.py -script that compares results from matlab (./matlab/r/*.txt) with results from vhdl simulation ()./results/r/*.txt), like that:
    * abs(matlab[i]) - abs(vhdl[i]) - and then writes in files ./diff/r/*.txt

## hdl/:

* MATRIX_MUL_IP_CORE_CV_INT   -- This is a Matrix Multiplier IP core for multiplying an integer square matrix P, by an integer column vector G.
* MATRIX_MUL_IP_CORE_CV_REAL  -- This is a Matrix Multiplier IP core for multiplying a real square matrix P, by a real column vector G.
* MATRIX_MUL_IP_CORE_S_INT    -- This is a Matrix Multiplier IP core for multiplying an integer square matrix P, by an integer square matrix G.
* MATRIX_MUL_IP_CORE_S_INT_G  -- Same as MATRIX_MUL_IP_CORE_S_INT but GRAM is included in the top module entity: MATRIX_MUL_IP_CORE_S_INT_G
* MATRIX_MUL_IP_CORE_S_REAL   -- This is a Matrix Multiplier IP core for multiplying a real square matrix P, by a real square matrix G..

The naming convention adopted is similar in part for all IP cores but the difference is some IP cores have CV, S, INT, and REAL appended.

* CV  -> Column Vector (1 Square matrix, 1 Column vector)
* S   -> Square Matrix (2 square matrices)
* INT -> Integer number Matrices
* REAL-> Real number Matrices


## ip/



## lib/



## /matlab/

* range_matrix_multiplier.m        --This is a matlab function that accepts two integers which represents the ranges of the size of column of a square matrix with integer numbers. When this function is run from matalab, it will create 3 files: ($i - represents the size of matrix column)
    * ./p/$i.txt,        --This file holds the test value for P matrix.
    * ./g/$i.txt,        --This file holds the test value for G matrix.
    * ./r/$i.txt    -results of ./p/$i.txt & ./g/$i.txt matrix multiplications

## tb/



## tcl/

scripts for creating a new project and simulating that project with varying size of matrix column. results are stored in ../results/r and ../results/rCSV
