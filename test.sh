#!/bin/bash
## @file tests.sh
## @brief Bash functions to perform unit test
## @author Lydéric Debusschère


## @fn f_test__file_exist
## @author Lydéric Debusschère
## @brief  Test is a file exist
## @param  file 
## @return Return 0 if file exist; 1 if not
## @remark Example: f_test__file_exist  <file_path>/file
f_test__file_exist() {
        if [[ ! -e $1 ]]; then
                echo "File $1 does not exist !"
                return 1
        fi
        return 0
}

## @fn f_test__file_is_readable
## @author Lydéric Debusschère
## @brief  Test is a file is readable
## @param  file 
## @return Return 0 if file is readable; 1 if not
## @remark Example: f_test__file_is_readable  <file_path>/file
f_test__file_is_readable() {
        if [[ ! -r $1 ]]; then
                echo "File $1 is corrupted !"
                return 1
        fi
        return 0
}

## @fn f_test__file_is_x_tar
## @author Lydéric Debusschère
## @brief  Test is a file is an archive
## @param  file 
## @return Return 0 if file is an archive; 1 if not
## @remark Example: f_test__file_is_x_tar  <file_path>/file
f_test__file_is_x_tar(){
        if [[ $(file --mime-type $1 | awk '{print $(NF)}') != "application/x-tar" ]]; then
                echo "File $1 is not of type application/x-tar.
                type: $(file --mime-type $1 | awk '{print $(NF)}')
                "
                return 1
        fi
        return 0
}

