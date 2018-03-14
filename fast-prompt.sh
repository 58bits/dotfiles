#!/bin/bash

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Fast prompt - ideal for WSL, or slower machines.
# http://ezprompt.net/
# https://misc.flogisoft.com/bash/tip_colors_and_formatting

# The more git options you enable, the slower the prompt.
export ENABLE_GIT_STATUS=true
# GIT_PS1_SHOWSTASHSTATE=true
# GIT_PS1_SHOWUNTRACKEDFILES=true
# GIT_PS1_SHOWCOLORHINTS=true
# GIT_PS1_HIDE_IF_PWD_IGNORED=true
export GIT_PS1_SHOWDIRTYSTATE=true 
# export GIT_PS1_SHOWUPSTREAM="auto"

# Enable powerline symbols. You don't need to install powerline.
# There is a sub-repo of modified powerline fonts in the
# .dotfiles/fonts directory. Run the OS-specific installer to
# install the fonts.
export ENABLE_POWERLINE_SYMBOLS=true

update_PS1 () {
  if [ -n "$ENABLE_GIT_STATUS" ] && [ "$ENABLE_GIT_STATUS" = true ]  && [ -n "$(type -t __git_ps1)" ]; then
    git=$(__git_ps1)
  fi

  if [ -n "$ENABLE_POWERLINE_SYMBOLS" ] && [ "$ENABLE_POWERLINE_SYMBOLS" = true ]; then
    prompt=""
    left_separator_main=''  #   You don't need to install Powerline
    left_separator_sub=''   #   you only need fonts patched with
    right_separator_main='' #   Powerline symbols or the standalone
    right_separator_sub=''  #   PowerlineSymbols.otf font

    if [ -n "$git" ]; then
      #prompt=${git#" "} # trim leading spaces
      prompt="${git//\(}" # remove left paren
      prompt="${prompt//\)}" # remove right paren
      if [[ $prompt == *"master"* ]]; then
        prompt="\[\e[48;5;75m\]\[\e[30m\]$prompt \[\e[m\]\[\e[38;5;75m\]$left_separator_main\[\e[m\]" #warning color if on master
      else
        prompt="\[\e[48;5;79m\]\[\e[30m\]$prompt \[\e[m\]\[\e[38;5;79m\]$left_separator_main\[\e[m\]" #green for any other branch
      fi
    fi  
    
    username="\[\e[41m\]\[\e[97m\] \u \[\e[m\]\[\e[47m\]\[\e[31m\]$left_separator_main\[\e[m\]"
    hostname="\[\e[47m\]\[\e[30m\] \H \[\e[m\]\[\e[48;5;228m\]\[\e[37m\]$left_separator_main\[\e[m\]"
    directory="\[\e[48;5;228m\]\[\e[30m\] \w \[\e[m\]\[\e[38;5;228m\]$left_separator_main\[\e[m\]"

    PS1="$username$hostname$directory\n$prompt"

  else 
    prompt=">"
    if [ -n "$git" ]; then
      prompt=${git#" "}" $prompt" # trim leading, and add a trailing space and prompt
      if [[ $prompt == *"master"* ]]; then
        prompt="\[\e[31m\]$prompt\[\e[m\]" #warning color if on master
      else
        prompt="\[\e[32m\]$prompt\[\e[m\]" #green for any other branch
      fi
    fi  

    username="\[\e[32m\]\u\[\e[m\]"
    hostname="\[\e[36m\]\H\[\e[m\]"
    directory="\[\e[33m\]:\[\e[m\]\[\e[33m\]\w\[\e[m\]"

    PS1="$username@$hostname$directory\n$prompt"

  fi  
}

shopt -u promptvars
PROMPT_COMMAND=update_PS1
