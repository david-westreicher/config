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

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
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

" relative line numbers
set relativenumber

" unbind arrow keys :D
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" down is next wrap line not just line
nnoremap j gj
nnoremap k gk

" cut until end of line
nnoremap S vg_"_d

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
highlight Visual ctermbg=darkgrey
highlight CocErrorHighlight ctermfg=DarkRed
highlight CocWarningHighlight ctermfg=DarkRed
highlight CocInfoHighlight ctermfg=DarkRed
highlight CocHintHighlight ctermfg=DarkRed
highlight CocErrorLine ctermbg=238
highlight CocWarningLine ctermbg=238
highlight CocInfoLine ctermbg=238
highlight CocHintLine ctermbg=238
highlight CocHighlightText ctermbg=239
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
let g:airline_theme='sonokai'

"GIT
Plug 'airblade/vim-gitgutter'

"CTRLP
"Plug 'kien/ctrlp.vim'
"let g:ctrlp_custom_ignore = 'node_modules/\|DS_Store/\|\.venv/\|__pycache__/\|\.git/\|\.env/\|\.mypy_cache/\|htmlcov/\|\.pytest_cache/'
"let g:ctrlp_show_hidden = 1

"Multiple Cursors
Plug 'terryma/vim-multiple-cursors'

" signatures
Plug 'kshenoy/vim-signature'

" ide
" Plug 'scrooloose/nerdtree'

" Terraform
Plug 'hashivim/vim-terraform'

" Dockerfile
Plug 'ekalinin/Dockerfile.vim'

" Ansible
Plug 'pearofducks/ansible-vim'

" Search
" Plug 'ddrscott/vim-side-search'

" Typescript
Plug 'leafgarland/typescript-vim'

" Vue
Plug 'posva/vim-vue'

" Theme
Plug 'sainnhe/sonokai'

" Color in source code
Plug 'norcalli/nvim-colorizer.lua'


" Python
Plug 'vim-python/python-syntax'
let g:python_highlight_all = 1

" Jinja
Plug 'glench/vim-jinja2-syntax'

" Fuzzy file search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
function! GitFZF()
  let path = trim(system('cd '.shellescape(expand('%:p:h')).' && git rev-parse --show-toplevel'))
  if !isdirectory(path)
    let path = expand('%:p:h')
  endif
  exe 'FZF ' . path
endfunction
command! GitFZF call GitFZF()
nnoremap <silent> <C-p> :GitFZF<CR>

" Latex
Plug 'lervag/vimtex', {'tag': 'v1.0'}
let g:vimtex_compiler_latexmk = {
        \ 'executable' : 'latexmk',
        \}
let g:vimtex_complete_enabled = 1
let g:vimtex_latexmk_continuous = 0
let g:vimtex_view_method = 'zathura'
let g:tex_flavor = 'latex'

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-vimtex', 'coc-pyright', 'coc-json', 'coc-vetur', 'coc-tsserver', 'coc-prettier', '@yaegassy/coc-ruff']


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

source ~/.config/nvim/coc.vim

set termguicolors
let g:sonokai_style = 'default'
let g:sonokai_diagnostic_text_highlight = 0
let g:sonokai_diagnostic_line_highlight = 1
let g:sonokai_diagnostic_virtual_text = 'colored'
let g:sonokai_disable_italic_comment = 1
colorscheme sonokai

lua require'colorizer'.setup()
