# User specific environment and startup programs
PATH=$PATH:$HOME/bin

export PATH
unset USERNAME

# bashにてベルを鳴らさないようする
# (コマンドラインのインターフェイスをbashとは別にコントロールをする
#「readline」が組み込まれている場合は.inputrcに設定が必要)
set bell-style audible

[ -f ~/.read_conf/.check_update ] && source ~/.read_conf/.check_update

# Get the aliases and functions
if [ -f ~/.bashrc ] ; then
  # bashファイルの即時反映
  source ~/.bashrc
fi

