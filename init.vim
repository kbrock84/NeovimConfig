"**NEOVIM CONFIG***

" Keybindings (Non plugin related)
:inoremap jj <Esc>

:let mapleader = " "
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <Tab> :bnext<Cr>
nnoremap <S-Tab> :bprevious<Cr>
noremap <silent> <C-S-Left> :vertical resize +5<CR>
noremap <silent> <C-S-Right> :vertical resize -5<CR>

" Set UTF-8
set encoding=utf-8
 
" Set command window height
set cmdheight=2

" Set relative numbering
set number
set relativenumber

" Plugin config
call plug#begin('~/.vim/plugged')

  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'pangloss/vim-javascript'
  Plug 'maxmellon/vim-jsx-pretty'

  " Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'dyng/ctrlsf.vim'
  Plug 'dense-analysis/ale'
  Plug 'sheerun/vim-polyglot'
  Plug 'Valloric/YouCompleteMe'
  Plug 'tpope/vim-dispatch'
  Plug 'Shougo/vimproc.vim', {'do' : 'make'}
  Plug 'OmniSharp/omnisharp-vim'
  Plug 'scrooloose/nerdtree'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  Plug 'prettier/vim-prettier', {
    \ 'do': 'yarn install',
    \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
  " Plug 'liuchengxu/eleline.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'jiangmiao/auto-pairs'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'scrooloose/nerdcommenter'
  Plug 'joshdick/onedark.vim'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'   }

call plug#end()

""""""""""""""""""""""""""""
"Keybindings Plugin related"
""""""""""""""""""""""""""""

nnoremap <C-o> :NERDTreeToggle<CR>
" nnoremap <C-f> :FZF<CR>
nnoremap <C-P> :CtrlP<CR>
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv

""""""""""""""
"XMAL => XAML"
""""""""""""""
au BufNewFile,BufRead *.xaml setf xml

""""""
"Tabs"
""""""
set tabstop=2
set shiftwidth=2
set smartindent
set expandtab

""""""""""""""
"No Line Wrap"
""""""""""""""
set nowrap

""""""""""""""
"Syntax Theme"
""""""""""""""
let g:onedark_terminal_italics=1
let g:airline_theme="tomorrow"
syntax on
colorscheme onedark
let g:airline#extensions#tabline#enabled=1
set cursorline
:hi Visual term=reverse cterm=reverse guibg=Grey

"""""""""""""""""
"Terminal Colors"
"""""""""""""""""
let g:terminal_color_4 = '#ff0000'
let g:terminal_color_5 = 'green'

""""""""""""
"Popup Color"
"""""""""""""
:highlight Pmenu ctermbg=49 guibg=49

"""""""""""""""""""
"Git Gutter Config"
"""""""""""""""""""
"let g:gitgutter_highlight_lines = 1
let g:gitgutter_highlight_linenrs = 1

""""""""""""""""""""
"Status Line Config"
""""""""""""""""""""
set laststatus=2

""""""""""
"Comments"
""""""""""
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

"""""""""""""""""""""""
"OmniSharp (C#) Config"
"""""""""""""""""""""""
let g:OmniSharp_server_path = OMNISHARP_PATH

let g:python3_host_prog='C:\Python38\python.exe'
let g:ycm_server_python_interpreter='C:\Python27\python.exe'

let g:OmniSharp_server_stdio = 1
let g:OmniSharp_selector_ui = ''
let g:OmniSharp_timeout = 5
"omnisharp_response_timeout": 500
set completeopt=longest,menuone,preview
let g:OmniSharp_highlight_types = 3
" let g:OmniSharp_server_stdio_quickload = 1

let g:omnicomplete_fetch_full_documentation = 1

let g:ale_linters = {
\ 'cs': ['OmniSharp'],
\}

augroup omnisharp_commands
    autocmd!

    " 4 spaces for C#
    autocmd FileType cs set tabstop=4
    autocmd FileType cs set shiftwidth=4

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>

    " Find all code errors/warnings for the current solution and populate the quickfix window
    autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
augroup END

" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
" Run code actions with text selected in visual mode to extract method
xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>

" Rename with dialog
nnoremap <Leader>nm :OmniSharpRename<CR>
nnoremap <F2> :OmniSharpRename<CR>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

nnoremap <Leader>cf :OmniSharpCodeFormat<CR>

" Start the omnisharp server for the current solution
nnoremap <Leader>ss :OmniSharpStartServer<CR>
nnoremap <Leader>sp :OmniSharpStopServer<CR>
