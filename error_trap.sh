#!/bin/bash


# 使用方法
# # エラートラップ開始
# . ./error_trap.sh
# 上記以降に記載する
# 上記を記載するのならset -eは不要

onerror()
{
  status=$?
  case $status in
    # 正常終了であるためここで終わる
    [0]*) exit 0;;
  esac

    script=$0
    line=$1
    shift

    args=
    for i in "$@"; do 
        args+="\"$i\" "
    done

    echo ""
    echo "------------------------------------------------------------"
    echo "Error occured on $script [Line $line]: Status $status"
    echo ""
    echo "PID: $$"
    # echo "User: $USER"
    echo "Current directory: $PWD"
    echo "Command line: $script $args"
    echo "------------------------------------------------------------"
    echo ""
    read -p " Enter to close:"
}

begintrap()
{
    set -Eu
    # set -u の未定義の変数利用を止めるのをトラップで捕まえることはできないみたい
    # trap 'onerror $LINENO "$@"' ERR 3

    # set -uのエラーをキャッチできないのでExitをトリガーにする
    trap 'onerror $LINENO "$@"' EXIT
}

begintrap
