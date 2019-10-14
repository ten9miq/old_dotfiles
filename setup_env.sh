#!/bin/bash
echo '###     setup_env start                                                     ###'

echo '###        project env path set                                             ###'
export PROJECT_PATH=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

echo '###        error trap start                                                 ###'
source $PROJECT_PATH/error_trap.sh

echo '###        setup use env set                                                ###'

# 実行OSの判定処理開始
if [ "$(uname)" = 'Darwin' ]; then
  OS='mac'
elif [ "$(expr substr $(uname -s) 1 5)" = 'Linux' ]; then
  if [ $(uname -r | grep -i microsoft) ] ; then
    OS='wsl'
  else
    OS='linux'
  fi
elif [ "$(expr substr $(uname -s) 1 10)" = 'MINGW32_NT' ]; then
  OS='cygwin'
elif [ "$(expr substr $(uname -s) 1 10)" = 'MINGW64_NT' ]; then
  OS='cygwin'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

export OS=${OS}

echo '###     setup_env end                                                       ###'