# Anthony Bouch's Dot Files 

Based on Ryan Bates' excellent [Dot Files](https://github.com/ryanb/dotfiles) repository.  
The rake installer has been removed (and therefore the dependency on Ruby) and replaced with a bash install script `install.sh`. Most of the important Vim modules are now git submodules, pointing to the author's repo, and pathogen is now used as the module/bundle manager. Lots of good bash and zsh aliases and helper functions (thanks to Ryan and others).

## Installation

	git clone git://github.com/58bits/dotfiles ~/.dotfiles
	git submodule init
	git submodule update
	cd ~/.dotfiles
	./install.sh

	(Note - for future submodule updates call...)
	git submodule foreach git pull origin master

## Environment

Ryan was running on Mac OS X and using zsh, whereas this repo has been created on both 
Mac OS X and Ubuntu under bash.

See the basrc_sample script - which can be copied to your own .bashrc file.  
[https://github.com/58bits/dotfiles/blob/master/bashrc_sample](https://github.com/58bits/dotfiles/blob/master/bashrc_sample)

## Features

See Ryan's original feature notes at [http://github.com/ryanb/dotfiles](http://github.com/ryanb/dotfiles)

Nice PS1 prompt from Wayne E. Seguin [http://beginrescueend.com/ of RVM fame](http://beginrescueend.com/) which can be found in the contrib section of RVM.
[https://github.com/wayneeseguin/rvm/blob/master/contrib/ps1_functions](https://github.com/wayneeseguin/rvm/blob/master/contrib/ps1_functions)
A copy of the function is also in the bash/functions directory - so that 
it can be sourced before RVM is installed. 

The Bitstream Vera Sans Mono fonts are also included in the repo:  
[http://www-old.gnome.org/fonts/](http://www-old.gnome.org/fonts/)  
[http://ftp.gnome.org/pub/GNOME/sources/ttf-bitstream-vera/1.10/](http://ftp.gnome.org/pub/GNOME/sources/ttf-bitstream-vera/1.10/)  
[http://www.58bits.com/blog/2011/03/15/beautiful-developers-font](http://www.58bits.com/blog/2011/03/15/beautiful-developers-font)  


You'll need to update your `.gvimrc` accordingly if you choose not to use Vera Sans Mono.

My ultimate Vim color theme, daring-dark.vim is now vim and gvim matched.
[https://github.com/58bits/dotfiles/blob/master/vim/colors/daring-dark.vim](https://github.com/58bits/dotfiles/blob/master/vim/colors/daring-dark.vim)  
Note: Use iTerm, or MacVim under Mac OS X. The default Terminal.app is crippled.

Also contains my cleaned-up Vim config and plugins.

Enjoy.
