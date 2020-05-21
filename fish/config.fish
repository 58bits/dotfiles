# abbreviations
if status --is-interactive
		abbr --add --global ga git add
		abbr --add --global gaa git add --all
		abbr --add --global gc git commit
		abbr --add --global gca git commit -a
		abbr --add --global gb git branch
		abbr --add --global gba git branch -a
		abbr --add --global gbd git branch -d
		abbr --add --global gco git checkout
		abbr --add --global gcob git checkout -b
		#alias gm git merge
		abbr --add --global gr git rebase
		abbr --add --global gl git log
		abbr --add --global lg git log --graph --full-history --all --color --pretty format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"
		abbr --add --global glf git log --pretty full
		abbr --add --global gs git status
		abbr --add --global gsh git show
		abbr --add --global gd git diff
		abbr --add --global gbl git blame
		abbr --add --global gps git push
		abbr --add --global gpl git pull
		abbr --add --global grm "git status | grep deleted | awk '{print \$3}' | xargs git rm"
end

# functions
function c
  cd ~/Clients
end

function p
  cd ~/Projects
end

function s
  cd ~/Scripts
end

set -x PATH ./node_modules/.bin $PATH
set -x PATH (yarn global bin) $PATH

# look for machine specific configuration
if test -e ~/.local.fish
    source ~/.local.fish
end
