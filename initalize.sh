#!/bin/bash

# エラートラップ開始
. ./error_trap.sh

echo '###############################################################################'
echo '### symbolic link                                                           ###'
echo '###       ./config/.*                                                       ###'
echo '###                        TO YOUR HOME DIRECTORY.                          ###'
echo '###############################################################################'

DOTPATH=~/dotfiles/config

for f in `\find ./config/ -name .\* -type f -printf '%f\n'`; do
    echo "ln :$DOTPATH/$f $HOME/$f"
    [ "$f" = ".git" ] && continue

    ln -snfv "$DOTPATH/$f" "$HOME"/"$f"
done

# # dein.vimのPluginファイルのコピー
\cp -r .vim ~/


 echo ' '
 echo '###############################################################################'
 echo '###                             COMPLITE.                                   ###'
 echo '###############################################################################'

