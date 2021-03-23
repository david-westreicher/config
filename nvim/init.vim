set nocompatible              " be iMproved, required
filetype off                  " required

" ############################
" MY SETTINGS
" ###########################
"
" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" color
set background=light
" make backspace work
set bs=2 

" make copy&paste work
set pastetoggle=<F9>
set clipboard=unnamedplus
vmap p "_dP

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


" ide settings
set number
set tw=0
highlight LineNr ctermfg=grey
highlight Search ctermfg=black
highlight CocErrorHighlight ctermfg=DarkRed
highlight CocWarningHighlight ctermfg=DarkRed
highlight CocInfoHighlight ctermfg=DarkRed
highlight CocHintHighlight ctermfg=DarkRed
highlight CocErrorLine ctermbg=DarkGray
highlight CocWarningLine ctermbg=DarkGray
highlight CocInfoLine ctermbg=DarkGray
highlight CocHintLine ctermbg=DarkGray
highlight clear SignColumn

" highlight CocErrorFloat ctermfg=white
" highlight CocInfoFloat ctermfg=white
" highlight CocWarnFloat ctermfg=white
" highlight CocHintFloat ctermfg=white
" highlight CocFloating ctermbg=darkred


set hlsearch
"execute "set <M-l>=\eL"
"execute "set <M-o>=\eO"
" noremap <M-l> :ALEFix<CR>
" noremap <M-o> :ALEImport<CR>
" nnoremap <silent> gd :ALEGoToDefinition -split<CR>

" use spaces 
set autoindent
" set noexpandtab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smartindent
set shiftround
set copyindent
set preserveindent

" File extensions
au BufReadPost *.mc set syntax=c

" ############################
" VUNDLE START
" ###########################
call plug#begin('~/.vim/plugged')

" ############################
" MY PLUGINGS
" ###########################

" AIRLINE
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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
let g:airline_solarized_bg='dark'
let g:airline_theme='solarized'

"GIT
Plug 'airblade/vim-gitgutter'

"CTRLP
Plug 'kien/ctrlp.vim'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|data/\|__pycache__'

"Multiple Cursors
Plug 'terryma/vim-multiple-cursors'

" signatures
Plug 'kshenoy/vim-signature'

" autopep8
Plug 'tell-k/vim-autopep8'
let g:autopep8_ignore='E501'

" ide
Plug 'scrooloose/nerdtree'

" Dockerfile
Plug 'ekalinin/Dockerfile.vim'

" Ansible
Plug 'pearofducks/ansible-vim'

" Search
Plug 'ddrscott/vim-side-search'

" Typescript
Plug 'leafgarland/typescript-vim'

" Vue
Plug 'posva/vim-vue'

" Latex
Plug 'lervag/vimtex', {'tag': 'v1.0'}
let g:vimtex_compiler_latexmk = {
        \ 'executable' : 'latexmk',
        \}
let g:vimtex_complete_enabled = 1
let g:vimtex_view_method = 'zathura'
let g:tex_flavor = 'latex'

" Linter
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-vimtex', 'coc-python', 'coc-json', 'coc-vetur']


" ############################
" VUNDLE END
" ###########################
call plug#end()
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"

" syntax
syntax enable
filetype plugin on
