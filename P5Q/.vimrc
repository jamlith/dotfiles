" set global options
set belloff=all
set nowrap
set number
set cmdheight=2
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set wildmenu
set hlsearch
set incsearch
set foldenable
set mouse=a

" enable syntax highlighting
syntax on


"
" MAPPINGS
"

" CTRL-<ARROW>: switch to the next window in that arrow's
             "  direction, then maximize the newly occupid
             "  window.
nnoremap <C-Down> <Esc><C-W><Down><C-W>_
nnoremap <C-Up> <Esc><C-W><Up><C-W>_
nnoremap <C-Left> <Esc><C-W><Left><C-W>_
nnoremap <C-Right> <Esc><C-W><Right><C-W>_
" CTRL-x[l, v, f]: exec a block of the current file in BASH...
" [l] dumps the current line into bash and evaluates it
" [L] dumps the line the same as [l], but it prints the output in
"     the last line of the same file
" [v] is for use on lines of text that are defining a variable in
"     BASH... eg 'varname="value of var"'.  By using the [v] func
"     you will run the declaration in bash, but afterwards the script
"     will print the value to the shell stdout...

nnoremap <C-x>l :exec("!" . getline('.'))<CR>
nnoremap <C-x>L :let shline=getline('.')<CR>:exec(".!" . shline)<CR>
nnoremap <C-x>v :let xline=getline('.')<CR>:exec("!" . xline . '; printf "$' . matchstr(xline, "^[^=]*") . '\n";')<CR>

