#!/bin/bash
echo '###     bash init start                                                     ###'
if [ -z $PROJECT_PATH ]; then
  # PROJECT_PATHなどのsetup時の環境変数の読み込みを行う
  local THIS_SCRIPT_PATH=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
  source $THIS_SCRIPT_PATH/../setup_env.sh
fi

# \cp config/.bash_profile ~/
# \cp config/.zprofile ~/
# \cp config/.bashrc ~/
# \cp config/.zshrc ~/
# \cp config/.vimrc ~/
# \cp config/.gvimrc ~/
# \cp config/.inputrc ~/
# \cp config/.gitconfig ~/

# # bashでgitの補完を有効にするためのshell script
# \cp -r .bash/ ~/
# # aliasなどzshとbashで共通できるもの
# \cp -r config/.read_conf/ ~/
# # dein.vimのPluginファイルのコピー
# \cp -r .vim ~/
# # zshのファイルをコピー
# \cp -r .zsh ~/
# # 自身の独自コマンド実行ファイルをコピー
# \cp -rp bin ~/

# if [ "${OS}" = 'Linux' ]; then
#   echo "OS Linux!!"
#   \cp config/.tmux.conf ~/.tmux.conf
#   # \cp config/.gitignore ~/
#   # \cp config/ssh_config ~/.ssh/config
#   if [ type fish &>/dev/null ]; then
#     \cp -r .config/ ~/
#   fi
# fi


# if [ ! -e "${HOME}/.gitconfig.local" ]; then
#   echo -n -e ".gitconfig.localがないので作成します。\n"

#     cat <<EOF > "${HOME}/.gitconfig.local"
# [user]
#     name = 53JIlLenWe11
#     email = ruin.of.messger@gmail.com
# [core]
#     autocrlf = input
# EOF

#   if [ "${OS}" == 'Linux' ] ; then
#     if [ $(uname -r | grep -i microsoft) ] ; then
#       echo "wsl git credential"
#       cat <<EOF >> "${HOME}/.gitconfig.local"
# [credential]
#     helper = store # PWが平文で$HOME配下に保存されるので注意 cacheの方を推奨
#   # 認証情報が一定の間だけlinuxのメモリーに記憶されます timeoutに設定された秒数の間だけ記憶する
#   # helper = cache --timeout=36000  # 36000=10時間 デフォは15分
# EOF
#     else
#       echo "linux git credential"
#       cat <<EOF >> "${HOME}/.gitconfig.local"
# [credential]
#   # helper = store # PWが平文で$HOME配下に保存されるので注意 cacheの方を推奨
#   # 認証情報が一定の間だけlinuxのメモリーに記憶されます timeoutに設定された秒数の間だけ記憶する
#     helper = cache --timeout=36000  # 36000=10時間 デフォは15分
# EOF
#     fi
#   elif [ "${OS}" == 'Cygwin' ]; then
#     echo "windows git credential"
#     cat <<EOF >> "${HOME}/.gitconfig.local"
# [credential]
#     helper = wincred
# EOF

#   else
#     echo "Your platform ($(uname -a)) is not supported."
#   fi
# fi

echo ' '
echo '###############################################################################'
echo '###                             COMPLITE.                                   ###'
echo '###############################################################################'
