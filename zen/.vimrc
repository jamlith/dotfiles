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
set showcmd
set smartcase
set showmatch
set whichwrap=b,s,<,>
set background=dark

function HTMLconf()
	set shiftwidth=2
	set tabstop=2
	set tw=80
endfunction


autocmd BufNewFile,BufRead *.html call HTMLconf()

" Chose this theme due to an issue with the windows terminal i've been
" using has some almost impossible to read color combos (specifically blue
" on black) that was minimuzed with this color scheme.  It seems like an
" all-around good choice, but theres a good chance that it wont translate
" ... you can uncomment the following line to revert to the default scheme.
colorscheme slate
"colorscheme default


noremap <C-Up> <C-W><Up><C-W>_
noremap <C-Down> <C-W><Down><C-W>_
noremap <C-Right> <C-W><Right><C-W>_
noremap <C-Left> <C-W><Left><C-W>_
