# Soource global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# bashでコマンド補完を有効にするためのshellの読み込み処理
COMP_PATH=$HOME/.bash_source_sh/
for f in `\find ${COMP_PATH} -maxdepth 1 -type f `; do
  source $f
done

__git_complete g __git_main # g 1文字のあとでもgitの補完を有効に
__git_complete sg __git_main # g 1文字のあとでもgitの補完を有効に
# 残りのgitのaliasの補完はファイルに直接記載
# dockerのコマンド補完を有効にするためのshell
complete -F _docker_compose dc # dc のあとでもdocker-composeの補完を有効に
complete -F _docker_compose sdc # sdc のあとでもdocker-composeの補完を有効に

complete -F _docker d # d 1文字のあとでもdockerの補完を有効に
complete -F _docker sd # sd 1文字のあとでもdockerの補完を有効に
complete -cf sudo # sudo入力中にコマンド補完ができるようにする

# tmux上でも256色に対応するための設定
export TERM=xterm-256color

# ls --color=autoで緑背景の一部が見にくいので文字色を変更
eval `dircolors ~/.colorrc`

# User specific aliases and functions
stty stop undef # Ctrl+sでLinuxのターミナルへの出力をロックする機能があるのでそれを無効化する(一応Ctrl+qで抜けれる)

# [Prompt]
BLACK='\[\e[30;40m\]'
RED='\[\e[31;40m\]'
GREEN='\[\e[32;40m\]'
YELLOW='\[\e[33;40m\]'
BLUE='\[\e[34;40m\]'
PURPLE='\[\e[35;40m\]'
CYAN='\[\e[36;40m\]'
LIGHT_GLAY='\[\e[37;40m\]'
DARK_GLAY='\[\e[90;40m\]'
LIGHT_RED='\[\e[91;40m\]'
LIGHT_GREEN='\[\e[92;40m\]'
LIGHT_YELLOW='\[\e[93;40m\]'
LIGHT_BLUE='\[\e[94;40m\]'
LIGHT_PURPLE='\[\e[95;40m\]'
LIGHT_CYAN='\[\e[96;40m\]'
WHITE='\[\e[97;40m\]'
RESET='\[\e[0m\]'

# Based Bash Profile Generator
# http://xta.github.io/HalloweenBash/
# 16color
export PS1="$DARK_GLAY[\D{%Y/%m/%d} \t] $LIGHT_PURPLE\u$LIGHT_BLUE@$GREEN\H\n$RESET $CYAN\w $LIGHT_GLAY\$(parse_git_branch) $LIGHT_BLUE\$ $RESET"

function parse_git_branch {
        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# cd省略してのディレクトリ移動を行う
shopt -s autocd

# bashコマンド
alias v='vim'
alias vi='vim'
alias ls='ls -AXFh --group-directories-first --color=auto'
alias ll='ls -AlXFh --group-directories-first --color=auto'
alias cp='cp -i'        # -i    コピー時に上書きされるファイルがある場合、確認が入る。
alias mv='mv -i'        # -i    移動時に上書きされるものがある場合、確認が入る。
alias rm='rm -i'        # -i    ファイルの削除前に確認が入る。
alias sudo='sudo '
alias sudovim='sudo_vim'
alias sudovi='sudo_vim'
alias hg='history | grep'
alias lessf='less -N+F'

# gitコマンド
alias g='git'
alias gad='git add'
alias gada='git add -A'
alias gb='git branch'
alias gba='git branch -a'           # originも含めた全てのbranchを表示
alias gbm='git branch --merged'     # merge済みのbranchを表示
alias gbn='git branch --no-merged'  # mergeしてないbranchを表示
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gft='git fetch'
alias gpl='git pull'
alias gps='git push'
alias gsh='git show'
alias gst='git status'
alias gr='git reset'

alias gh1='HEAD~'            # HEADから0つ前
alias gh2='HEAD~~'           # HEADから2つ前
alias gh3='HEAD~~~'          # HEADから3つ前
alias gh4='HEAD~~~~'         # HEADから4つ前
alias gh5='HEAD~~~~~'        # HEADから5つ前
alias gh10='HEAD~~~~~~~~~~'

alias gdf='git diff'
alias gdc='git diff --cached'  # addされているものとのdiff
alias gds='git diff --staged'  # 同上(1.6.1移行)
alias gd='git diff HEAD'       # HEADとdiff
alias gd1='git diff gh1'       # HEADから1つ前とdiff
alias gd2='git diff gh2'       # HEADから2つ前とdiff
alias gd3='git diff gh3'       # HEADから3つ前とdiff
alias gd4='git diff gh4'       # HEADから4つ前とdiff
alias gd5='git diff gh5'       # HEADから5つ前とdiff
alias gd10='git diff gh10'     # HEADから10前とdiff

alias glo='git log'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias gla="git log --graph --all --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
galias() { alias | grep "'git "  | sed "s/^\([^=]*\)='\(.*\)'/\1    => \2/"| sed "s/'\\\'//g"; }

# sudo gitコマンド
alias sg='sudo git'
alias sgad='sg add'
alias sgada='sg add -A'
alias sgb='sg branch'
alias sgba='sg branch -a'           # originも含めた全てのbranchを表示
alias sgbm='sg branch --merged'     # merge済みのbranchを表示
alias sgbn='sg branch --no-merged'  # mergeしてないbranchを表示
alias sgc='sg commit'
alias sgcm='sg commit -m'
alias sgco='sg checkout'
alias sgft='sg fetch'
alias sgpl='sg pull'
alias sgps='sg push'
alias sgsh='sg show'
alias sgst='sg status'
alias sgr='sg reset'

alias sgdf='sg diff'
alias sgdc='sg diff --cached'  # addされているものとのdiff
alias sgds='sg diff --staged'  # 同上(1.6.1移行)
alias sgd='sg diff HEAD'       # HEADとdiff
alias sgd1='sg diff gh1'       # HEADから1つ前とdiff
alias sgd2='sg diff gh2'       # HEADから2つ前とdiff
alias sgd3='sg diff gh3'       # HEADから3つ前とdiff
alias sgd4='sg diff gh4'       # HEADから4つ前とdiff
alias sgd5='sg diff gh5'       # HEADから5つ前とdiff
alias sgd10='sg diff gh10'     # HEADから10前とdiff

alias sglo="sg log"
alias sgl="sg log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias sgla="sg log --graph --all --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

# gitのaliasに補完を行うようにする
for a in $(alias | sed -n 's/^alias \(g[^=]*\)=.git .*/\1/p'); do
  c=$(alias $a | sed 's/^[^=]*=.git \([a-z0-9\-]\+\).*/\1/' | tr '-' '_')
  if set | grep -q "^_git_$c *()"; then
    eval "__git_complete $a _git_$c"
  fi
done

# sudo gitのaliasに補完を行うようにする
for a in $(alias | sed -n 's/^alias \(sg[^=]*\)=.sg .*/\1/p'); do
  c=$(alias $a | sed 's/^[^=]*=.sg \([a-z0-9\-]\+\).*/\1/' | tr '-' '_')
  if set | grep -q "^_git_$c *()"; then
    eval "__git_complete $a _git_$c"
  fi
done

# ------------------------------------
# Docker aliases
# ------------------------------------
alias d="docker"
alias dc="docker-compose"
alias sd="sudo docker"
alias sdc="sudo docker-compose"

### docker container
# List containers  old:docker ps
alias dl="docker container ls"
# List containers including stopped containers
alias da="docker container ls --all"
# Get the latest container ID  old:docker ps --latest --quiet
alias dlate="dl --latest --quiet"

### docker image
# List images  old:docker ps
alias dil="docker image ls"
# List images including intermediates
alias dia="docker image ls --all"
# Get the latest image ID
alias dilate="dil | head -n 2 | tail -n 1 | awk '{print \$3}'"

# Get an IPaddress of a container
alias dip="docker container inspect --format '{{ .NetworkSettings.IPAddress }}'"
# Run a daemonized container
alias drd="docker container run --detach"
# Run a daemonized container   --publish-all    Publish all exposed ports to random ports
alias drdpa="docker container run --detach --publish-all"
# Run an interactive container
alias drit="docker container run --interactive --tty --publish-all"
# docker container in bash exec
alias de="docker_exec"

### docker remove command
# Remove container id argment or latest container
alias drm='docker_container_remove'
# Remove image id argment or latest image
alias dirm='docker_image_remove'
# Remove all containers  old:docker rm $(docker ps --all --quiet)
alias drma='docker container rm $(da --quiet)'
# Remove all images  old:docker rmi $(docker images --quiet)
alias dirma='docker image rm $(dia --quiet)'
# Remove all containers and images by force
alias dclean='docker container kill $(da --quiet); drma; dirma;'

# is me add docker group  don't need sudo docker command
alias dockerGroupAdd='docker_group_add'
# List all aliases relating to docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)='\(.*\)'/\1    => \2/"| sed "s/'\\\'//g"; }
# docker image all update
alias diupdate="sudo docker images | cut -d ' ' -f1 | tail -n +2 | sort | uniq | egrep -v '^(<none>|ubuntu)$' | xargs -P0 -L1 sudo docker pull"

docker_group_add(){
  sudo groupadd docker # dockerグループを作成
  sudo gpasswd -a $USER docker # 自身をdocker gruopに追加 sudo 不要になる
  sudo systemctl restart docker # dockerの再起動
  echo "グループ適用のためログアウトします｡"
  exit
}

docker_container_remove(){
  if [ "$1" = "" ]
    # 引数なしの場合一番新しいのを削除
    docker container rm $(dlate)
  then
    docker container rm $1
  fi
}

docker_image_remove(){
  if [ "$1" = "" ]
    # 引数なしの場合一番新しいのを削除
    docker image rm $(dilate)
  then
    docker image rm $1
  fi
}

docker_exec() {
  if [ "$1" = "" ]
    # 引数なしの場合一番新しいイメージの中に入る
    docker container exec -it $(dlate) /bin/bash
  then
    docker container exec -it $1 /bin/bash
  fi
}

#---------------------------------------------------------------
# cd autocd pushd popd でディレクトリ移動したら自動でlsコマンドを実行
# https://qiita.com/uplus_e10/items/c58ab78e062218dc4eda
#---------------------------------------------------------------
autols(){
  [[ -n $AUTOLS_DIR ]] && [[ $AUTOLS_DIR != $PWD ]] && ls
  # 複数回表示しないようにパスをキャッシュ
  AUTOLS_DIR="${PWD}"
}

# PROMPT_COMMAND="dispatch"で実行適用される(複数適用のためにこのPROMPT_COMMAND_****の環境変数を使う)
export PROMPT_COMMAND_AUTOLS="autols"

#---------------------------------------------------------------
# sudo.vim プラグインのエイリアス
#---------------------------------------------------------------
function sudo_vim {
        \vim sudo:$1
}

#---------------------------------------------------------------
# [History]
# Share bash_history bitween TTY
# http://iandeth.dyndns.org/mt/ian/archives/000651.html
#---------------------------------------------------------------
function share_history {  # 以下の内容を関数として定義
    history -a  # .bash_historyに前回コマンドを1行追記
    history -c  # 端末ローカルの履歴を一旦消去
    history -r  # .bash_historyから履歴を読み込み直す
}

# PROMPT_COMMAND="dispatch"で実行適用される(複数適用のためにこのPROMPT_COMMAND_****の環境変数を使う)
export PROMPT_COMMAND_SHARE_HISTORY='share_history'  # 上記関数をプロンプト毎に自動実施
shopt -u histappend   # .bash_history追記モードは不要なのでOFFに
export HISTSIZE=9999  # 履歴のMAX保存数を指定
# Set timestamp
HISTTIMEFORMAT='%y/%m/%d %H:%M:%S  '

#---------------------------------------------------------------
# 特定のある列だけを取り出す col 2 これで2列目を取り出す 例)git statu -s | col 2
#---------------------------------------------------------------
function col {
  awk -v col=$1 '{print $col}'
}

#---------------------------------------------------------------
# 取り出した結果の最初はタイトル行だから不要飛ばす 例)docker rmi $(docker images | col 3 | xargs | skip 1)
#---------------------------------------------------------------
function skip {
    n=$(($1 + 1))
    cut -d' ' -f$n-
}

#---------------------------------------------------------------
# PROMPT_COMMANDを複数適用し、.bashrcの再読読み込みなどした後にコマンドが重複しないために
# ディスパッチと複数コマンドの再適用処理
# https://qiita.com/tay07212/items/9509aef6dc3bffa7dd0c
#---------------------------------------------------------------
dispatch () {
  export EXIT_STATUS="$?" # 直前のコマンド実行結果のエラーコードを保存

  local f
  for f in ${!PROMPT_COMMAND_*}; do #${!HOGE*}は、HOGEで始まる変数の一覧を得る
    eval "${!f}" # "${!f}"は、$fに格納された文字列を名前とする変数を参照する（間接参照）
  done
  unset f
}
# 新しいプロンプトが表示される前に実行されるコマンド
export PROMPT_COMMAND="dispatch"

#---------------------------------------------------------------
# SSHログイン時にtmuxを自動で開くようにする
#---------------------------------------------------------------
SESSION_NAME=ope

if [[ -z "$TMUX" && -z "$STY" ]] && type tmux >/dev/null 2>&1; then
  option=""
  if tmux has-session -t ${SESSION_NAME}; then
    option="attach -t ${SESSION_NAME}"
  else
    option="new -s ${SESSION_NAME}"
  fi
  tmux $option && exit
fi
#■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
# tmuxのhostごとにstatus lineの色を変える
if ! [ "$TMUX" = "" ]; then
    tmux set-option status-bg $(perl -MList::Util=sum -e'print+(red,green,blue,yellow,cyan,magenta,white)[sum(unpack"C*",shift)%7]' $(hostname)) | cat > /dev/null
fi

