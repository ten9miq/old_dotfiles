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
  OS='other'
fi

if [ "$OS" == "Cygwin" ]; then
  LnOrCp="\cp -r"
else
  LnOrCp="ln -snfv"
fi

SCRIPT_DIR=$(cd $(dirname $0); pwd) # ソース実行場所のフルパス
DOTPATH="$SCRIPT_DIR/config"

for f in `\find ${DOTPATH} -maxdepth 1 -name .\* -type f  -printf '%f\n'`; do
    [ "$f" = ".git" ] && continue # リンクを作らない

   eval "${LnOrCp} ${DOTPATH}/$f $HOME/$f"
done

eval "${LnOrCp} ${DOTPATH}/.completion_sh/ ~"
# # dein.vimのPluginファイルのコピー
\cp -r .vim ~/

 echo ' '
 echo '###############################################################################'
 echo '###                             COMPLITE.                                   ###'
 echo '###############################################################################'

