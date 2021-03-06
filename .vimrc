"
" ~/.vimrc
"

set shiftwidth=4
set tabstop=4
set autoindent
set ruler
set tw=0
set nowrap
set cmdheight=2
set wildmenu
set mouse=a
set hlsearch
set ignorecase
syntax on

" +
" + Autocmds to modify file-specific settings
" +
" change shiftwidth and indents to 2 spaces for html files:
au BufNewFile,BufRead *.html so ~/scripts/vim/html.vim

" map Ctrl+Arrows to switch window and maximize
noremap <C-Up> <Esc><C-W><Up><C-W>_
noremap <C-Down> <Esc><C-W><Down><C-W>_
noremap <C-Right> <Esc><C-W><Right><C-W>_
noremap <C-Left> <Esc><C-W><Left><C-W>_
" Ctrl+= -> Ctrl-W =
noremap <M-=> <Esc><C-W>=


" reset search 
nmap <F2> :nohlsearch<CR>
