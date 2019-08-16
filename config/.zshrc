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
# cdで移動してもpushdと同じようにディレクトリスタックに追加する。
setopt auto_pushd
# ディレクトリスタックへの追加の際に重複させない
setopt pushd_ignore_dups

# ビープ音を鳴らさないようにする
setopt no_beep
# カッコの対応などを自動的に補完する
setopt auto_param_keys
# ディレクトリ名の入力のみで移動する
setopt auto_cd
# bgプロセスの状態変化を即時に知らせる
setopt notify
# 8bit文字を有効にする
setopt print_eight_bit
# 終了ステータスが0以外の場合にステータスを表示する
setopt print_exit_value
# ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt mark_dirs
# コマンドのスペルチェックをする
setopt correct
# コマンドライン全てのスペルチェックをする
setopt correct_all
# 上書きリダイレクトの禁止
setopt no_clobber
# パスの最後のスラッシュを削除しない
setopt noautoremoveslash
# 各コマンドが実行されるときにパスをハッシュに入れる
#setopt hash_cmds
#
## 実行したプロセスの消費時間が3秒以上かかったら
## 自動的に消費時間の統計情報を表示する。
REPORTTIME=5

## 「/」も単語区切りとみなす。
WORDCHARS=${WORDCHARS:s,/,,}
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

#色の定義
#黒赤緑黄青紫水白
local BLACK=$'%{\e[1;30m%}'
local RED=$'%{\e[1;31m%}'
local GREEN=$'%{\e[1;32m%}'
local YELLOW=$'%{\e[1;33m%}'
local BLUE=$'%{\e[1;34m%}'
local PURPLE=$'%{\e[1;35m%}'
local LIGHTBLUE=$'%{\e[1;36m%}'
local WHITE=$'%{\e[1;37m%}'
local DEFAULT=$'%{\e[1;m%}'

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
# 補完キー連打で順に補完候補を自動で補完
# select=2: 補完候補を一覧から選択する。
#           ただし、補完候補が2つ以上なければすぐに補完する。
zstyle ':completion:*' menu select=2
# 補完候補が複数ある時、一覧表示 (auto_list) せず、すぐに最初の候補を補完する
#setopt menu_complete # 強制で最初のが選択されるのが使いづらいので無効化
# 補完候補をできるだけ詰めて表示する
setopt list_packed
# 補完候補にファイルの種類も表示する(ls -Fの記号)
setopt list_types
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# キャッシュの利用による補完の高速化
zstyle ':completion::complete:*' use-cache true
# 補完候補に色つける
autoload -U colors ; colors ; zstyle ':completion:*' list-colors "${LS_COLORS}"
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'
# 大文字・小文字を区別しない(大文字を入力した場合は区別する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# manの補完をセクション番号別に表示させる
zstyle ':completion:*:manuals' separate-sections true
# 補完候補の候補のセパレートを変更
zstyle ':completion:*' list-separator '-->'
# --prefix=/usr などの = 以降でも補完
setopt magic_equal_subst
## カッコの対応などを自動的に補完
setopt auto_param_keys
## 補完時にヒストリを自動的に展開する。
setopt hist_expand
# 詳細な情報を使う。
zstyle ':completion:*' verbose yes
## 辞書順ではなく数字順に並べる。
setopt numeric_glob_sort

zstyle ':completion:*:descriptions' format $GREEN'completing %B%d%b'$DEFAULT
zstyle ':completion:*:messages' format $LIGHTBLUE'%d'$DEFAULT
zstyle ':completion:*:corrections' format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
zstyle ':completion:*:warnings' format $RED'No matches for:'$YELLOW' %d'$DEFAULT

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

## 補完方法毎にグループ化する。
### 補完方法の表示方法
###   %B...%b: 「...」を太字にする。
###   %d: 補完方法のラベル
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''

# -----------------------------
# alias
# -----------------------------
# aliasの読み込み
[ -f ~/.read_conf/.alias ] && source ~/.read_conf/.alias

# zshのglobal alias
alias -g L='| less'
alias -g H='| head'
alias -g G='| grep'
alias -g GI='| grep -ri'
