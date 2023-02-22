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
" vmap p "_dP

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
highlight Visual cterm=none ctermbg=darkgrey ctermfg=cyan
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
Plug 'kien/ctrlp.vim'
let g:ctrlp_custom_ignore = 'node_modules/\|DS_Store/\|\.venv/\|__pycache__/\|\.git/\|\.env/\|\.mypy_cache/\|htmlcov/\|\.pytest_cache/'
let g:ctrlp_show_hidden = 1

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
" Plug 'leafgarland/typescript-vim'

" Theme
Plug 'sainnhe/sonokai'
Plug 'norcalli/nvim-colorizer.lua'

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
let g:coc_global_extensions = ['coc-vimtex', 'coc-pyright', 'coc-json', 'coc-vetur', 'coc-tsserver', 'coc-prettier']


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


" ############################
" COC Settings
" ###########################
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
function! SplitIfNotOpen(...)
    let fname = a:1
    let call = ''
    if a:0 == 2
		let fname = a:2
		let call = a:1
    endif
    let bufnum=bufnr(expand(fname))
    let winnum=bufwinnr(bufnum)
    if winnum != -1
		" Jump to existing split
		exe winnum . "wincmd w"
    else
		" Make new split as usual
		exe "split " . fname
    endif
    " Execute the cursor movement command
    exe call
endfunction

command! -nargs=+ CocSplitIfNotOpen :call SplitIfNotOpen(<f-args>)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
"nmap <silent> <C-s> <Plug>(coc-range-select)
"xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

set termguicolors
let g:sonokai_style = 'default'
let g:sonokai_diagnostic_text_highlight = 0
let g:sonokai_diagnostic_line_highlight = 1
let g:sonokai_diagnostic_virtual_text = 'colored'
let g:sonokai_disable_italic_comment = 1
colorscheme sonokai

lua require'colorizer'.setup()
