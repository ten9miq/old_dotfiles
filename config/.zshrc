# -----------------------------
# Lang
# -----------------------------
#export LANG=ja_JP.UTF-8
#export LESSCHARSET=utf-8

# -----------------------------
# General
# -----------------------------
# 色を使用
autoload -Uz colors ; colors
# エディタをvimに設定
export EDITOR=vim
# Ctrl+Dでログアウトしてしまうことを防ぐ
#setopt IGNOREEOF
# パスを追加したい場合
export PATH="$HOME/bin:$PATH"
# cdした際のディレクトリをディレクトリスタックへ自動追加
setopt auto_pushd
# ディレクトリスタックへの追加の際に重複させない
setopt pushd_ignore_dups

# -----------------------------
# Prompt
# -----------------------------
# %M    ホスト名
# %m    ホスト名
# %d    カレントディレクトリ(フルパス)
# %~    カレントディレクトリ(フルパス2)
# %C    カレントディレクトリ(相対パス)
# %c    カレントディレクトリ(相対パス)
# %n    ユーザ名
# %#    ユーザ種別
# %?    直前のコマンドの戻り値
# %D    日付(yy-mm-dd)
# %W    日付(yy/mm/dd)
# %w    日付(day dd)
# %*    時間(hh:flag_mm:ss)
# %T    時間(hh:mm)
# %t    時間(hh:mm(am/pm))

# zshのの利用可能な色の一覧表示
zsh_color(){
  for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15  ] && echo;done;echo"]"
}

#PROMPT='%F{cyan}%n@%m%f:%~# '

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' formats "%F{green}[%r@%b][%S]"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info  }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

PROMPT="
%F{245}[%{%D %*]%f${fg[cyan]}%} %~%{${reset_color}%}
%F{200}%n%f%F{021}@%f%F{green}%m%f $ "

# -----------------------------
# Completion
# -----------------------------
# 自動補完を有効にする
autoload -Uz compinit ; compinit
# 単語の入力途中でもTab補完を有効化
setopt complete_in_word
# コマンドミスを修正
setopt correct
# 補完の選択を楽にする
zstyle ':completion:*' menu select
# 補完候補をできるだけ詰めて表示する
setopt list_packed
# 補完候補にファイルの種類も表示する
#setopt list_types
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# キャッシュの利用による補完の高速化
zstyle ':completion::complete:*' use-cache true
# 補完候補に色つける
autoload -U colors ; colors ; zstyle ':completion:*' list-colors "${LS_COLORS}"
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# 大文字・小文字を区別しない(大文字を入力した場合は区別する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# manの補完をセクション番号別に表示させる
zstyle ':completion:*:manuals' separate-sections true
# --prefix=/usr などの = 以降でも補完
setopt magic_equal_subst
