" Specify a directory for plugins
let mapleader=","
set number
" 将tab设置为4个空格
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes
Plug 'oplatek/Conque-Shell'
Plug 'python-mode/python-mode', {'branch': 'develop'}
" Plug 'junegunn/fzf', {'dir':'~/.fzf', 'do':'./install --all'}
" Plug 'junegunn/fzf.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'rhysd/vim-healthcheck' " 健康检查插件
Plug 'scrooloose/nerdtree' " 项目目录树
Plug 'Xuyuanp/nerdtree-git-plugin'  " 目录树git状态
Plug 'morhetz/gruvbox'  " vim主题
Plug 'vim-airline/vim-airline'  " 窗口底部状态栏
Plug 'vim-airline/vim-airline-themes' " 窗口底部状态栏主题
" Plug 'davidhalter/jedi-vim'  " Python代码自动补全
" 代码补全，如果出现buildin No is module ，请到YouCompletee 运行
" git submodule update --init --recursive
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --go-completer --clang-completer' }
Plug 'ervandew/supertab'  " 代码补全tab按钮
Plug 'tell-k/vim-autopep8'  " PEP8代码检测 autopep8是必须的包
Plug 'airblade/vim-gitgutter'  " 展示Git修改的不同之处
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Or build from source code by use yarn: https://yarnpkg.com
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
call plug#end()
" ==============================
" BB打开bash
nnoremap BB :ConqueTermSplit bash<CR>
" ==============================
" NERDTree Config
" 自动打开
" autocmd vimenter * NERDTree
" NERDTree 唯一窗口关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" F2显示隐藏树
nnoremap <silent> <F2> :NERDTree<CR>
" 展示的键头
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeWinPos="right"
" ==============================
" gruvbox Theme settings
set t_Co=256  " 开启256色
set bg=dark " 设置背景为dark
colorscheme gruvbox " 设置主题

" ==============================
" AirLine Settings 窗口底部状态栏设置
let g:airline#extensions#tabline#enabled = 1  " 一个窗口多个选项卡
let g:airline#extensions#tabline#left_sep = ' '  " 左边的间隔标志
let g:airline#extensions#tabline#left_alt_sep = '|'  " 左边的警示间隔标志
let g:airline#extensions#tabline#formatter = 'default'

let g:airline_theme='dark'

" ==============================
" jedi-vim Python代码补全

" ==============================
" vim-autopep8配置
let g:autopep8_disable_show_diff=1  " 不用展示不同只处
let g:autopep8_on_save = 0  " 每次保存自动格式化pep8

" ==============================
" ctags settings
set tags=$HOME/.ctags

" ==============================
" The Keyboard Map
" Python mode version
" let g:pymode_python = 'python3'
map <F5> :call CompileRunGcc()<CR>

func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec '!g++ % -o %<'
        exec '!time ./%<'
    elseif &filetype == 'cpp'
        exec '!g++ % -o %<'
        exec '!time ./%<'
    elseif &filetype == 'python'
        exec '!time python %'
    elseif &filetype == 'go'
        exec '!time go run %'
    elseif &filetype == 'sh'
        :!time bash %
    endif
endfunc
