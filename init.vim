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

command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>
command! -bang Q quit<bang>

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

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
  Plug 'junegunn/fzf.vim'

  " Plug 'ctrlpvim/ctrlp.vim'
  Plug 'dyng/ctrlsf.vim'
  Plug 'dense-analysis/ale'
  Plug 'sheerun/vim-polyglot'
  " Plug 'Valloric/YouCompleteMe'
  
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'

  Plug 'Shougo/vimproc.vim', {'do' : 'make'}

  Plug 'scrooloose/nerdtree'
  Plug 'scrooloose/nerdcommenter'

  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  Plug 'prettier/vim-prettier', {
    \ 'do': 'yarn install',
    \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
  " Plug 'liuchengxu/eleline.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'airblade/vim-gitgutter'
  Plug 'jiangmiao/auto-pairs'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'joshdick/onedark.vim'
  Plug 'gregsexton/matchtag'
  Plug 'alvan/vim-closetag'

  " React snippets
  Plug 'SirVer/ultisnips'
  Plug 'mlaursen/vim-react-snippets'

  Plug 'OmniSharp/omnisharp-vim'

call plug#end()


" HTML Autocompletion
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.jsx,*.tsx,*.js,*.ts"

" Snips config
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"

"""""""""""""""""
"coc-nvim config"
"""""""""""""""""
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"""""""""""""""""""""
" floating terminal "
"""""""""""""""""""""
"Accepts one optional function as a parameter
function! CreateCenteredFloatingWindow(...)
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
    if exists('a:1')
      call a:1()
    endif
endfunction

function! OpenTerminal()
  call termopen("pwsh")
endfunction

function! OnOpentCtrlP()
endfunction

let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

command! -nargs=0 FloatingTerminal call CreateCenteredFloatingWindow(function('OpenTerminal'))

nnoremap <Leader><Leader>i :FloatingTerminal<Cr>
:tnoremap <Esc> <C-\><C-n>

""""""""""""""""""""""""""""""""
" Show hidden files in NERDTree"
""""""""""""""""""""""""""""""""
let NERDTreeShowHidden=1

""""""""""""""""""""""""""""
"Keybindings Plugin related"
""""""""""""""""""""""""""""
nnoremap <C-o> :NERDTreeToggle<CR>
" nnoremap <C-f> :FZF<CR>
nnoremap <C-P> :FZF<CR>
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv


"""""""""""""""""""""
"Prettier formatting"
"""""""""""""""""""""
let g:prettier#config#print_width = 100
let g:prettier#config#tab_width = 4
let g:prettier#config#use_tabs = 'false'
let g:prettier#config#semi = 'true'
let g:prettier#config#single_quote = 'false'
let g:prettier#config#jsx_bracket_same_line = 'false'

command! -nargs=0 Prettier :CocCommand prettier.formatFile

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
:hi Search cterm=NONE ctermfg=grey ctermbg=blue

"""""""""""""""""
"Terminal Colors"
"""""""""""""""""
let g:terminal_color_4 = '#ff0000'
let g:terminal_color_5 = 'green'

""""""""""""
"Popup"
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
let g:OmniSharp_server_path = 'C:\Users\kevin.brock\stdioproxy\bin\Debug\netcoreapp2.1\win-x64\stdioproxy.exe'

let g:python3_host_prog='C:\Python38\python.exe'
let g:ycm_server_python_interpreter='C:\Python27\python.exe'

let g:OmniSharp_server_stdio = 1
let g:OmniSharp_selector_ui = ''
let g:OmniSharp_timeout = 5
"omnisharp_response_timeout": 500
"set completeopt=longest,menuone,preview
let g:OmniSharp_highlight_types = 3
" let g:OmniSharp_server_stdio_quickload = 1

let g:omnicomplete_fetch_full_documentation = 1

let g:ale_linters = {
\ 'javascript': ['eslint', 'flow-language-server'] 
\}
