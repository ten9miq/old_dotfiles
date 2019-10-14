#!/bin/bash
export PROJECT_PATH=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
source $PROJECT_PATH/error_trap.sh

true=0
false=1

# プロセスが実行中であるか
hasprocess() {
  if is_osx; then
    ps -fU$USER | grep $1 | grep -v grep > /dev/null 2>&1 && return $true || return $false
  else
    ps aux | grep $1 | grep -v grep > /dev/null 2>&1 && return $true || return $false
  fi
}

# file が存在し、かつそのサイズが 0 より大きければ真となります。
hasfile() {
  [[ -s $1 ]] && return $true || return $false
}

# 環境変数にあるか判定
hasenv() {
  [[ -z $1 ]] && return $false || return $true
}

# aliasに存在するか
hasalias() {
  : ${1:?}
  alias $1 && return $true || return $false
}

# パスに追加する
exist_expath() {
  [ -d $1 ] && expath $1
}

# パス追加処理
expath() {
  : ${1:?}
  export PATH=$1:$PATH
}

# 小文字化
lower() {
  printf "$1\n" | tr '[A-Z]' '[a-z]'
}

# パスの削除
rmpath() {
  export PATH=$(echo -n $PATH | awk -v RS=: -v ORS=: '$0 != "'$1'"' | sed 's/:$//')
}

# 実行OSの判定処理開始 小文字でOS名を返す
os_type() {
  if [[ "$(uname)" == 'Darwin' ]]; then
    lower 'Osx'
  elif [[ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]]; then
    if [ $(uname -r | grep -i microsoft) ] ; then
      lower 'WSL'
    else
      lower 'Linux'
    fi
  elif [[ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]]; then
    lower 'Cygwin'
  elif [ "$(expr substr $(uname -s) 1 10)" = 'MINGW64_NT' ]; then
    lower 'Cygwin'
  else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
  fi
}

is_osx() {
  [[ `os_type` == "osx" ]] && return $true || return $false
}

is_linux() {
  [[ `os_type` == "linux" ]] && return $true || return $false
}

is_wsl() {
  [[ `os_type` == "cygwin" ]] && return $true || return $false
}

is_cygwin() {
  [[ `os_type` == "cygwin" ]] && return $true || return $false
}

# コマンドが存在するかチェック 処理部分
is_exists() {
  which $1 > /dev/null 2>&1
  return $?
}

# コマンドが存在するかチェック
has() {
  is_exists "$@"
}

########################################################
# 動作中のログを表示する際に色をつけて表示する
########################################################
# 水色
run () {
  printf "\e[36m run\t: $1  \e[0m\n"
}

# 黄色
skip() {
  printf "\e[33m skip\t: $1  \e[0m\n"
}

# 紫色
log() {
  printf "\e[35m log\t: $1  \e[0m\n"
}

# 緑色
ok() {
  printf "\e[32m ok\t: $1  \e[0m\n"
}
# 赤色
error() {
  printf "\e[31m fail\t: $1  \e[0m\n"
}


logo='
    _______   ______   .___________. _______  __   __       _______     _______.
   |       \ /  __  \  |           ||   ____||  | |  |     |   ____|   /       |
   |  .--.  |  |  |  | `---|  |----`|  |__   |  | |  |     |  |__     |   (----`
   |  |  |  |  |  |  |     |  |     |   __|  |  | |  |     |   __|     \   \
 __|  `--`  |  `--`  |     |  |     |  |     |  | |  `----.|  |____.----)   |
(__)_______/ \______/      |__|     |__|     |__| |_______||_______|_______/
'

logo () {
  printf "$logo\n\n"
}