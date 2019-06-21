# User specific environment and startup programs
PATH=$PATH:$HOME/bin

export PATH
unset USERNAME

# bashにてベルを鳴らさないようする
# (コマンドラインのインターフェイスをbashとは別にコントロールをする「readline」が組み込まれている場合は.inputrcに設定が必要)
set bell-style audible

# tmuxの実行時にdotfileの更新チェックが実行されないようにする処理
if [ -n "$TMUX" ]; then
  #何もしない
  :
else
  # loginの場合OS判定処理開始
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

  if [ "${OS}" == 'Linux' ] ; then
    # Linuxの場合~/dotfile/の更新がないかチェックし、更新あればgit pullしてsetup.shを実行する
    \cd dotfiles
    git fetch -p
    git checkout -q master
    latest_rev=$(git ls-remote origin HEAD | awk '{print $1}')
    current_rev=$(git rev-parse HEAD)
    if [ "$latest_rev" != "$current_rev" ]; then
      # 最新じゃない場合には更新処理を行う
      git reset --hard $(git log --pretty=format:%H | head -1)
      git pull
      # # dein.vimのPluginファイルのコピー
      \cp -r .vim ~/
    fi
    \cd -
  fi
fi

if [ -f ~/.bashrc ] ; then
  # 接続時に.bashrcの読み込みの実行
  source ~/.bashrc
fi
