source ~/.zplug/init.zsh

# zplug
zplug "mollifier/anyframe"
zplug "mollifier/cd-gitroot"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"
zplug "chrissicool/zsh-256color"
zplug "junegunn/fzf-bin", as:command, from:gh-r
zplug "b4b4r07/zsh-gomi", as:command, use:bin
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
fbra() {
	local branches branch
	branches=$(git branch -vv) &&
	branch=$(echo "$branches" | fzf-bin +m) &&
	git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

fd() {
	local dir
	dir=$(find ${1:-.} -path '*/\.*' -prune \
		-o -type d -print 2> /dev/null | fzf-bin +m) &&
	pushd "$dir"
}

fdd() {
	popd
}

fv() {
	local file
	file=$(find ${1:-.} -path '*/\.*' -prune \
		-o -type f -print 2> /dev/null | fzf-bin +m) &&
	nvim "$file"
}

fh() {
	local cmd
	cmd=$(history -n -r 1 | fzf-bin +m) &&
	print -z "$cmd"
}

fk() {
	local pid
	if [ "$UID" != "0" ]; then
		pid=$(ps -f -u $UID | sed 1d | fzf-bin -m | awk '{print $2}')
	else
		pid=$(ps -ef | sed 1d | fzf-bin -m | awk '{print $2}')
	fi
	if [ "x$pid" != "x" ]
	then
		echo $pid | xargs kill -${1:-9}
	fi
}

fshow() {
	git log --graph --color=always \
		--format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
	fzf-bin --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
	  --bind "ctrl-m:execute:
				(grep -o '[a-f0-9]\{7\}' | head -1 |
				xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
				{}
FZF-EOF"
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

export EDITOR=nvim
export TERM=xterm-256color
export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_dups

if [ $SHLVL = 1 ]; then
  alias tmux="tmux attach || tmux new-session \; source-file ~/.tmux.session"
fi

alias ls="ls --color=tty --show-control-chars -G"
alias la="ls --color=tty --show-control-chars -a"
alias ll="ls --color=tty --show-control-chars -lh"
alias vim="nvim"

alias dummysmtp="sudo python -m smtpd -n -c DebuggingServer localhost:25"

export PATH=$PATH:~/Projects/memo:~/.local/bin
