" Li Mingyi's ~/.vimrc
"
" Basic Settings -------------------------------------- {{{1
set nocompatible
syntax on
filetype indent on
filetype plugin on

" no backup
set nobackup
set nowritebackup
set noswapfile

" show line number
set number

" use space instead of tab
set tabstop=4
set shiftwidth=4
set textwidth=80
set expandtab

" show the border
set nowrap

" set indent
set autoindent
set smartindent
set cindent

set colorcolumn=80
set hidden
set hlsearch
set incsearch
set ruler
set showcmd
set title
set wildmenu
set wildmode=list:longest,list:full

set foldmethod=marker

" set smart case
set ignorecase
set smartcase

" complete opts
set completeopt=menu,longest

" ignore files inside vcs dirs
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
" ignore object code files
set wildignore+=*.o,*.obj,*.a,*.so,*.d

set fileencodings=ucs-bom,utf8,cp936,gbk,big5,euc-jp,euc-kr,gb18130,latin1

" Fonts ----------------------------------------------- {{{2
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
set guifontwide=WenQuanYi\ Micro\ Hei\ Mono

" Vundle ---------------------------------------------- {{{1
" Install Vundle:
" git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"
" Usage:
" :BundleList            - list configured bundles
" :BundleInstall         - install(update) bundles
" :BundleSearch          - search for plugins
" :BundleClean           - confirm removal of bundles
"
" see :h vundle for more details or wiki for FAQ

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Plugin 'gmarik/vundle'

Plugin 'scrooloose/nerdtree'
"Plugin 'SuperTab'

Plugin 'Clam'
Plugin 'Conque-Shell'
Plugin 'DoxygenToolkit.vim'
Plugin 'Gundo'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'powerline/fonts'
Plugin 'godlygeek/tabular'

" Color Schemes
Plugin 'tomasr/molokai'

" Programming
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'

" Color Schemes --------------------------------------- {{{1
if has("gui_running")
    "set background=dark
    colorscheme molokai

    set guioptions-=T
    "set guioptions-=m
    "set guioptions-=r
    "set guioptions-=L
else
    set t_Co=256
    set background=dark
    colorscheme molokai
endif

" Plugins --------------------------------------------- {{{1
" Clam ------------------------------------------------ {{{2
" http://www.vim.org/scripts/script.php?script_id=4000
" https://github.com/sjl/clam.vim
" https://bitbucket.org/sjl/clam.vim/
" hg clone https://bitbucket.org/sjl/clam.vim
nnoremap <leader>c :Clam<Space>

" CtrlP ----------------------------------------------- {{{2
" https://github.com/ctrlpvim/ctrlp
" git clone git://github.com/ctrlpvim/ctrlp.git
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'

" Doxygen --------------------------------------------- {{{2
" http://www.vim.org/scripts/script.php?script_id=987
let g:DoxygenToolkit_authorName="LiMingyi"

let g:DoxygenToolkit_briefTag_pre="@Synopsis"
let g:DoxygenToolkit_paramTag_pre="@Param:"
let g:DoxygenToolkit_paramTag_post=" - "
let g:DoxygenToolkit_returnTag="@Returns:"

" Gundo ----------------------------------------------- {{{2
" http://sjl.bitbucket.org/gundo.vim/
" hg clone https://bitbucket.org/sjl/gundo.vim
nnoremap <leader>u :GundoToggle<CR>

let g:gundo_right = 1

" NERDTree -------------------------------------------- {{{2
" http://www.vim.org/scripts/script.php?script_id=1658
" http://github.com/scrooloose/nerdtree
" git clone git://github.com/scrooloose/nerdtree.git
nnoremap <leader>nt :NERDTreeToggle<CR>

let NERDTreeWinPos=1

" Tabular --------------------------------------------- {{{2
" http://github.com/godlikegeek/tabular
" git clone git://github.com/godlikegeek/tabular.git

" Tagbar ---------------------------------------------- {{{2
" http://www.vim.org/scripts/script.php?script_id=3465
" http://github.com/majutsushi/tagbar
" git clone git://github.com/majutsushi/tagbar.git
nnoremap <leader>tb :TagbarToggle<CR>

let g:tagbar_left = 1
let g:tagbar_width = 40

" let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 0
let g:tagbar_autoshowtag = 1

" let tags sorted according to their order int source files
let g:tagbar_sort = 0

let g:tagbar_ctags_bin = '/usr/bin/ctags'

" let Tagbar start with vim
autocmd VimEnter * nested :TagbarOpen

" YouCompleteMe --------------------------------------- {{{2
" https://github.com/Valloric/YouCompleteMe
" git clone git://github.com/Valloric/YouCompleteMe.git

" let g:ycm_global_ycm_extra_conf = '~/.vim/ycm/cpp/.ycm_extra_conf.py'
" enable completion from tags
"let g:ycm_collect_identifiers_from_tags_files = 1 
"let g:ycm_seed_identifiers_with_syntax = 1 
"let g:ycm_key_invoke_completion = '<C-a>'

" 自动补全配置
set completeopt=longest,menu	"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif	"离开插入模式后自动关闭预览窗口
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"	"回车即选中当前项
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

"youcompleteme  默认tab  s-tab 和自动补全冲突
"let g:ycm_key_list_select_completion=['<c-n>']
let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion=['<c-p>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示

let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'

let g:ycm_collect_identifiers_from_tags_files=1	" 开启 YCM 基于标签引擎
let g:ycm_min_num_of_chars_for_completion=2	" 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0	" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1	" 语法关键字补全
"force recomile with syntastic
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
"nnoremap <leader>lo :lopen<CR>	"open locationlist
"nnoremap <leader>lc :lclose<CR>	"close locationlist
inoremap <leader><leader> <C-x><C-o>
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0
"按gb 会跳转到定义
nnoremap <silent> gb :YcmCompleter GoToDefinitionElseDeclaration<CR>
"nnoremap <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR> 
let g:ycm_collect_identifiers_from_tags_files = 1 
" Vim-airline ----------------------------------------- {{{2
" https://github.com/vim-airline/vim-airline
" https://github.com/vim-airline/vim-airline-themes
" git clone git://github.com/vim-airline/vim-airline.git
" git clone git://github.com/vim-airline/vim-airline-themes.git
let g:airline_theme = 'dark'
let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" Make airlines appear all the time
set laststatus=2

" Commands, Mappings and Functions -------------------- {{{1
" Tags ------------------------------------------------ {{{2
set tags+=.tags;
set tags+=tags;
nnoremap <leader>gt :!ctags -R -f .tags<CR><CR>

" Find Conflict Marks --------------------------------- {{{2
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" cscope quick fix ------------------------------------ {{{1
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

set cscopequickfix=s-,c-,d-,i-,t-,e-

"使用一个新工程需要使用的命令
"find `pwd` -name "*.[ch]" -o -name "*.cpp" > cscope.files;ctags -R
"--c++-kinds=+p --fields=+iaS --extra=+q; cscope -Rbkq
