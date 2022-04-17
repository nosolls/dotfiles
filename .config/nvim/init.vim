" Disable vi compatibility
set nocompatible

" Set Space as Leader
map <Space> <Leader>

" Enable file detection
filetype on

" Enable filetype plugins
filetype plugin indent on

" Syntax highlighting
syntax on

" turn on relative line numbers
set rnu

" replace tabs with spaces
set expandtab
" 1 tab = 4 spaces
set tabstop=4 shiftwidth=4
" when deleting whitespace at the beginning of a line, delete 
" 1 tab worth of spaces (for us this is 2 spaces)
set smarttab

" when creating a new line, copy the indentation from the line above
set autoindent

" Don't make backups
set nobackup

" Turn off wrap lines
set nowrap

" Ignore case when searching
set ignorecase
" This overrides ignore case to allow search for capital letters 
set smartcase

" highlight search results (after pressing Enter)
set hlsearch

" highlight all pattern matches WHILE typing the pattern
set incsearch

" show the mathing brackets
set showmatch

" Show mode in last line
set showmode

" Show last command
set showcmd

" Turn off bell(s)
set belloff=all

" Turn on autocomplete
set wildmenu
" Make full use of autocomplete
set wildmode=list:longest
" Ignore certain file extensions
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Enable true color support
set termguicolors

" Plugins
call plug#begin()

" Gruvbox theme
Plug 'morhetz/gruvbox'

" vim-rooter
Plug 'airblade/vim-rooter'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme='gruvbox'

" More UNIX shell commands in vim 
Plug 'tpope/vim-eunuch'
" Remappings for eunuch
nnoremap <leader>se :SudoEdit<CR>
nnoremap <leader>sw :SudoWrite<CR>

" Fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"" Enable command history
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Remappings for fzf
map <leader>f :Files<CR>
map <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>m :Marks<CR>

" Universal Ctags
let g:fzf_tags_command = 'ctags -R'

" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

" Preferences
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"
let g:fzf_preview_window = ''

" Theme with fzf
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Get Files
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline']}, <bang>0)

" Get text in files with Rg
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
            \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
            \ call fzf#vim#grep(
            \   'git grep --line-number '.shellescape(<q-args>), 0,
            \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" End plug
call plug#end()

" Enable italics for Gruvbox theme
let g:gruvbox_italic=1

" Go to dark mode
set background=dark
" Set theme
colorscheme gruvbox
