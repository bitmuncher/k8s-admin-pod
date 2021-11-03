export CLICOLOR=1

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
get_time() {
    date +%H:%M
}
get_python() {
    python --version 2>&1 |awk '{print $2}'
}
get_nodejs() {
    node --version 2>&1
}
prompt_symbol=💀
export PS1='\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h \[\033[33;1m\][\w] \[\033[0;35m\]$(parse_git_branch)\n[Python $(get_python)]\n[Node.js $(get_nodejs)]\n\[\033[;94m\]└─\[\033[1;33m\]$(get_time)\[\033[;0m\] $prompt_symbol  '

export PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin
export LC_ALL=C

# dracula-like color theme
export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

shopt -s checkwinsize

alias grep='grep --color=auto'
alias tree='tree -C'
alias ls='ls -alh --color=auto'

# some stuff for k8s

function kubectlgetall {
    for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
        echo "Resource:" $i
        kubectl ${1} get ${i}
    done
}

source /etc/bash_completion
source <(kubectl completion bash)
alias k=kubectl
complete -F __start_kubectl k
