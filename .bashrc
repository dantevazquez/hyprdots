[[ $- != *i* ]] && return
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi
alias tc='tmux new-session -A -s code'
alias ls='ls -la --color=auto'
alias grep='grep --color=auto'
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1='[\u@\h \W$(parse_git_branch)]\$ '
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/scripts:$PATH"
export EDITOR="nvim"
export VISUAL="nvim"
eval "$(fzf --bash)"
fcd() {
local dir
dir=$(fd --type d --hidden --exclude .git | fzf) && cd "$dir"
}
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"
