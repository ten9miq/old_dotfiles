#!/bin/bash
echo '###############################################################################'
echo '###     All setup execute                                                   ###'
echo '###       use shell by bash zsh fish                                        ###'

# setup時に必要な環境変数やエラートラップの実行
source ./setup_env.sh
# echo $OS
# echo $PROJECT_PATH

source $PROJECT_PATH/shell_common/init.sh
# source $PROJECT_PATH/bash/init.sh
# source $PROJECT_PATH/zsh/init.sh


echo '###     COMPLITE.                                                           ###'
echo '###############################################################################'
