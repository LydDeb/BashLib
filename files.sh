#!/bin/bash
## @file files.sh
## @brief Bash functions on files
## @author Lydéric Debusschère

## @fn f_file__select_block
## @author Lydéric Debusschère
## @brief  Print a block of lines defined by the begin and the end number of line of a file
## @param  -s start line number 
## @param  -e end line number 
## @param  -f file 
## @return Print lines from *start* line to *end* line
## @remark Example: f_file__select_block -f <file_path>/file -s 5 -e 10
f_file__select_block() {
        unset OPTIND
        while getopts s:e:f: arg; do
                case $arg in
                        s)
                                local start=${OPTARG}
                                ;;
                        e)
                                local end=${OPTARG}
                                ;;
                        f)
                                local file=${OPTARG}
                                ;;
                esac
        done
        # sed -n "${start},${end}p" $file
        # Equivalent à :
        head -n $end $file | tail -n $(( end - start + 1 ))
}

