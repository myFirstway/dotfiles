" ============================= "
" ViM configuration file        "
" Author: Tamado Ramot Sitohang "
" License: MIT                  "
" ============================= "
if has ('gui_running') || &term ==# 'xterm-256color' || &term==# 'xterm-kitty' || &term ==# 'screen-256color'

" vim-plug {{{
set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

" Enabled

" Plug 'rakr/vim-one'
Plug 'Vimjas/vim-python-pep8-indent', { 'for' : ['python'] }
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'  " , { 'on' : 'NERDTreeToggle' }
Plug 'sjl/gundo.vim', { 'on' : 'GundoToggle' }
Plug 'chrisbra/csv.vim'
Plug 'alvan/vim-closetag'
Plug 'Raimondi/delimitMate'
Plug 'junegunn/vim-easy-align'
Plug 'farmergreg/vim-lastplace'

call plug#end()
" }}}

" UI settings {{{
" Basic stuff
scriptencoding utf-8
filetype plugin on
syntax on

" UI/UX
set autoread
" set background=light
set backspace=2
set cinoptions=(0,u0,U0
set clipboard=unnamedplus
set copyindent
" set cursorline
set diffopt=filler,internal,algorithm:histogram,indent-heuristic
set expandtab
set formatoptions=cql
set grepprg=grep\ -nH\ $*
set gtl=%t
set hidden
set history=10000
set hlsearch
set incsearch
set mouse=a
set nowrap
set nolinebreak
" set number
set preserveindent
set scrolloff=5
set shiftwidth=2
set shortmess+=c
set showmatch!
" set signcolumn=yes
set smartcase
set softtabstop=0
set splitbelow
set splitright
set stal=0
set t_Co=256
set tabstop=2
" set termguicolors
set title
set ttimeoutlen=0
set updatetime=300
set virtualedit=onemore
set wmnu

" I-Beam cursor on gvim terminal
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"

" Colorscheme
" let g:airline_theme = 'fruit_punch'
" colorscheme peachpuff
" set background=light
" hi Normal ctermbg=NONE guibg=NONE
hi Folded ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE

" Miscellanous
let g:tex_conceal = ''
" let g:terminal_ansi_colors = [
  " \ '#ffffff', '#b31d28', '#22863a', '#e36209',
  " \ '#032f62', '#45267d', '#669cc2', '#24292e',
  " \ '#41484f', '#d73a49', '#3ebc5c', '#f18338',
  " \ '#005cc5', '#6f42c1', '#669cc2', '#6a737d'
  " \]
let g:mapleader=','
let g:maplocalleader=','

" Disabled
" set switchbuf+=usetab,newtab
" set wrapmargin=0
" set noshowmode
" }}}

" Completion settings {{{
set completeopt-=preview
let g:closetag_filenames = '*.html,*.xhtml,*.xml,*.html.erb,*.md,*.svg'
let g:delimitMate_matchpairs = '(:),[:],{:}'
let g:delimitMate_balance_matchpairs = 0
let g:delimitMate_expand_cr = 2
let g:delimitMate_expand_space = 1

nnoremap <leader>a :lclose<CR>
" }}}

" NERDTree settings {{{
let g:NERDTreeMinimalUI=1
let g:NERDTreeStatusLine=-1
let g:NERDTreeWinSize=30
let g:NERDTreeHijackNetrw=1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeNaturalSort = 1
let g:NERDTreeBookmarksFile = '/home/ramot/.config/.NERDTreeBookmarks'
" let NERDTreeMapOpenInTab='<CR>'
" }}}

" NERDCommenter settings {{{
let g:NERDSpaceDelims=1
let g:NERDRemoveExtraSpaces=1
let g:NERDAltDelims_haskell=1
let g:NERDCustomDelimiters = {
      \ 'python': { 'left': '#', 'right': '' }
      \ }
" }}}

" Gundo setings {{{
let g:gundo_help = 0
let g:gundo_width = 30
let g:gundo_preview_height = 10
let g:gundo_prefer_python3 = 1
" }}}

" Misc settings {{{
let g:username='Tamado Ramot Sitohang'
let g:email='ramottamado@gmail.com'

set pastetoggle=<F2>
set nobackup
set nowritebackup
" }}}

" Listchars option {{{
if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
    set listchars=tab:\│\ ,trail:·,extends:>,precedes:<,nbsp:·
    set fillchars=fold:\ ,
endif
set list
" }}}

" Fold text {{{
function! MyFoldText()
  let l:lines = printf('%' . len(line('$')) . 'd', v:foldend - v:foldstart + 1)
  let l:line  = substitute(foldtext(), '^+-\+ *\d\+ lines: ', '', '')
  return '[ ' . l:lines . ' lines: ' . l:line . ' ]'
endfunction
" }}}

" Pretty Title {{{
function! BufferName()
  let l:name_buf = expand('%:t')
  if l:name_buf ==? ''
    let l:name_buf = '[NO NAME]'
  endif
  return l:name_buf
endfunction
" }}}

" Autocommand setings {{{
" augroup autoremove_trail
  " au BufWritePre        *.*           :%s/\s\+$//e
" augroup END
augroup scala_sbt
  au BufRead,BufNewFile *.sbt,*.sc    set filetype=scala
  au FileType           json          syntax match Comment +\/\/.\+$+
augroup END
augroup markdown_formatting
  au FileType           markdown      setlocal wrap
augroup END
augroup formatting
  au FileType           *             setlocal formatoptions-=ro
augroup END
augroup nerd_tree
  au BufEnter           *             if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  au FileType           nerdtree      setlocal nolist
augroup END
augroup folding
  au FileType           *             set foldtext=MyFoldText()
  au FileType           *             set foldmethod=manual
augroup END
" augroup pairing
  " au FileType           ruby,eruby    let b:delimitMate_quotes="\" ' ` |"
" augroup END
augroup title_string
  au BufEnter           *             let &titlestring = BufferName() . "\ \ —\ \ VIM"
  au BufWritePost       *             let &titlestring = BufferName() . "\ \ —\ \ VIM"
  au VimResized         *             let &titlestring = BufferName() . "\ \ —\ \ VIM"
augroup END
augroup clipboard_opt
  au VimLeavePre        *             let @/ = ""
augroup END
augroup filetype_help
  au BufWinEnter        *             if &l:buftype ==# 'help' | nmap <C-M> <C-]>| endif
augroup END
augroup zsh
  au FileType           zsh           set ts=2
  au FileType           zsh           set sts=2
  au FileType           zsh           set sw=2
  au FileType           zsh           set expandtab
augroup END
" augroup jekyll
  " au FileType           html          let g:delimitMate_quotes = "` ' \" %"
  " au FileType           markdown      let g:delimitMate_quotes = "` ' \" % *"
" augroup END
augroup xml
  au FileType           xml           set noet
augroup END
augroup gui
  au GUIEnter * let g:NERDTreeWinSize = 50
  au GUIEnter * let g:gundo_width = 50
augroup END
" }}}

" CSV Plugin {{{
hi link CSVColumnOdd  Normal
hi link CSVColumnEven Normal

let g:csv_delim = ','
let g:csv_nl = 1
let g:csv_highlight_column = 1
let g:csv_autocmd_arrange = 1
" }}}

source ~/.vim/keysrc.vim

endif

" set stal=2
set t_RV=
set t_SH=
set t_SI=

" vim:fdm=marker
