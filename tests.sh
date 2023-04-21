#!/bin/bash

PROGRAM="./cyber_breaches"
FILE="./Cyber_Security_Breaches.tsv"

# Determining color codes
red=$(tput setaf 1)
green=$(tput setaf 2)
normal=$(tput sgr0)

# Statistics of Test Cases
num_testcases=0
num_passed=0
num_failed=0
declare -a failed_cases

test_valid_inputs() {
    # Valid Inputs: cyber_breaches <FILENAME> <COMMAND>
    # <COMMAND> can be either one of the follows:
    # 1. maxstate
    # 2. maxyear
    # 3. <A two letter state code>   eg. CA or NY
    # 4. <A four digit year>         eg. 2010 or 2012
    VALID_COMMANDS=("maxstate" "maxyear" "2010" "2013" "2011" "2009" "9999" "TX" "CA")
    for command in "${VALID_COMMANDS[@]}"; do
        "$PROGRAM" "$FILE" "$command" | diff - "./tests/out/valid_commands/$command.out" >/dev/null
        if [[ $? -ne 0 ]]; then
            printf "Testcase %2d: %-10s ... %10s!\n" "$num_testcases" "<$command>" "${red}FAILED${normal}"
            num_failed=$((num_failed + 1))
            failed_cases+=(["$num_testcases"]="$command")
        else
            printf "Testcase %2d: %-10s ... %10s!\n" "$num_testcases" "<$command>" "${green}PASSED${normal}"
            num_passed=$((num_passed + 1))
        fi
        num_testcases=$((num_testcases + 1))
    done
}

test_invalid_inputs() {
    # Invalid Inputs:
    # 1. Invalid Max Command
    # 2. Invalid Statecode
    # 3. Invalid Year
    INVALID_COMMANDS=("maxnear" "ca" "xx" "AA" "201" "20100" "20101")
    for command in "${INVALID_COMMANDS[@]}"; do
        ("$PROGRAM" "$FILE" "$command" 2>&1) | diff - "./tests/out/invalid_commands/$command.out" >/dev/null
        if [[ $? -ne 0 ]]; then
            printf "Testcase %2d: %-10s ... %10s!\n" "$num_testcases" "<$command>" "${red}FAILED${normal}"
            num_failed=$((num_failed + 1))
            failed_cases+=(["$num_testcases"]="$command")
        else
            printf "Testcase %2d: %-10s ... %10s!\n" "$num_testcases" "<$command>" "${green}PASSED${normal}"
            num_passed=$((num_passed + 1))
        fi
        num_testcases=$((num_testcases + 1))
    done
}

test_amount_arg() {
    # Error Handling: Invalid Number of Arguments
    VALID_COMMANDS=("maxstate" "maxyear" "2010" "2013" "2011" "2009" "9999" "TX" "CA")
    "$PROGRAM" "$FILE" "maxstate" "maxyear" "maxstate" "maxyear" "maxstate"
}

conclusion() {
    printf -- '-%.0s' {1..100}
    echo ""
    printf "%d testcases ran, %d %s, %d %s.\n" "$num_testcases" "$num_passed" "${green}PASSED${normal}" "$num_failed" "${red}FAILED${normal}"
    if [[ $num_failed -eq 0 ]]; then
        printf "All testcases passed. %s\n" "${green} Congratulations!${normal}"
        printf '\U1F389\n'
    else
        printf "Failed Testcases: \n"
        for i in "${!failed_cases[@]}"; do
            printf "${red}Testcase %2d: %s\n${normal}" "$i" "<${failed_cases[$i]}>"
        done
    fi
}

main() {
    test_valid_inputs
    test_invalid_inputs
    conclusion
}

main

# # Error Handling: Invalid Filename
# FILE_WRONG="Cyber_Security_Breaches.tsvx"
# "$PROGRAM" "$FILE_WRONG" "maxstate" | diff - "./out/maxstate.out"
# if [[ $? -ne 0 ]]; then
#     printf "Testcase: <maxstate> ... FAILED!\n"
# else
#     printf "Testcase: <maxstate> ... PASSED!\n"
# fi

# "$PROGRAM" "$FILE_WRONG" "maxyear" | diff - "./out/maxyear.out"
# if [[ $? -ne 0 ]]; then
#     printf "Testcase: <wrong file> . FAILED!\n"
# else
#     printf "Testcase: <wrong file> . PASSED!\n"
# fi

# "$PROGRAM" "$FILE_WRONG" "2010" | diff - "./out/2010.out"
# if [[ $? -ne 0 ]]; then
#     printf "Testcase: <wrong file> . FAILED!\n"
# else
#     printf "Testcase: <wrong file> . PASSED!\n"
# fi

# "$PROGRAM" "$FILE_WRONG" "TX" | diff - "./out/2013.out"
# if [[ $? -ne 0 ]]; then
#     printf "Testcase: <wrong file> . FAILED!\n"
# else
#     printf "Testcase: <wrong file> . PASSED!\n"
# fi

# # Error Handling: Invalid Number of Arguments
# "$PROGRAM" "$FILE_WRONG" maxstate maxyear maxstate maxyear maxstate

# # ./cyber_breaches Cyber_Security_Breaches.tsv maxstate maxyear
# # ./cyber_breaches Cyber_Security_Breaches.tsv maxstate maxyear maxstate
# # ./cyber_breaches Cyber_Security_Breaches.tsv maxstate maxyear maxstate maxyear
# # ./cyber_breaches Cyber_Security_Breaches.tsv 2010 2012

# # # Error Handling: No Arguments
# # ./cyber_breaches
# # ./cyber_breaches Cyber_Security_Breaches.tsv
