# zshの起動処理の速度調査の実行
# zmodload zsh/zprof && zprof

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
autoload -Uz add-zsh-hook

# Ctrl+Dでログアウトしてしまうことを防ぐ
#setopt IGNOREEOF
# Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt no_flow_control
# zsh 5.0.2では下記を記載しないと無効にできない
stty stop undef
stty start undef

# ビープ音を鳴らさないようにする
setopt no_beep
# カッコの対応などを自動的に補完する
setopt auto_param_keys
# bgプロセスの状態変化を即時に知らせる
setopt notify
# 8bit文字を有効にする
setopt print_eight_bit
# 終了ステータスが0以外の場合にステータスを表示する
setopt print_exit_value
# 上書きリダイレクトの禁止 echo foo > hoge ですでにhogeが存在する場合､書き込まないでエラーを吐く
setopt no_clobber
# 各コマンドが実行されるときにパスをハッシュに入れる
#setopt hash_cmds
# 範囲指定できるようにする
# 例 : mkdir {1..3} で フォルダ1, 2, 3を作れる
setopt brace_ccl
# コマンドラインがどのように展開され実行されたかを表示するようになる
# なにかしらの操作をするたび、あらゆる動作ログが出る
# setopt xtrace

#
## 実行したプロセスの消費時間が3秒以上かかったら
## 自動的に消費時間の統計情報を表示する。
REPORTTIME=3

## 「/」も単語区切りとみなす。
WORDCHARS=${WORDCHARS:s,/,,}

# プロンプト上でのコマンドなどのシンタックスハイライトを有効にする
[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] \
  && source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# デフォルトだとmainのみだけなので、他のシンタックスハイライトを有効にする
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

typeset -A ZSH_HIGHLIGHT_STYLES # Declare the variable
ZSH_HIGHLIGHT_STYLES[globbing]='fg=027' # 青の色が見にくいので見やすい青に
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=027' # 青の色が見にくいので見やすい青に

typeset -A ZSH_HIGHLIGHT_PATTERNS # Declare the variable
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red') # 注意が必要なコマンドの背景色を赤色にする

# 括弧のシンタックスハイライトの色を見やすい青系に
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=027,bold'

# コマンド入力中にサジェストを表示する
[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] \
  && source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

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
# %W    日付(mm/dd/yy)
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

# 補完候補にLS_COLORSと同じ色をつける
autoload -U colors ; colors ; zstyle ':completion:*' list-colors "${LS_COLORS}"

# zshのの利用可能な色の一覧表示
zsh_color(){
  for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15  ] && echo;done;echo"]"
}


# Prompt内で変数展開・コマンド置換・算術演算を実行する
setopt prompt_subst
# コピペしやすいようにコマンド実行後は右プロンプトを消す。
setopt transient_rprompt


PROMPT="%F{170}%n%f%F{027}@%f%F{green}%3m%f%F{039} %~ %f
%F{099}[${SHLVL}]%f%F{245}[%D{%y/%m/%d %H:%M:%S}]%f $ "

autoload -Uz is-at-least
autoload -Uz vcs_info

if is-at-least 4.3.11; then
  # 以下の3つのメッセージをエクスポートする
  #   $vcs_info_msg_0_ : 通常メッセージ用 (緑)
  #   $vcs_info_msg_1_ : 警告メッセージ用 (黄色)
  #   $vcs_info_msg_2_ : エラーメッセージ用 (赤)
  zstyle ':vcs_info:*' max-exports 3
  zstyle ':vcs_info:*' enable git svn hg bzr
  # zstyle ':vcs_info:*' formats "%F{green}[%r@%b][%S]"
  # zstyle ':vcs_info:*' actionformats '[%b|%a]'

  # 標準のフォーマット(git 以外で使用)
  # misc(%m) は通常は空文字列に置き換えられる
  zstyle ':vcs_info:*' formats '(%s)-[%b]'
  zstyle ':vcs_info:*' actionformats '(%s)-[%b]' '%m' '<!%a>'
  zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
  zstyle ':vcs_info:bzr:*' use-simple true

    # git 用のフォーマット
    # git のときはステージしているかどうかを表示
    zstyle ':vcs_info:git:*' formats '(%s)-[%b]' '%c%u %m'
    zstyle ':vcs_info:git:*' actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr "+"    # %c で表示する文字列
    zstyle ':vcs_info:git:*' unstagedstr "-"  # %u で表示する文字列

  # vcs_info関数を呼び出す。vcs情報はformatsで整形され vcs_info_msg_0_ に挿入される
  _vcs_precmd () { vcs_info }
  # 上の関数をプロンプト表示前に実行させる
  add-zsh-hook precmd _vcs_precmd
  RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

  # hooks 設定
  # git のときはフック関数を設定する

    # formats '(%s)-[%b]' '%c%u %m' , actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
    # のメッセージを設定する直前のフック関数
    # 今回の設定の場合はformat の時は2つ, actionformats の時は3つメッセージがあるので
    # 各関数が最大3回呼び出される。
    zstyle ':vcs_info:git+set-message:*' hooks \
                                            git-hook-begin \
                                            git-untracked \
                                            git-push-status \
                                            git-nomerge-branch \
                                            git-stash-count

    # フックの最初の関数
    # git の作業コピーのあるディレクトリのみフック関数を呼び出すようにする
    # (.git ディレクトリ内にいるときは呼び出さない)
    # .git ディレクトリ内では git status --porcelain などがエラーになるため
    function +vi-git-hook-begin() {
        if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
            # 0以外を返すとそれ以降のフック関数は呼び出されない
            return 1
        fi

        return 0
    }

    # untracked ファイル表示
    #
    # untracked ファイル(バージョン管理されていないファイル)がある場合は
    # unstaged (%u) に ? を表示
    function +vi-git-untracked() {
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if command git status --porcelain 2> /dev/null \
            | awk '{print $1}' \
            | command grep -F '??' > /dev/null 2>&1 ; then

            # unstaged (%u) に追加
            hook_com[unstaged]+='?'
        fi
    }

    # push していないコミットの件数表示
    #
    # リモートリポジトリに push していないコミットの件数を
    # pN という形式で misc (%m) に表示する
    function +vi-git-push-status() {
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if [[ "${hook_com[branch]}" != "master" ]]; then
            # master ブランチでない場合は何もしない
            return 0
        fi

        # push していないコミット数を取得する
        local ahead
        ahead=$(command git rev-list origin/master..master 2>/dev/null \
            | wc -l \
            | tr -d ' ')

        if [[ "$ahead" -gt 0 ]]; then
            # misc (%m) に追加
            hook_com[misc]+="(p${ahead})"
        fi
    }

    # マージしていない件数表示
    #
    # master 以外のブランチにいる場合に、
    # 現在のブランチ上でまだ master にマージしていないコミットの件数を
    # (mN) という形式で misc (%m) に表示
    function +vi-git-nomerge-branch() {
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if [[ "${hook_com[branch]}" == "master" ]]; then
            # master ブランチの場合は何もしない
            return 0
        fi

        local nomerged
        nomerged=$(command git rev-list master..${hook_com[branch]} 2>/dev/null | wc -l | tr -d ' ')

        if [[ "$nomerged" -gt 0 ]] ; then
            # misc (%m) に追加
            hook_com[misc]+="(m${nomerged})"
        fi
    }


    # stash 件数表示
    #
    # stash している場合は :SN という形式で misc (%m) に表示
    function +vi-git-stash-count() {
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        local stash
        stash=$(command git stash list 2>/dev/null | wc -l | tr -d ' ')
        if [[ "${stash}" -gt 0 ]]; then
            # misc (%m) に追加
            hook_com[misc]+=":S${stash}"
        fi
    }
fi

function _update_vcs_info_msg() {
    local -a messages
    local prompt

    LANG=en_US.UTF-8 vcs_info

    if [[ -z ${vcs_info_msg_0_} ]]; then
        # vcs_info で何も取得していない場合はプロンプトを表示しない
        prompt=""
    else
        # vcs_info で情報を取得した場合
        # $vcs_info_msg_0_ , $vcs_info_msg_1_ , $vcs_info_msg_2_ を
        # それぞれ緑、黄色、赤で表示する
        [[ -n "$vcs_info_msg_0_" ]] && messages+=( "%F{green}${vcs_info_msg_0_}%f" )
        [[ -n "$vcs_info_msg_1_" ]] && messages+=( "%F{yellow}${vcs_info_msg_1_}%f" )
        [[ -n "$vcs_info_msg_2_" ]] && messages+=( "%F{red}${vcs_info_msg_2_}%f" )

        # 間にスペースを入れて連結する
        prompt="${(j: :)messages}"
    fi

    RPROMPT="$prompt"
}
add-zsh-hook precmd _update_vcs_info_msg

# -----------------------------
# History
# -----------------------------
# 基本設定
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

# ヒストリーに重複を表示しない
setopt histignorealldups
# 他のターミナルとヒストリーを共有
setopt share_history
# すでにhistoryにあるコマンドは残さない
setopt hist_ignore_all_dups
# historyに日付を表示
alias h='fc -lt '%F %T' 1'
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
# 履歴をすぐに追加する
setopt inc_append_history
# ヒストリを呼び出してから実行する間に一旦編集できる状態になる
# setopt hist_verify
#余分なスペースを削除してヒストリに記録する
setopt hist_reduce_blanks
# historyコマンドは残さない
setopt hist_save_no_dups

# -----------------------------
# functions
# -----------------------------
# 関数の読み込み
[ -f ~/.read_conf/functions ] && source ~/.read_conf/functions

# 補完ファイルの再読み込みプラグインの読み込み
if [ -d ~/.zsh/zload/ ]; then
  fpath=(~/.zsh/zload(N-/) $fpath)
  autoload -Uz zload
  # zsh-completion-generatorとzloadの組み合わせで1コマンドで補完を生成し読み込む
  gcomp(){
    gencomp $@
    zload $GENCOMPL_FPATH/_*
  }

  gcomp_all(){
    for p in $path; do command -p ls $p; done |\
        uniq |\
        { while read c; do gencomp $c; done }
    zload $GENCOMPL_FPATH/_*
  }
fi

# -----------------------------
# Completion
# -----------------------------
# 補完ファイルの読み込み
if [ -e ~/.zsh/completions ]; then
  fpath=(~/.zsh/completions $fpath)
fi
if [ -e ~/.zsh/zsh-completions/src ]; then
  fpath=(~/.zsh/zsh-completions/src $fpath)
fi
# getoptスタイルのヘルプテキストから補完関数を自動的に生成するプラグイン
if [ -f ~/.zsh/zsh-completion-generator/zsh-completion-generator.plugin.zsh ]; then
  export GENCOMPL_FPATH=$HOME/.zsh/zsh-completion-generator/generation_completion/ # 生成先
  source ~/.zsh/zsh-completion-generator/zsh-completion-generator.plugin.zsh
fi

# fzfのAuto-completion
[[ $- == *i* ]] && source "$HOME/bin/.fzf/shell/completion.zsh" 2> /dev/null

# 自動補完を有効にする
# これはほかの補完ファイルを読み込んだ後に実行しないと意味がない
if [ $(uname -r | grep -i microsoft) ] ; then
  # wslの場合あまりにも遅いので補完ファイルのセキュアリードオプションを無効化する
  autoload -Uz compinit ; compinit -C
else
  autoload -Uz compinit ; compinit
fi

# 単語の入力途中でもTab補完を有効化
setopt complete_in_word
# コマンドミスを修正
setopt correct
# コマンドライン全てのスペルチェックをする
setopt correct_all
# 補完候補が複数ある時、一覧表示 (auto_list) せず、すぐに最初の候補を補完する
setopt menu_complete # 強制で最初のが選択されるのが使いづらいので無効化
# 補完候補をできるだけ詰めて表示する
setopt list_packed
# 補完候補にファイルの種類も表示する(ls -Fの記号)
setopt list_types
# --prefix=/usr などの = 以降でも補完
setopt magic_equal_subst
## カッコの対応などを自動的に補完
setopt auto_param_keys
## 補完時にヒストリを自動的に展開する。
setopt hist_expand
## 辞書順ではなく数字順に並べる。
setopt numeric_glob_sort
# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
# ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt mark_dirs
# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments
# 明確なドットの指定なしで.から始まるファイルをマッチ
setopt globdots
# aliasを展開して補完を行う
setopt no_complete_aliases
# aliasが展開されていない状態で補完を行う
# setopt complete_aliases

# コマンドが間違えている時の指摘時の表示を変更
SPROMPT="correct: $RED%R$DEFAULT -> $GREEN%r$DEFAULT ? [No/yes/abort/edit] => "

# 補完キー連打で順に補完候補を自動で補完
# select=2: 補完候補を一覧から選択する。
#           ただし、補完候補が2つ以上なければすぐに補完する。
zstyle ':completion:*' menu select=2
# 補完候補を表示したときに続けてキーを入力するとインタラクティブに絞り込む
# setopt menu_completeが必要
# zstyle ':completion:*' menu select interactive
# キャッシュの利用による補完の高速化
zstyle ':completion::complete:*' use-cache true
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# 大文字・小文字を区別しない(大文字を入力した場合は区別する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# manの補完をセクション番号別に表示させる
zstyle ':completion:*:manuals' separate-sections true
# 補完候補の候補のセパレートを変更
zstyle ':completion:*' list-separator '-->'
# 詳細な情報を使う。
zstyle ':completion:*' verbose yes
# 補完時のメッセージの色設定
zstyle ':completion:*:descriptions' format $GREEN'completing %B%d%b'$DEFAULT
zstyle ':completion:*:messages' format $LIGHTBLUE'%d'$DEFAULT
zstyle ':completion:*:corrections' format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
zstyle ':completion:*:warnings' format $RED'No matches for:'$YELLOW' %d'$DEFAULT
## 補完方法毎にグループ化する。
### 補完方法の表示方法
###   %B...%b: 「...」を太字にする。
###   %d: 補完方法のラベル
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
# cd ../の時に今いるディレクトリを補完候補から外す
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
#kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

# -----------------------------
# KeyBind
# -----------------------------
# エディタをvimに設定
export EDITOR=vim
bindkey -d  # いったんキーバインドをリセット
bindkey -e  # emacsモードで使う
# bindkey -a  # vicmdモード
# bindkey -v # viinsモード

bindkey '\C-j' backward-word
bindkey '\C-g' forward-word
# esc+hで単語単位での削除
bindkey 'h' vi-backward-kill-word

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# fzfのKey bindings
source "$HOME/bin/.fzf/shell/key-bindings.zsh"

# 補完候補のメニュー選択で、矢印キーの代わりにhjklで移動出来るようにする。
zmodload zsh/complist
#bindkey -M menuselect '^i' vi-backward-char # 左
bindkey -M menuselect '^h' vi-backward-char # 左 これが動作しない
bindkey -M menuselect '^j' vi-down-line-or-history # 下
bindkey -M menuselect '^k' vi-up-line-or-history # 上
bindkey -M menuselect '^l' vi-forward-char # 右

bindkey -M menuselect '^n' vi-forward-char # 右
bindkey -M menuselect '^p' vi-backward-char # 左

bindkey -M menuselect '^r' history-incremental-search-forward # 補完候補内インクリメンタルサーチ

# ctrl+hでmenuselectで左に動けず、削除をしてしまう問題への対策を研究中
# tty -s && stty erase undef #ttyのctrl+hを無効化 その代わりvim上でbackspaceが効かない
# bindkey -r '^h' # zshのctrl+hを無効化

# -----------------------------
# ディレクトリ移動関係
# -----------------------------
# パスの最後のスラッシュを削除しない
setopt noautoremoveslash
# cdで移動してもpushdと同じようにディレクトリスタックに追加する。
setopt auto_pushd
# ディレクトリスタックへの追加の際に重複させない
setopt pushd_ignore_dups
# ディレクトリ名の入力のみで移動する
setopt auto_cd
#移動先がシンボリックリンクならば実際のディレクトリに移動する
setopt chase_links
#パスに..が含まれる シンボリックリンクではなく実際のディレクトリに移動
setopt chase_dots
#引数なしでpushdするとpushd $HOMEとして実行
setopt pushd_to_home
# cdで移動後に省略lsを実行する(10行を超える内容の時lsの表示内容を前後10行だけに絞る)
chpwd() { ls_abbrev }
# cdを移動を便利にするenhancdを追加
# compinitのあとでないとcomdefのエラーを吐く
if [ -f ~/.zsh/enhancd/init.sh ]; then
  source ~/.zsh/enhancd/init.sh
fi

# 現在のディレクトリがgitリポジトリの時そのディレクトリのrootへ移動する
if [ -d ~/.zsh/cd-gitroot/ ]; then
  fpath=(~/.zsh/cd-gitroot(N-/) $fpath)
  autoload -Uz cd-gitroot
  alias cdu='cd-gitroot'
fi

# -----------------------------
# プラグインによる機能追加
# -----------------------------
# gomiコマンドでゴミ箱に移動するプラグイン
if [ -f ~/.zsh/zsh-gomi/gomi.zsh ]; then
  source ~/.zsh/zsh-gomi/gomi.zsh
fi

# -----------------------------
# alias
# -----------------------------
# aliasの読み込み
[ -f ~/.read_conf/alias ] && source ~/.read_conf/alias

# それぞれのaliasに対応
# setopt no_complete_aliasesでalisaを展開したあととして補完が対応できるはずだが
# alias sg='sudo git -c xxxx'を展開すると-あとのパラメータの補完ができない
# そのためaliasに関数を紐付けることで補完が効くようにする
# compinitのあとでないとcomdefのエラーを吐く
compdef sudo_git=git

# zshのglobal alias
alias -g L='| less'
alias -g H='| head'
alias -g G='| grep'
alias -g GI='| grep -ri'
alias -g S='sudo '

# グローバルエイリアスを展開する
# http://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html
globalias() {
  if [[ $LBUFFER =~ '[A-Z0-9]+$' ]]; then
    zle _expand_alias
    # zle expand-word
  fi
  zle self-insert
}
zle -N globalias
bindkey " " globalias

# zshの起動処理の速度調査のスクリプト実行時に表示する設定
if (which zprof &> /dev/null) ;then
  zprof | less
fi

