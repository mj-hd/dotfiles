source ~/.zplug/init.zsh

# 出力をハイライト
zplug "zsh-users/zsh-syntax-highlighting"

# fishっぽい補完
zplug "zsh-users/zsh-autosuggestions"

# 各種補完
zplug "zsh-users/zsh-completions"

# テーマ
zplug "mafredri/zsh-async", from:github

# interactiveなtab保管
zplug "changyuheng/fz", defer:1
zplug "rupa/z", use:z.sh

# .autoenv.zsh読み込み
zplug "Tarrasch/zsh-autoenv"

# 未インストールプラグインのチェック
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi

zplug load

export YVM_DIR=/usr/local/opt/yvm
[ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh

export GOPATH=~/.go
export PATH=$PATH:$GOPATH/bin
export EDITOR=nvim
alias vim="nvim"
alias ls="ls -G"
alias r="ranger"

# nodenv
eval "$(nodenv init -)"

# goenv
eval "$(goenv init -)"

# starship
eval "$(starship init zsh)"

[ -f ~/.env ] && source ~/.env
[ -f ~/.zshfuncs ] && source ~/.zshfuncs
