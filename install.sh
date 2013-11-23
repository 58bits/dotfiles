#!/bin/bash

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
#
# FUNCTION: get_required_input
# Get user input from the terminal.
# Params: $1 = the message prompting the user.
# Params: $2 = the error message if no input is received.
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
get_required_input() {
    if [ -z "$1" -o -z "$2" ]; then
        echo "get_required_input requires a prompt and an error message as first and second parameters." >&2
        exit 1
    fi

    while true; do
        echo -n "$1" >&2
        read input
        if [ -z "$input" ]; then
            echo "$2" >&2
        else
            break
        fi
    done
    echo $input
}

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
#
# FUNCTION: process_tempalte
# Perform token replacement on a text template.
# Params: $1 = the input file
# Params: $2 = the output file
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
process_template() {
    if [ -z "$1" -o -z "$2" ]; then
        echo "process_template requires an output and input file as parameters."
        exit 1
    fi

    cp /dev/null $2
    
    while read line ; do
        while [[ "$line" =~ (\$\{[a-zA-Z_][a-zA-Z_0-9]*\}) ]] ; do
            LHS=${BASH_REMATCH[1]}
            RHS="$(eval echo "\"$LHS\"")"
            line=${line//$LHS/$RHS}
        done
        #echo $line
        echo $line >> $2
    done < $1
}

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
#
# FUNCTION: git_config
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
git_config() {

    echo "Configuring ~/.gitconfig..."
    name=$(get_required_input "Enter your full name: " "Please enter your full name.")
    email=$(get_required_input "Enter your email address: " "Please enter your email address.")
    github=$(get_required_input "Enter your github user ID: " "Please enter your github user ID.")
    home=$HOME

    echo "Create a new ${HOME}/.gitconfig file with name: $name, email: $email and github user ID: $github?"
    echo -n "(y/n)"
    read ans

    case $ans in
    Y|y) ;;
    [Yy][Ee][Ss]) ;;
    N|n) exit ;;
    [Nn][Oo]) exit ;;
    *) echo "Invalid command"
       exit ;;
    esac

    echo "Creating ~/.gitconfig"
    process_template "./gitconfig.template" "${HOME}/.gitconfig"
}


###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
# 
# Start...
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##

if [ ! -d "${HOME}/.dotfiles" ]; then
    echo "Your 'dotfiles' source files and this script should be located in the directory ${HOME}/.dotfiles"
    echo "Please clone the git repo into this directory and try again."
    exit 1
fi

cd $HOME/.dotfiles #Just to be sure.

#git_config

echo "Symlinking files"

# Find all of our target source files to symlink
files=$(find . -maxdepth 1 -type f  \! -name '*\.*')

for file in $files ; do
  echo $file
done