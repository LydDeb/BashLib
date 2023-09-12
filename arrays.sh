#!/bin/bash
## @file arrays.sh
## @brief Bash functions on arrays
## @author Lydéric Debusschère

## @fn f_array__append
## @author Lydéric Debusschère
## @brief Append a string to an array 
## @param  array_name (1) The name of the variable which contains the array 
## @param item (2 ...) One or more items to add
## @return No return, the array is modified in place
## @remark Example: my_array=( a b c ); f_array__append my_array d e f
f_array__append() {
        # Append elements to array_name in place
        # usage: array__append <array_name> <element_1> ... <element_n>
        # example:
        # $ my_array=( a b c )
        # $ f_array__append my_array d
        # $ echo ${my_array[@]}
        #   a b c d
        local array_name=$1
        shift
        # Contenu du tableau dont le nom est stocké dans la variable 'array'
        # eval echo \${$array[@]}
        # Reaffectation des valeurs du tableau dont le nom est stocké dans la variable 'array'
        # eval $(eval echo "$array_name=\( 1 2 3 \)")
        eval $(eval echo "$array_name=\( \${$array_name[@]} $@ \)")
}

## @fn f_array__remove
## @author Lydéric Debusschère
## @brief Remove an item in an array 
## @param  array_name (1) The name of the variable which contains the array 
## @param item (2 ...) One or more items to remove
## @return No return, the array is modified in place
## @remark Example: my_array=( a b c d e f ); f_array__remove my_array d e f
f_array__remove() {
        # Remove elements to array_name in place
        # usage: array__remove <array_name> <element_1> ... <element_n>
        # example:
        # $ my_array=( a b c )
        # $ f_array__remove my_array b
        # $ echo ${my_array[@]}
        #   a c
        local array_name=$1
        shift
        array_to_remove=($@)
        for item_to_remove in ${array_to_remove[@]}; do
                for idx in $(eval echo \${!$array_name[@]}); do
                        item=$(eval echo \${$array_name[$idx]})
                        if [[ $item == $item_to_remove ]]; then
                                unset $array_name[$idx]
                        fi
                done
        done
}

## @fn f_array__remove
## @author Lydéric Debusschère
## @brief Print the length of an array 
## @param  array_name (1) The name of the variable which contains the array 
## @return The length is print in stdout
## @remark Example: my_array=( a b c d e f ); f_array__length my_array
f_array__length() {
        local array=$1
        local length=$(eval echo \${#$array[@]})
        echo $length
}

## @fn f_array__is_include
## @author Lydéric Debusschère
## @brief Check is an array is include in an other
## @param  array_name (1) The name of the variable which contains the array 
## @param  sub_array_name (2) The name of the variable which contains the array 
## @return Return 0 if sub_array is in array; return 1 if not
## @remark Example: my_array=( a b c d e f ); my_sub_array=( b c); f_array__is_include my_array my_sub_array
f_array__is_include() {
        local array_name=$1
        local sub_array_name=$2
        local counter=0
        local _test
        for _item in $(eval echo \${$array_name[@]}); do
                for _item_test in $(eval echo \${$sub_array_name[@]}); do
                        if [[ $_item == $_item_test ]]; then
                                counter=$(( counter + 1 ))
                        fi
                done
        done
        if [[ $counter == $(f_array__length $sub_array_name) ]]; then
                return 0
        else
                return 1
        fi
}

## @fn f_array__intersection
## @author Lydéric Debusschère
## @brief  Print the intersection of two array
## @param  array_1_name (1) The name of the variable which contains the array 
## @param  array_2_name (2) The name of the variable which contains the array 
## @return Print the list of strings of the intersection
## @remark Example: array_1=( a b c ); array_2=( b c d ); f_array__intersection array_1 array_2
f_array__intersection() {
        local array_name_1=$1
        local array_name_2=$2
        local _inter=""
        local counter=0
        for _item in $(eval echo \${$array_name_1[@]}); do
                for _item_test in $(eval echo \${$array_name_2[@]}); do
                        if [[ $_item == $_item_test ]]; then
                                _inter+=" $_item"
                        fi
                done
        done
        echo $_inter
}

## @fn f_array__item_is_in_array
## @author Lydéric Debusschère
## @brief  Check if an item is in an array
## @param  array_name (1) The name of the variable which contains the array 
## @param  item (2) The string to check 
## @return Return 0 if yes, 1 if is not
## @remark Example: my_array=( a b c ); f_array__is_include my_array b
f_array__item_is_in_array(){
        local array_name=$1
        local item=$2
        local _test=1
        for _item in $(eval echo \${$array_name[@]}); do
                if [[ $_item == $item ]]; then
                        _test=0
                fi
        done
        return $_test
}

## @fn f_array__item_position
## @author Lydéric Debusschère
## @brief  Print the position of the last occurence of an item in array
## @param  array_name (1) The name of the variable which contains the array 
## @param  item (2) The string to check 
## @return Print the position; if the item is not in the array print nothing
## @remark Example: my_array=( a b c ); f_array__item_position my_array b
f_array__item_position() {
        local array_name=$1
        local item=$2
        local _pos=
        local idx=0
        for _item in $(eval echo \${$array_name[@]}); do
                if [[ $_item == $item ]]; then
                        _pos=$idx
                fi
                idx=$(( idx + 1 ))
        done
        echo $_pos

