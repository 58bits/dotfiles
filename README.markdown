# Anthony Bouch's Dot Files

![DotFiles](https://github.com/58bits/dotfiles/raw/master/screenshot.png "Anthony's Dot Files")

## Installation

    git clone https://github.com/58bits/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    git submodule init
    git submodule update
    ./install.sh

(Note: to pull future upstream changes for all submodules call `git submodule update --remote`)

Then edit your .bashrc file to include the following..


    source ~/.bash/aliases
    source ~/.bash/completions
    source ~/.bash/config


For powerline support and symbols in Vim and tmux, run the OS-specific install script in the fonts directory. I've had the most luck with DejaVu Sans Mono across Windows, MacOS and Linux.


## Configuration

#### PS1 Prompt

There are example (commented) PS1 prompt versions in bashrc_sample using:

1. Wayne E. Seguin's excellent Bash shell prompt (see below links).
2. Martin Gondermann's bash-git-prompt.
3. A very fast 'own rolled' PS1 prompt with git support via \_\_git_ps1, which is ideal for slower machines (see below)

<img src="https://github.com/58bits/dotfiles/raw/master/fast-prompt.png" alt="fast-prompt" width=540 height=280 style="width: 540px; height: 280px; margin-left: 0.5em;" />

#### tmux

Note - I've temporarily removed the sub-repo to Gregory Pakosz's amazing tmux config  
https://github.com/gpakosz/.tmux  
The slow shell spawn times in WSL meant that Gregory's config was very slow to load.

My tmux configuration is based on a trimmed down version of Gregory Pakosz's amazing tmux config  
https://github.com/gpakosz/.tmux with shell helper functions extracted into the tmux directory, combined with a few additional helper scripts from Erik Westrup's excellent setup here https://github.com/erikw/tmux-powerline. There is a sample tmux.conf and tmux.conf.local in the .dotfiles directory which will be symlinked as ~/.tmux.conf and ~/.tmux.config.local after running install.sh. Powerline modified fonts are also included as a sub-repo, which you'll need for Powerline symbol support in both tmux and vim-airline.

## Environment

This should all work under WSL, WSL 2, MacOS and Linux

See the basrc_sample script - which can be copied to your own .bashrc file.  
https://github.com/58bits/dotfiles/blob/master/bashrc_sample 

I've included a modified set of directory LS colors in dircolors-custom, which will be symlinked to ${HOME}/.dircolors after running install.sh.


## Features

A nice PS1 prompt from Wayne E. Seguin [http://beginrescueend.com/ of RVM fame](http://beginrescueend.com/) which can be found in the contrib section of RVM.  
https://github.com/wayneeseguin/rvm/blob/master/contrib/ps1_functions  
A copy of the function is also in the bash/functions directory - so that it can be sourced without RVM installed.

Alternative PS1 prompt from Martin Gondermann's bash-git-prompt.  
https://github.com/magicmonty/bash-git-prompt

I've included git-branch-status with a `gbs` wrapper function in bash/aliases
Useful with the 'fast' \_\_git_ps1 based PS1 prompt shown in bashrc_sample.  
https://github.com/bill-auger/git-branch-status/

Bitstream Vera Sans Mono fonts are also included in the repo:  
http://www-old.gnome.org/fonts/  
http://ftp.gnome.org/pub/GNOME/sources/ttf-bitstream-vera/1.10/  
http://www.58bits.com/blog/2011/03/15/beautiful-developers-font  
You'll need to update your `.gvimrc` accordingly if you choose not to use Vera Sans Mono.

A git submodule to Powerline modifed fonts is located in the fonts directory  
https://github.com/powerline/fonts (although https://www.nerdfonts.com/ is a fun alternative).

My ultimate Vim color theme, daring-dark.vim is now vim and gvim matched.  
https://github.com/58bits/dotfiles/blob/master/vim/colors/daring-dark.vim

Some initial 'cheat' files are included in the cheat directory. You'll need the very cool cheat app from Chris Allen Lane  
https://github.com/chrisallenlane/cheat

Also contains my cleaned-up Vim config and core plugins, all loaded via pathogen.

Enjoy.
