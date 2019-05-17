source ~/.zplug/init.zsh

# 出力をハイライト
zplug "zsh-users/zsh-syntax-highlighting"

# fishっぽい補完
zplug "zsh-users/zsh-autosuggestions"

# 各種補完
zplug "zsh-users/zsh-completions"

# テーマ
zplug denysdovhan/spaceship-prompt, use:spaceship.zsh, from:github, as:theme

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.env ] && source ~/.env
