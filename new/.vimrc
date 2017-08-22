"
" ~/.vimrc
"

set shiftwidth=2
set tabstop=2
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
	set shiftwidth=4
	set tabstop=4
	set tw=80
endfunction
function JSconf()
	set shiftwidth=3
	set tabstop=3
endfunction


autocmd BufNewFile,BufRead *.html call HTMLconf()
autocmd BufNewFile,BufRead *.js	call JSconf()

colorscheme slate


noremap <C-Up> <C-W><Up><C-W>_
noremap <C-Down> <C-W><Down><C-W>_
noremap <C-Right> <C-W><Right><C-W>_
noremap <C-Left> <C-W><Left><C-W>_
