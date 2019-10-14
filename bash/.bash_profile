# 共通環境変数のファイルの読み込み
[ -f ~/.config/shell_common/env.bash ] && source ~/.config/shell_common/env.bash

export PATH
unset USERNAME

# bashにてベルを鳴らさないようする
# (コマンドラインのインターフェイスをbashとは別にコントロールをする
#「readline」が組み込まれている場合は.inputrcに設定が必要)
set bell-style audible

# 起動時に自動実行されるスクリプト
[ -f ~/.config/shell_common/startup.bash ] && source ~/.config/shell_common/startup.bash

[ -f ~/.config/shell_common/check_update.bash ] && source ~/.config/shell_common/check_update.bash

# Get the aliases and functions
if [ -f ~/.bashrc ] ; then
  # bashファイルの即時反映
  source ~/.bashrc
fi

