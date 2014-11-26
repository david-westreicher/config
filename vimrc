set nocompatible              " be iMproved, required
filetype off                  " required

" ############################
" MY SETTINGS
" ###########################

" make backspace work
set bs=2 

" make copy&paste work
set pastetoggle=<F9>
set clipboard=unnamedplus

" mouse
set mouse=a

" unbind arrow keys :D
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" down is next wrap line not just line
nnoremap j gj
nnoremap k gk

" quicksave/quickquit
noremap <C-S> :w<CR>
inoremap <c-s> <Esc>:w<CR>
noremap <C-Q> :q<CR>
inoremap <c-q> <Esc>:q<CR>

" better indentation
vnoremap < <gv
vnoremap > >gv

" syntax
syntax on

" ide settings
set number
set tw=0
highlight LineNr ctermfg=grey

" use tabs 
set autoindent
set noexpandtab
set tabstop=4
set shiftwidth=4

" ############################
" VUNDLE START
" ###########################
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" ############################
" MY PLUGINGS
" ###########################

" AIRLINE
Plugin 'bling/vim-airline'
set laststatus=2
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='luna'

" MARKDOWN
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" ############################
" VUNDLE END
" ###########################
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
