# 共通環境変数のファイルの読み込み
[ -f ~/.read_conf/env ] && source ~/.read_conf/env

# User specific environment and startup programs
PATH=$PATH:$HOME/bin

export PATH
unset USERNAME

# bashにてベルを鳴らさないようする
# (コマンドラインのインターフェイスをbashとは別にコントロールをする
#「readline」が組み込まれている場合は.inputrcに設定が必要)
set bell-style audible


# 起動時に自動実行されるスクリプト
[ -f ~/.read_conf/startup ] && source ~/.read_conf/startup

[ -f ~/.read_conf/check_update ] && source ~/.read_conf/check_update

