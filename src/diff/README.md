readme for dir: ETSE_GDSP/src/diff_of_results

## To run the python code to compare results from Matlab and from VHDL simulation, type:

    python compare_matlab_vhdl_results.py

If you want to change the files, that you want to be compared, then change the values of 'm' and 'M' in the beginning of the compare_matlab_vhdl_results.py script. if m=3 and M=5, files 3.txt, 4.txt and 5.txt will be compared - the difference between respective numbers will be written in file ./r/*.txt. currenly m=3, M=50