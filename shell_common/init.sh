#!/bin/bash
echo '###     shell common init start                                             ###'
THIS_SCRIPT_PATH=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
if [ -z $PROJECT_PATH ]; then
  # PROJECT_PATHなどのsetup時の環境変数の読み込みを行う
  source $THIS_SCRIPT_PATH/../setup_env.sh
fi

\mkdir -p ~/.config
# # aliasなどzshとbashで共通できるもの
\cp -r $PROJECT_PATH/shell_common/ ~/.config/shell_common

echo '###     shell common init end                                               ###'