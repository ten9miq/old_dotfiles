#!/bin/bash

# エラートラップ開始
. ./error_trap.sh

echo '###############################################################################'
echo '### symbolic link                                                           ###'
echo '###       ./config/.*                                                       ###'
echo '###                        TO YOUR HOME DIRECTORY.                          ###'
echo '###############################################################################'

if [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
  OS='Cygwin'
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW64_NT' ]; then
  OS='Cygwin'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

DOTPATH=./config/

for f in `\find ${DOTPATH} -maxdepth 1 -name .\* -type f  -printf '%f\n'`; do
    # echo "ln : $DOTPATH/$f $HOME/$f"
    [ "$f" = ".git" ] && continue # リンクを作らない
    
    if [ "$OS" == "Cygwin" ]; then
        \cp "$DOTPATH/$f" $HOME/
        \cp -r "${DOTPATH}/.completion_sh/" $HOME/
    else
        ln -snfv "$DOTPATH/$f" "$HOME"/"$f"
    fi
done

# # dein.vimのPluginファイルのコピー
\cp -r .vim ~/


 echo ' '
 echo '###############################################################################'
 echo '###                             COMPLITE.                                   ###'
 echo '###############################################################################'

