#!/bin/bash
THIS_SCRIPT_PATH=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
# PROJECT_PATHなどのsetup時の環境変数の読み込みを行う
source $THIS_SCRIPT_PATH/../setup_env.sh


\cp $THIS_SCRIPT_PATH/.gitconfig ~/

# .gitconfig.localが存在しない場合に生成する
if [ ! -e "${HOME}/.gitconfig.local" ]; then
  echo '###       .gitconfig.localがないので作成します。                            ###'

    cat <<EOF > "${HOME}/.gitconfig.local"
[user]
    name = 53JIlLenWe11
    email = ruin.of.messger@gmail.com
[core]
    autocrlf = input
EOF

  if [ `os_type` == 'linux' ]; then
      cat <<EOF >> "${HOME}/.gitconfig.local"
[credential]
  # helper = store # PWが平文で$HOME配下に保存されるので注意 cacheの方を推奨
  # 認証情報が一定の間だけlinuxのメモリーに記憶されます timeoutに設定された秒数の間だけ記憶する
    helper = cache --timeout=36000  # 36000=10時間 デフォは15分
EOF
  elif [ `os_type` == 'wsl' ]; then
      cat <<EOF >> "${HOME}/.gitconfig.local"
[credential]
    helper = store # PWが平文で$HOME配下に保存されるので注意 cacheの方を推奨
  # 認証情報が一定の間だけlinuxのメモリーに記憶されます timeoutに設定された秒数の間だけ記憶する
  # helper = cache --timeout=36000  # 36000=10時間 デフォは15分
EOF
  elif [ `os_type` == 'cygwin' ]; then
    cat <<EOF >> "${HOME}/.gitconfig.local"
[credential]
    helper = wincred
EOF
  else
    echo '###       Your platform ($(uname -a)) is not supported.                     ###'
  fi
fi

exit $?