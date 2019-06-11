#!/bin/bash

# エラートラップ開始
. ./error_trap.sh

echo '###############################################################################'
echo '### COPY .bash_profile .bashrc .vimrc .gitconfig .gitignore .colorrc        ###'
echo '###  .vim/bundle/ .ssh/config             TO YOUR HOME DIRECTORY.           ###'
echo '###############################################################################'

# 実行OSの判定処理開始
if [ "$(uname)" == 'Darwin' ]; then
  OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  OS='Linux'
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
  OS='Cygwin'
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW64_NT' ]; then
  OS='Cygwin'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

\cp config/.bash_profile ~/
\cp config/.bashrc ~/
\cp config/.colorrc ~/
\cp config/.vimrc ~/
\cp config/.gvimrc ~/
\cp config/.inputrc ~/

# bashでgitの補完を有効にするためのshell script
\cp config/.git-completion.sh ~/.git-completion.sh
\cp config/.docker-completion.sh ~/.docker-completion.sh
\cp config/.docker-compose-completion.sh ~/.docker-compose-completion.sh

if [ "${OS}" == 'Linux' ] ; then
  echo "OS Linux!!"
  \cp config/.gitconfig ~/
  \cp config/.tmux.conf ~/.tmux.conf
  # \cp config/.gitignore ~/
  # \cp config/ssh_config ~/.ssh/config
fi

# dein.vimのPluginファイルのコピー
\cp -r .vim ~/

echo ' '
echo '###############################################################################'
echo '###                             COMPLITE.                                   ###'
echo '###############################################################################'

