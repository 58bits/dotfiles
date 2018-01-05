# Anthony Bouch's Dot Files

## Installation

    git clone git://github.com/58bits/dotfiles ~/.dotfiles
    cd ~/.dotfiles
    git submodule init
    git submodule update
    ./install.sh

    (Note - for future submodule updates call...)
    git submodule foreach git pull origin master

Then edit your .bashrc file to include the following..


    source ~/.bash/aliases
    source ~/.bash/completions
    source ~/.bash/config

#### PS1 Prompt

There are example (commented) PS1 prompt versions in bashrc_sample using:

1. Wayne E. Seguin's excellent Bash shell prompt (see below links)...
    [[ -s "$HOME/.dotfiles/bash/functions/ps1_functions" ]] && source "$HOME/.dotfiles/bash/functions/ps1_functions"
    ps1_set --prompt ∴
2. Or Martin Gondermann's bash-git-prompt.
3. Or a very fast 'own rolled' PS1 prompt with git support via __git_ps1, which is ideal for WSL or slower machines. 

#### tmux

Note - I've temporarily removed the sub-repo to Gregory Pakosz's amazing Tmux config
https://github.com/gpakosz/.tmux
The very slow shell spawn times in WSL meant that Gregory's config was very slow to load.
I've trimmed down the settings and extracted Gregory's helper functions into the tmux directory. There is a sample tmux.conf and tmux.conf.local in the .dotfiles directory root which will be symlinked as ~/.tmux.conf and ~/.tmux.config.local after running install.sh. Powerline modified fonts are also included as a sub-repo, which you'll need for Powerline symbol support in both Tmux and vim-airline.

## Environment

Should work under WSL, MacOS and Linux

See the basrc_sample script - which can be copied to your own .bashrc file.
https://github.com/58bits/dotfiles/blob/master/bashrc_sample

Initial Windows Subsystem for Linux support is in the bashrc_sample file.

## Features

Nice PS1 prompt from Wayne E. Seguin [http://beginrescueend.com/ of RVM fame](http://beginrescueend.com/) which can be found in the contrib section of RVM.
https://github.com/wayneeseguin/rvm/blob/master/contrib/ps1_functions
A copy of the function is also in the bash/functions directory - so that
it can be sourced without RVM is installed.

Alternative PS1 prompt from Martin Gondermann's bash-git-prompt.
https://github.com/magicmonty/bash-git-prompt

The Bitstream Vera Sans Mono fonts are also included in the repo:
http://www-old.gnome.org/fonts/
http://ftp.gnome.org/pub/GNOME/sources/ttf-bitstream-vera/1.10/
http://www.58bits.com/blog/2011/03/15/beautiful-developers-font
You'll need to update your `.gvimrc` accordingly if you choose not to use Vera Sans Mono.

A git submodule link to Powerline modifed fonts is located in the fonts directory
https://github.com/powerline/fonts

My ultimate Vim color theme, daring-dark.vim is now vim and gvim matched.
https://github.com/58bits/dotfiles/blob/master/vim/colors/daring-dark.vim

Also contains my cleaned-up Vim config and core plugins, all loaded via pathogen.

Enjoy.
