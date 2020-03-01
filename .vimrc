
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=300		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
"map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
"inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin on
  filetype indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"Change buffer - without saving
set hid

syntax on

set nobackup
set nowritebackup
set noswapfile

set background=dark

if has("autocmd")
  filetype indent on
endif

set showcmd     " Show (partial) command in status line.
set showmatch   " Show matching brackets.
set mouse=a     " Enable mouse usage (all modes) in terminals

if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" a proper status line
set laststatus=2
set statusline=%f%m%r%h%w\ [%{&ff}]\ %y\ %{strftime(\"%d/%m/%Y\ %H:%M\",getftime(expand(\"%:p\")))}\ %=\ [%l,%v]\ [%p%%]
set showmode

set backspace=2
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

" show tabs and trailing spaces
set listchars=tab:»·,trail:·
set list

" Set backspace config
" allow backspacing over everything in insert mode
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" encoding settings
set encoding=utf8
"try
"    lang en_US
"catch
"endtry

set ffs=unix,dos,mac "Default file types


" at some point try pablo scheme
if has("gui")
    colorscheme koehler
else
    colorscheme ron
endif

" highlight tab and space errors
" syntax match Error "\s\+$"
" syntax match Error " \+\t"me=e-1

" highlight long lines
" syntax match Error "\(^.\{79\}\)\@<=." contains=ALL containedin=ALL

" key bindings
noremap <silent> <a-Left>   :tabp<CR>
noremap <silent> <a-Right>  :tabn<CR>
noremap <silent> <a-Up>     :bprev<CR>
noremap <silent> <a-Down>   :bnext<CR>
noremap <silent> <F2>       :TMiniBufExplorer<CR>
"noremap <silent> <F3>       :MiniBufExplorer<CR>
"noremap <silent> <S-F3>     :CMiniBufExplorer<CR>
noremap <silent> <F3>       :NERDTreeToggle<CR>
noremap <silent> <F4>       :Tlist<CR>
noremap <silent> <F5>       :e!<CR>
noremap <silent> <F11>      :cal VimCommanderToggle()<CR>


" reload config files if changed
au! BufWritePost .vimrc source %

""""""""""""""""""""""""""""""
" => Minibuffer plugin
""""""""""""""""""""""""""""""
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerMoreThanOne = 2
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplVSplit = 25   " column width in chars
let g:miniBufExplSplitBelow=0

"let g:bufExplorerSortBy = "name"

"autocmd BufRead,BufNew :call UMiniBufExplorer

"let g:miniBufExplSplitToEdge = 0
"let g:miniBufExplorerMoreThanOne = 1
"let g:miniBufExplModSelTarget = 1


""""""""""""""""""""""""""""""
" => omnicppcomplete plugin
""""""""""""""""""""""""""""""
map <S-F11> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>


""""""""""""""""""""""""""""""
" => NERT_tree plugin
""""""""""""""""""""""""""""""
let NERDTreeCaseSensitiveSort=1
"let NERDTreeIgnore=['\.svn$']
let NERDTreeShowHidden=1
let NERDTreeWinSize=25

""""""""""""""""""""""""""""""
" => powerline plugin
""""""""""""""""""""""""""""""
set rtp+=$HOME/.local/lib/python3.4/site-packages/powerline/bindings/vim

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

