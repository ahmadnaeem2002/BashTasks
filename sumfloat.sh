#!/bin/bash
###Script to sum 2 float numbers
#exit error list:
##      exit:
##      0: Succes
##      1: check if para not 3
##      2: divided on 0
##      3: check operant
##      4: float or not
##      5: integer numbers
##      
## read the data from user

F1=${1}
F2=${3}
OP=${2}

## check if para not 3
[ ${#} -ne 3 ] && echo "Something bad " && exit 1

## check operator [+,*,/,-]
OPTEST=$(echo ${OP} | grep [+,-,/,*] | wc -l)
[ ${OPTEST} -ne 1 ] && echo "Bad Operator" && exit 3

## check if float or not
FTEST1=$(echo ${F1} | grep "^\-\{0,1\}[0-9]*\+[.][0-9]?*" | wc -l)
[ ${FTEST1} -eq 0 ] && echo "First number not float" && exit 4
FTEST2=$(echo ${F2} | grep "^\-\{0,1\}[0-9]*\+[.][0-9]?*" | wc -l)
[ ${FTEST2} -eq 0 ] && echo "Second number not float" && exit 4
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
case "${OP}" in
        "+")
                SUM=0
                SUM=$(echo ${F1}+${F2} | bc)
                echo "The Result of ${F1} + ${F2} is: ${SUM} "
                ;;
        "-")
                SUB=0
                SUB=$(echo ${F1} - ${F2} | bc)
                echo "The Result of ${F1} \- ${F2} is: ${SUB} "
                ;;
        "/")
                [ ${F2} -eq 0 ] && exit 2
                DIV=0
                DIV=$(echo ${F1} / ${F2} | bc)
                echo "The Result of ${F1} / ${F2} is: ${DIV} "
                ;;
        "*")
                MUL=0
                MUL=$(echo ${F1} \* ${F2} | bc)
                echo "The Result of ${F1} * ${F2} is: ${MUL} "
                ;;
        *)
                echo "Faild Operation"
                echo "Please try again.."
esac
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "### Thanks to use our script ###"
exit 0
