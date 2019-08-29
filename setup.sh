#!/bin/bash

# エラートラップ開始
. ./error_trap.sh

echo '###############################################################################'
echo '### COPY .bash_profile .bashrc .vimrc .gitconfig .gitignore .colorrc        ###'
echo '###  .vim/bundle/ .ssh/config             TO YOUR HOME DIRECTORY.           ###'
echo '###############################################################################'

# 実行OSの判定処理開始
if [ "$(uname)" = 'Darwin' ]; then
  OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" = 'Linux' ]; then
  OS='Linux'
elif [ "$(expr substr $(uname -s) 1 10)" = 'MINGW32_NT' ]; then
  OS='Cygwin'
elif [ "$(expr substr $(uname -s) 1 10)" = 'MINGW64_NT' ]; then
  OS='Cygwin'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

\cp config/.bash_profile ~/
\cp config/.zprofile ~/
\cp config/.bashrc ~/
\cp config/.zshrc ~/
\cp config/.vimrc ~/
\cp config/.gvimrc ~/
\cp config/.inputrc ~/
\cp config/.gitconfig ~/

# bashでgitの補完を有効にするためのshell script
\cp -r .bash_source_sh/ ~/
# aliasなどzshとbashで共通できるもの
\cp -r config/.read_conf/ ~/
# dein.vimのPluginファイルのコピー
\cp -r .vim ~/
# zshのファイルをコピー
\cp -r .zsh ~/
# 自身の独自コマンド実行ファイルをコピー
\cp -r bin ~/

if [ "${OS}" = 'Linux' ] ; then
  echo "OS Linux!!"
  \cp config/.tmux.conf ~/.tmux.conf
  # \cp config/.gitignore ~/
  # \cp config/ssh_config ~/.ssh/config
fi


if [ ! -e "${HOME}/.gitconfig.local" ]; then
  echo -n -e ".gitconfig.localがないので作成します。\n"

    cat <<EOF > "${HOME}/.gitconfig.local"
[user]
    name = 53JIlLenWe11
    email = ruin.of.messger@gmail.com
[core]
    autocrlf = input
EOF

  if [ "${OS}" == 'Linux' ] ; then
    cat <<EOF >> "${HOME}/.gitconfig.local"
[credential]
    # 認証情報が一定の間だけlinuxのメモリーに記憶されます timeoutに設定された秒数の間だけ記憶する 
    helper = cache --timeout=36000  # 36000=10時間 デフォは15分
EOF

  elif [ "${OS}" == 'Cygwin' ]; then
    cat <<EOF >> "${HOME}/.gitconfig.local"
[credential]
    helper = wincred
EOF

  else
    echo "Your platform ($(uname -a)) is not supported."
  fi
fi

echo ' '
echo '###############################################################################'
echo '###                             COMPLITE.                                   ###'
echo '###############################################################################'
