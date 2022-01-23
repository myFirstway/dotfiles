" ============================= "
" ViM keymap                    "
" Author: Tamado Ramot Sitohang "
" License: MIT                  "
" ============================= "

" nnoremap ;                            :
nnoremap <silent><F3>                 :let @/ = ""<CR><Esc>
map <silent><F4>                      :set invpaste<CR>
nnoremap <silent><F5>                 :GundoToggle<CR>
inoremap <silent><F5>                 <C-o>:GundoToggle<CR>
map <silent><C-e>                     :NERDTreeCWD<CR>
au BufEnter NERD_tree_*               nnoremap <buffer><silent><C-e> :NERDTreeClose<CR>
au BufLeave NERD_tree_*               map <silent><C-e> :NERDTreeCWD<CR>
map <C-o>                             :sp<space>
map <silent><F2>                      :ene<CR>
" nmap <C-q>                            <nop>
" imap <silent><C-q>                    <C-o>:conf q<CR>
imap <silent><C-Z>                    <C-o>u
imap <silent><C-R>                    <C-o><C-R>
nnoremap <C-J>                        <C-W><C-J>
nnoremap <C-K>                        <C-W><C-K>
nnoremap <C-L>                        <C-W><C-L>
nnoremap <C-H>                        <C-W><C-H>
nmap <BS>                             <C-t>
nmap <silent>                       ,ci
vmap <silent>                       ,ci
imap <silent>                       <C-o>,ci
nmap <C-M>                            %
" nnoremap <Leader>-                    <C-w>-
" nnoremap <Leader>+                    <C-w>+
" nnoremap <Leader>=                    <C-w>=
map <C-S-Down>                        <C-w><C-w>
map <C-S-Up>                          <C-w>w
nmap <silent><Tab>                    :bn!<CR>
nmap <silent><S-Tab>                  :bp!<CR>
" nmap <silent><C-\>                    :bp<CR>
" nmap <silent><Space>                  :bnext<CR>
nmap <silent><Del>                    :conf bdelete<CR>
nnoremap <silent><Leader><Leader>     :noh<CR>
nnoremap <space>                      za
map <silent><C-f>                     :Directories<CR>

" For conceal markers.
if &term ==# 'xterm-256color' || &term ==# 'screen-256color'
  if has('conceal')
    set conceallevel=2 concealcursor=nc
  endif
endif
