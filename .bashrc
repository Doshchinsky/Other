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

# Shortens git-clone command syntax. Now you needn't type whole path
git_clone_github() {
  git clone https://github.com/"$@";
}

# Same for AUR-packages in ArchLinux
git_clone_aur() {
  git clone https://aur.archlinux.org/"$@";
}

# Bash autocomplete via TAB
set show-all-if-ambiguous on
set show-all-if-unmodified on

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Usefull aliases for whatever yo want
alias ..='cd ../'
alias prev='cd -'
alias godmode='chmod 777'
alias src='source ~/.bashrc'
alias ls='ls --color=auto'
alias ll='ls --color=auto -l'
alias la='ls --color=auto -la'
alias diff='diff --color=auto'
alias grep='grep --color=auto -n'
alias ping='ping -c 4'
alias meminfo='free -m -l -t'
alias cpuinfo='less /proc/cpuinfo'
alias ff='firefox'
alias rm='rm -rfv'
alias mkdir='mkdir -pv'
alias mkcd='make_and_change_dir'
alias tgz='tar -xvfz'
alias df='df -h'
alias hs='history | grep'
alias psgrep='ps aux | grep'
alias atop='atom ./'
alias gcc='gcc -Wall -g3 -O0'
alias py='python3 -q'
alias pacman='sudo pacman'
alias pacin='sudo pacman -S'
alias pacde='sudo pacman -Rdd'
alias pacup='sudo pacman -Syu ; echo Done - Press enter to exit; read'
alias mkpkg='makepkg -sri'

# Aliases for aliases
alias gnew='git_init_with_cd'
alias gac='git aa && git cm'
alias gnb='git nb'
alias gpo='git pu origin'
alias gst='git st'
alias gcl='git_clone_github'
alias gaur='git_clone_aur'
alias gh='git hist'

# Prompt customization
PS1="\[\e[1;92m\]\u@\h\[\e[m\] \[\e[1;94m\]\w\[\e[m\]\[\e[1;93m\] \$(git_branch_parsing)\[\e[m\]\[\e[1;32m\]\$\[\e[m\] \[\e[0;97m\]"
