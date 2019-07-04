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
\cp config/.gitconfig ~/

# bashでgitの補完を有効にするためのshell script
\cp -r .bash_source_sh/ ~/
# dein.vimのPluginファイルのコピー
\cp -r .vim ~/
# 自身の独自コマンド実行ファイルをコピー
\cp -r bin ~/

if [ "${OS}" == 'Linux' ] ; then
  echo "OS Linux!!"
  \cp config/.tmux.conf ~/.tmux.conf
  # \cp config/.gitignore ~/
  # \cp config/ssh_config ~/.ssh/config
fi

echo ' '
echo '###############################################################################'
echo '###                             COMPLITE.                                   ###'
echo '###############################################################################'

if [ ! -e "${HOME}/.gitconfig.local" ]; then
  echo -n -e ".gitconfig.localがないので一度作成してください。\n.gitconfigに記載例が載っています。\n"
  read -p " Enter to close:"
fi
