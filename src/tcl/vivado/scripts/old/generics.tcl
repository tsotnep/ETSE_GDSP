#this script is used for setting generic values for the project creation and simulation


############################## Variables that needs to be changed:
#Directory of the project top folder
    set ORIGIN /home/tsotne/git/ETSE_GDSP

#Name of the Project, MUST be one of those: {S_INT S_REAL S_INT_G CV_INT CV_REAL} CURRENTLY only S_INT, S_INT_G
    set PROJECTNAME S_INT_G

#starting size of the column of the matrix, for simulation
    set m 2 

#ending size of the column of the matrix, for simulation
    set M 2 



############################## syntax:
# "set VariableName VariableValue"
# creates variable called  VariableName and assignes value VariableValue
# later, variable's value can be used as:
#   $VariableName
# or
#   ${VariableName}
# there the second one can be used as string, for string concatenation





############################## Don't Change Anything Below this line:
set PROJECTLOCATION $ORIGIN/project/vivado/$PROJECTNAME
set TCLDIR $ORIGIN/src/tcl/vivado
