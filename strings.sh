#!/bin/bash
## @file strings.sh
## @brief Bash functions on strings
## @author Lydéric Debusschère


## @def SGR_BOLD SGR_ITALIC SGR_UNDERLINE SGR_RESET SGR_BLACK SGR_RED SGR_GREEN SGR_ORANGE SGR_BLUE SGR_PURPLE SGR_CYAN SGR_WHITE
## @brief Define ANSI Select Graphic Rendition (SGR)
## @remark All these variables are prefixed by SGR_
SGR_BOLD="\033[1m"
SGR_ITALIC="\033[3m"
SGR_UNDERLINE="\033[4m"
SGR_RESET="\033[0m"
SGR_BLACK="\033[30m"
SGR_RED="\033[31m"
SGR_GREEN="\033[32m"
SGR_ORANGE="\033[33m"
SGR_BLUE="\033[34m"
SGR_PURPLE="\033[35m"
SGR_CYAN="\033[36m"
SGR_WHITE="\033[37m"

## @fn is_alphanum()
## @author Lydéric Debusschère
## @brief check if each caracter is alphanumeric 
## @param _hash a string
## @return return 1 if `_hash` is not alphanumeric
is_alphanum() {
        _hash=$1
        _hash_length=${#_hash}
        if [[ ! "$_hash" =~ ^[0-9a-zA-Z]{$_hash_length}$ ]]; then
                echo "$_hash: hash is not alphanumeric !"
                return 1
        fi
}

## @fn assert_len()
## @author Lydéric Debusschère
## @brief check if the length of a string is equal to an assert value
## @param _hash a string
## @param _assert_len an integer, the length
## @return return 1 if `_hash` length is not `_assert_length`
assert_len() {
        _hash=$1
        _assert_len=$2
        _hash_length=${#_hash}
        if [[ "$_hash_length" != "$_assert_len" ]]; then
                echo "$_hash: hash length is not $_assert_len !"
                return 1
        fi
}

## @fn is_hash_32()
## @author Lydéric Debusschère
## @brief check if a string could be a hash of length 32
## @param _hash a string
## @return return 1 if `_hash` is not alphanumeric of length 32
is_hash_32() {
        _hash=$1
        is_alphanum $_hash
        assert_len $_hash 32
}

## @fn f_string__passed()
## @author Lydéric Debusschère
## @brief Print PASSED in bold green
f_string__passed() {
        echo -e "${SGR_BOLD}${SGR_GREEN}PASSED$SGR_RESET"
}
## @fn f_string__failed()
## @author Lydéric Debusschère
## @brief Print FAILED in bold red
f_string__failed() {
        echo -e "${SGR_BOLD}${SGR_RED}FAILED$SGR_RESET"
}
## @fn f_string__missed()
## @author Lydéric Debusschère
## @brief Print MISSED in bold ORANGE
f_string__missed() {
        echo -e "${SGR_BOLD}${SGR_ORANGE}MISSED$SGR_RESET"
}

## @fn f_info__selected_case()
## @author Lydéric Debusschère
## @brief Print *selected_case* in bold cyan and *info* in cyan
## @param selected_case (1) string
## @param info (2) string
f_info__selected_case() {
        local selected_case=$1
        local info=$2
        >&2 echo -e "${SGR_CYAN}${SGR_BOLD}$selected_case${SGR_RESET}${SGR_CYAN} $info${SGR_RESET}"
}

## @fn f_info__step()
## @author Lydéric Debusschère
## @brief Print a space which depends on *level* then print *message*
## @param message (1) string
## @param level (2) number
## @remark Example: f_info__step "Checking links" 5
f_info__step() {
        local message=$1
        local level=$2
        local horizontal_space=""
        for i in $(seq 0 $level); do horizontal_space+=" "; done
        >&2 echo -e "$horizontal_space$message"
}


