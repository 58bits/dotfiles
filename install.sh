#!/bin/bash

# Install script for dotfiles.
# change me.

# (c) Copyright (c) 2018, Anthony Bouch (tony@58bits.com). All rights reserved.
#
# THIS SOFTWARE IS PROVIDED BY AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.

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

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
#
# FUNCTION: symlink
# Params: $1 = source file
# Params: $2 = target symlink
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
symlink() {
  if [ -z "$1" -o ! -e "$1" ]; then
    echo "symlink requires a valid source file or directory as an argument."
    exit 1
  fi

  if [ -e  $2 ]; then
    echo "$2 exists. Overwrite?"
    echo -n "(y/n):"
    read ans
    case $ans in
    Y|y) 
        rm $2 #just in case it's a directory - otherwise the symlink will be nested inside.
        ln -fs $1 $2 
         ;;
    N|n) ;;
    *) echo "Invalid command"
       exit ;;
    esac
  else
    ln -fs $1 $2
  fi  
}

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
#
# FUNCTION: copy
# Params: $1 = source file
# Params: $2 = destination file
#
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~##
copy() {
  if [ -z "$1" -o ! -e "$1" ]; then
    echo "copy requires a valid source file."
    exit 1
  fi

  if [ -e  $2 ]; then
    echo "$2 exists. Overwrite?"
    echo -n "(y/n):"
    read ans
    case $ans in
    Y|y) 
        cp $1 $2
         ;;
    N|n) ;;
    *) echo "Invalid command"
       exit ;;
    esac
  else
    cp $1 $2
  fi  
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

echo "Symlinking files"

symlink "${HOME}/.dotfiles/bash" "${HOME}/.bash"
symlink "${HOME}/.dotfiles/vim" "${HOME}/.vim"
symlink "${HOME}/.dotfiles/cheat" "${HOME}/.cheat"
symlink "${HOME}/.dotfiles/dircolors-custom/dircolors.256dark" "${HOME}/.dircolors"
symlink "${HOME}/.dotfiles/bash-git-prompt" "${HOME}/.bash-git-prompt"
symlink "${HOME}/.dotfiles/git-prompt-colors.sh" "${HOME}/.git-prompt-colors.sh"
symlink "${HOME}/.dotfiles/tmux" "${HOME}/.tmux"
symlink "${HOME}/.dotfiles/tmux.conf" "${HOME}/.tmux.conf"
symlink "${HOME}/.dotfiles/tmux.conf.local" "${HOME}/.tmux.conf.local"

# Find all remaining target source files to symlink.
# Ignore all files with a 'dot' in them.
files=$(find $(pwd) -maxdepth 1 -type f  \! -name '*\.*')

for file in $files ; do
  target="${HOME}/.$(basename $file)"
  symlink $file $target
done

git_config
