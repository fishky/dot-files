" Gotta be first
set nocompatible

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" ----- Making Vim look good ------------------------------------------
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'itchyny/lightline.vim'

" ----- Vim as a programmer's text editor -----------------------------
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
" Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/a.vim'
Plugin 'w0rp/ale'

" ----- Working with Git ----------------------------------------------
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

" ----- Other text editing features -----------------------------------
Plugin 'Raimondi/delimitMate'

Plugin 'christoomey/vim-tmux-navigator'

" ------ Go ------"
Plugin 'fatih/vim-go'

" ------ jedi-python ------"
Plugin 'davidhalter/jedi-vim'
" --- virtualenv integration for jedi--"
Plugin 'jmcantrell/vim-virtualenv'

" --- vimwiki --- "
Plugin 'vimwiki/vimwiki'

"--- Rust language  support ---"
Plugin 'rust-lang/rust.vim'

" --- C-tags integration --- "
Plugin 'majutsushi/tagbar'

call vundle#end()

filetype plugin indent on

" --- General settings ---
set backspace=indent,eol,start
set ruler
set number
set showcmd
set incsearch
set hlsearch

syntax on

" set mouse=a

" ----- lightline.vim  settings -----
" Always show statusbar
set laststatus=2

if !has('gui_running')
    set t_Co=256
  endif

" ----- jistr/vim-nerdtree-tabs -----
" Open/close NERDTree Tabs with \t
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
let NERDTreeDirArrows=0 
" To have NERDTree always open on startup
let g:nerdtree_tabs_open_on_console_startup = 0 


" ----- scrooloose/syntastic settings -----
let g:syntastic_error_symbol = 'X'
:let g:syntastic_warning_symbol = 'O'
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END



" ----- airblade/vim-gitgutter settings -----
" Required after having changed the colorscheme
hi clear SignColumn
" In vim-airline, only display "hunks" if the diff is non-zero
let g:airline#extensions#hunks#non_zero_only = 1


" ----- Raimondi/delimitMate settings -----
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
  au FileType java let b:delimitMate_matchpairs = "(:),[:],{:}"
  au FileType java let b:delimitMate_nesting_quotes = ['"', "'"]
  au FileType scala let b:delimitMate_matchpairs = "(:),[:],{:}"
  au FileType scala let b:delimitMate_nesting_quotes = ['"', "'"]
  au FileType js let b:delimitMate_matchpairs = "(:),[:],{:}"
  au FileType js let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

let g:jedi#popup_on_dot = 0
map <Leader>b Oimport pdb; pdb.set_trace() # BREAKPOINT<C-c>

" Enable folding (za)
set foldmethod=indent
set foldlevel=99

" vimwiki
let g:vimwiki_ext2syntax = {'.md': 'markdown'}
let g:vimwiki_list = [{'path': '/home/chrirs/docs/wiki/', 'ext': '.md', 'syntax': 'markdown'}]

"" Insert my journal template, and the current date
function! NewJournal()
     .-1read /home/chrirs/docs/wiki/diary/template.md
endfunction
nnoremap <silent><leader>nj :call NewJournal()<CR>

" rust format auto-save
let g:rustfmt_autosave = 1

" width of a tab space
set tabstop=4
set shiftwidth=4
" expand tabs with spaces
set et
" ignore case in search 
set ic
" set lightline to include git-branch
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ,
      \             [ 'venv', 'readonly'] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \    'venv': 'virtualenv#statusline'
      \ },
      \ }

" search ctrlp with regex by default
let g:ctrlp_regexp_search = 1
let g:ctrlp_clear_cache_on_exit = 0

" pip install flake8
let g:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {'python': ['autopep8', 'remove_trailing_lines', 'trim_whitespace']}


" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let undo_dir = expand('$HOME/.vim/undo_dir')
    if !isdirectory(undo_dir)
        call mkdir(undo_dir, "", 0700)
    endif
    set undodir=$HOME/.vim/undo_dir
    set undofile
endif

