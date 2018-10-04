parse_git_branch() {
    git_branch=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')
    if [[ $git_branch ]]; then
    echo "[$git_branch] "
    else
    echo ""
    fi
}

set show-all-if-ambiguous on
set show-all-if-unmodified on

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ..='cd ../'
alias prev='cd -'
alias godmode='chmod 777'
alias src='source ~/.bashrc'
alias ls='ls --color=auto'
alias ll='ls --color=auto -l'
alias la='ls --color=auto -la'
alias diff='colordiff'
alias grep='grep --color=auto -n'
alias ping='ping -c 4'
alias meminfo='free -m -l -t'
alias cpuinfo='less /proc/cpuinfo'
alias ff='firefox'
alias rm='rm -rfv'
alias mkdir='mkdir -pv'
alias mkcd='foo(){ mkdir "$@" ; cd "$@"; }; foo'
alias tgz='tar -xvfz'
alias df='df -h'
alias hs='history | grep'
alias psgrep='ps aux | grep'
alias atom='sudo atom'
alias atop='sudo atom ./'
alias gcc='gcc -Wall -g3 -O0'
alias py='python3 -q'
alias pacman='sudo pacman'
alias pacin='sudo pacman -S'
alias pacde='sudo pacman -Rdd'
alias pacup='sudo pacman -Syu ; echo Done - Press enter to exit; read'
alias mkpkg='makepkg -s'

alias gnew='git init'
alias gac='git aa && git cm'
alias gnb='git nb'
alias gpo='git pu origin'
alias gh='git hist'


PS1="\[\e[1;92m\]\u@\h\[\e[m\] \[\e[1;94m\]\w\[\e[m\]\[\e[1;93m\] \$(parse_git_branch)\[\e[m\]\[\e[1;32m\]\$\[\e[m\] \[\e[0;97m\]"
