#!/bin/bash
THIS_SCRIPT_PATH=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)
# PROJECT_PATHなどのsetup時の環境変数の読み込みを行う
source $THIS_SCRIPT_PATH/../setup_env.sh

\mkdir -p $THIS_SCRIPT_PATH/.config/
\cp -r $THIS_SCRIPT_PATH/fish ~/.config/

exit $?