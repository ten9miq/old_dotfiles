"*************************************************************
" メモ
" 問題
"     gvim(kaoriya版)のツールバーやquickfixで日本語が文字化けするときの対策
" 原因
"     fileencoding=UTF-8, fileformat=unixでファイルを開いているのに、quickfixウインドウは
"     fileencoding=cp932, fileformat=dosになってしまい、日本語が文字化けする。
" 解決方法
"     \$VIM/switches/catalog/utf-8.vim を、\$VIM/switches/enabled/utf-8.vim にコピーする。
"*************************************************************

set enc=utf-8
" ウィンドウの縦幅
set lines=70
" ウィンドウの横幅
set columns=120
" カラースキーム
colorscheme molokai
" ダーク系のカラースキームを使う
set background=dark
" フォントを設定
" set guifont=Myrica_M:h10:cSHIFTJIS
" set guifont=Ricty_Diminished:h10:cSHIFTJIS
set guifont=HackGen:h10:cSHIFTJIS:qDRAFT
set linespace=-1
" set guifontwide=Ricty_Diminished_Discord:h11
set renderoptions=type:directx
" Kaoriya Vim でヴィジュアルモード中にCtrl+CやCtrl+vを使えるようにする
" Ctrl+vで短形選択などのコマンドが使えないので無効化
" source $VIMRUNTIME/mswin.vim
" ドラッグ＆ドロップでファイルを開くとき、常に新しいタブで開く(ただし、複数同時には未対応)
" autocmd VimEnter * tab all
" autocmd BufAdd * exe 'tablast | tabe "' . expand( "<afile") .'"'
" gVim用とLinuxでのvimで空白の表示記号を使い分ける
" set listchars=tab:^\ ,trail:ᵤ,space:␣,eol:↲,extends:»,precedes:«,nbsp:⊔

" -------------------------------------------------
" IMEの状態に応じて色を変更
" -------------------------------------------------
if has('multi_byte_ime') || has('xim')
  highlight Cursor guifg=Black guibg=White
  highlight CursorIM guifg=NONE guibg=Red
endif
