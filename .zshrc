source ~/.zplug/init.zsh

# zplug
zplug "mollifier/anyframe"
zplug "mollifier/cd-gitroot"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "chrissicool/zsh-256color"
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "b4b4r07/zsh-gomi", as:command, use:bin, rename-to:rm
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi

zplug load

# func
fbr() {
	local branches branch
	branches=$(git branch -vv) &&
	branch=$(echo "$branches" | fzf +m) &&
	git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

fd() {
	local dir
	dir=$(find ${1:-.} -path '*/\.*' -prune \
		-o -type d -print 2> /dev/null | fzf +m) &&
	pushd "$dir"
}

fdd() {
	popd
}

# User configuration

export PATH=$PATH:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
export PATH=$PATH:$GOPATH/bin:/mnt/c/Windows/System32
# export MANPATH="/usr/local/man:$MANPATH"
export INCLUDE="/usr/local/Cellar/opencv/2.4.9/include"
export PYTHONPATH=/usr/local/Cellar/opencv/2.4.9/lib/python2.7/site-packages:$PYTHONPATH

# for go lang
if [ -x "`which go`" ]; then
  export GOROOT=`go env GOROOT`
  export GOPATH=$HOME/.go
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

export TERM=xterm-256color

if [ $SHLVL = 1 ]; then
  alias tmux="tmux attach || tmux new-session \; source-file ~/.tmux.session"
fi

alias ls="ls -G"
alias la="ls -a"
alias ll="ls -lh"
alias lj="ls --color=tty --show-control-chars"
alias vim="nvim"

alias dummysmtp="sudo python -m smtpd -n -c DebuggingServer localhost:25"

export PATH=$PATH:~/Projects/memo:~/.local/bin
