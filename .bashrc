#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Insert current git branch into Prompt. Do nothing, if you are not in GitHub repo
git_branch_parsing() {
  git_branch=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')
  if [[ $git_branch ]]; then
    echo "[$git_branch] "
  else
    echo ""
  fi
}

make_and_change_dir() {
  mkdir "$@";
  cd "$@";
}

git_init_with_cd() {
  git init "$@";
  cd "$@";
}

git_commit_and_push() {
  gac "$@";
  gpo;
}

# Shortens git-clone command syntax. Now you needn't type whole path
git_clone_github() {
  git clone https://github.com/"$@";
}

# Same for AUR-packages in ArchLinux
git_clone_aur() {
  git clone https://aur.archlinux.org/"$@";
}

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

# Bash autocomplete via TAB
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

set show-all-if-ambiguous on
set show-all-if-unmodified on

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1="\[\e[1;91m\]\u@\h\[\e[m\] \[\e[1;94m\]\W\[\e[m\]\[\e[1;93m\] \$(git_branch_parsing)\[\e[m\]\[\e[1;92m\]\$\[\e[m\] \[\e[0;97m\]"
	else
		PS1="\[\e[1;92m\]\u@\h\[\e[m\] \[\e[1;94m\]\w\[\e[m\]\[\e[1;93m\] \$(git_branch_parsing)\[\e[m\]\[\e[1;92m\]\$\[\e[m\] \[\e[0;97m\]"
	fi

	alias ls='ls --color=auto'
	alias ll='ls --color=auto -l'
	alias la='ls --color=auto -la'
	alias diff='diff --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

# Usefull aliases for whatever yo want
alias ..='cd ../'
alias src='source ~/.bashrc'
alias tstping='ping -c4 -i0.2 8.8.8.8'
alias ifconfig='ip address show'
alias meminfo='free -m -l -t'
alias cpuinfo='less /proc/cpuinfo'
alias ff='firefox'
alias rm='rm -rfv'
alias mkdir='mkdir -pv'
alias mkcd='make_and_change_dir'
alias shut='shutdown 0'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m -l -t'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less
alias hs='history | grep'
alias psa='ps aux'
alias psgrep='ps aux | grep'
alias at='atom ./'
alias gcc='gcc -Wall -g3 -O0'
alias py='python3 -q'
alias gdb='gdb -q'
alias '+x'='chmod +x'

# Aliases for aliases
alias gnew='git_init_with_cd'
alias gac='git aa && git cm'
alias gpo='git pu origin'
alias gcp='git_commit_and_push'
alias gnb='git nb'
alias gch='git ch'
alias gpl='git pull'
alias gst='git st'
alias gcl='git_clone_github'
alias gaur='git_clone_aur'
alias gh='git hist'
alias gmf='git mg --no-ff'

# Pacman aliases (delete it, if you don't need it)
alias pacman='sudo pacman'
alias pacin='sudo pacman -S'
alias pacde='sudo pacman -Rdd'
alias pacup='sudo pacman -Syu ; ~/.postinstall.sh'
alias mkpkg='makepkg -sic'

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
