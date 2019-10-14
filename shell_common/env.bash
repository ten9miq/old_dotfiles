# tmux上でも256色に対応するための設定
export TERM=xterm-256color

# User specific environment and startup programs
export PATH="$PATH:$HOME/bin"

# ファイル・ディレクトリ等の色の設定(BSD用)
export LSCOLORS=Exfxcxdxbxegedabagacad
# ファイル・ディレクトリ等の色の設定(GNU用)
export LS_COLORS='di=01;96:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# fzfのサイズ設定
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_COMPLETION_TRIGGER="**" # default: '**'

# fzfのファイル類のパスを追加
if [[ ! "$PATH" == *$HOME/.config/shell_common/.fzf/bin* ]]; then
   export PATH="${PATH:+${PATH}:}$HOME/.config/shell_common/.fzf/bin"
fi

#---------------------------------------------------------------
# lessの設定
#---------------------------------------------------------------
# less起動時のデフォルト設定を記載
# --no-init lessを閉じたときに表示内容を消さない
# --quit-if-one-screen 表示内容が1ページの時cat的な動作をする --no-initがないと表示せずに閉じられてしまう
#  →上記を組み合わせると長いログがそのままshell上に残るのでsmartlessというのを使う (lessのラッパー  1画面に収まるのはcatのように動く
export LESS='--squeeze-blank-lines --LINE-NUMBERS --ignore-case --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --window=-4 --tabs=4 --shift=20'
export PAGER='less --line-numbers' # manなどのページャーとしてlessを使用する $LESSが有効 行番号は非表示
#less上での色 色 0黒,1赤,2緑,3黄色,4青,5ピンク,6水色,7白
export LESS_TERMCAP_mb=$(tput bold)                # begin blinking
export LESS_TERMCAP_md=$(tput bold; tput setaf 2)  # begin bold (green)
export LESS_TERMCAP_me=$(tput sgr0)                # end mode
export LESS_TERMCAP_se=$(tput sgr0)                # end standout-mode
export LESS_TERMCAP_so=$(tput rev; tput setaf 3)  # begin standout-mode (yellow)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)     # end underline
export LESS_TERMCAP_us=$(tput smul; tput setaf 1)  # begin underline (cyan)

#---------------------------------------------------------------
# NVM (nodejsのため)
# nvmインストール方法
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
# nvm install --lts # nodejsの長期安定バージョンのインストール
#---------------------------------------------------------------
if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
fi

