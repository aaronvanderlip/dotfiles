"-----------------------------------------------------------------
"
" 
" From http://github.com/claytron/dotfiles/blob/master/.vimrc  
" Not all have been implemented
"
" The mapleader has been switched from '\' to ',' anytime you see
" <leader> that is what this refers to.
"
" <leader>t -- opens the TextMate fuzzy finder
" tt -- opens up the taglist
" <leader>h -- toggles the highlight search
" <leader>n -- toggles the line numbers
" <leader>a -- starts an ack search in the CWD
" <leader>i -- toggles invisible characters
" <leader>x -- toggles NERDTree drawer
" <leader>b -- shortcut for getting to NERDTree bookmarks
" <leader><Enter> -- opens a line at the current column (this is
" the reverse of J)
" <leader>c -- Switch between light and dark colors
" jj -- alternative to <ESC>
" ; -- alternative to :
" ctrl + tab -- cycle through buffers/tabs
" <Enter> -- open a new line (non-insert)
" <S-Enter> -- open a new line above (non-insert)
" <leader>s -- Toggle spell checking
" <F2> -- Toggle smart indent on paste
" CTRL-= -- Make the current window taller
" CTRL-- (CTRL-DASH) -- Make the current window shorter
"
" -----------------------------------------------------------------

call pathogen#runtime_append_all_bundles()
set showcmd
set showmatch "show matching brackets
set nocompatible
set ignorecase smartcase
set title
set scrolloff=3
set number
"turn of folding
set foldlevel=100
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
set autoindent
set smartindent
set ruler

syntax on

"Spelling
map <silent> <leader>s :set spell!<CR>
set spelllang=en_us
set spellfile=~/.vim/spell/dict.add
set nospell
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline

" Enhanced command menu ctrl + d to expand directories
set wildmenu
set wildignore+=*.pyc,*.pyo,CVS,.svn,.git,*.mo,.DS_Store,*.pt.cache,*.Python,*.o,*.lo,*.la,*~
set wildmode=list:longest


" set all window splits equal
set equalalways

" turn off smart indentation when pasting
set pastetoggle=<F2>

" map ; to : so you don't have to use shift
map ; :

" set the mapleader key
let mapleader = ","
let g:mapleader = ","

" set super tabe default completion type "
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"


"invisibles
nmap <silent> <leader>i :set nolist!<CR>


" set up jj as mode switch
map! jj <ESC>

" set up 6 as shortuct to <c-^>
:imap <c-6>  <c-^>

"TAG List
" make the taglist show on the right side
let Tlist_Use_Right_Window = 1
" only show the current buffer, fold the rest
let Tlist_File_Fold_Auto_Close = 1
" show the name in the ctags list, helps with zope stuff :)
let tlist_xml_settings = 'zcml;n:name'
" mapping for taglist
nnoremap tt :TlistToggle<CR>

""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" STRIP TRAILING WHITESPACES
""
function! Preserve(command)
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
nmap <leader>w :call Preserve("%s/\\s\\+$//e")<CR>

" -----------------------------------------------------------------
" Searching
" -----------------------------------------------------------------
" find as you type
set incsearch
" highlight the terms
set hlsearch
" make searches case-insensitive
set ignorecase
" unless they contain upper-case letters
set smartcase
" a toggle for search highlight
map <silent> <leader>h :set hlsearch!<CR>

"generate html from reST text
:com RP :exec "Vst html" | w! /tmp/test.html | :q | !open /tmp/test.html

" -----------------------------------------------------------------
" Colors and Syntax
" -----------------------------------------------------------------
 
" gui and terminal compatible color scheme
set background=dark
colorscheme desert

"pathogen
call pathogen#runtime_append_all_bundles() 


"file handling
filetype on
filetype plugin indent on
syntax on


"Ever notice a slight lag after typing the leader key + command? This lowers  
""the timeout.  
set timeoutlen=500 

"Switch between buffers without saving  
set hidden  

"Automatically change current directory to that of the file in the buffer  
autocmd BufEnter * cd %:p:h


setlocal omnifunc=syntaxcomplete#Complete
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

"support for zcml
autocmd BufRead,BufNewFile *.zcml :set ft=xml
autocmd BufRead,BufNewFile *.py syntax on
autocmd BufRead,BufNewFile *.py set ai
autocmd BufRead,BufNewFile *.py set foldmethod=indent
autocmd BufRead,BufNewFile *.py set syntax=python
autocmd BufRead,BufNewFile *.py set smartindent
autocmd BufRead,BufNewFile *.py set cinwords=class,def,elif,else,except,finally,for,if,try,while
autocmd FileType * set tabstop=2|set shiftwidth=2|set expandtab
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab

"autocmd FileType python compiler pylint

" NERDTree settings
" -----------------------------------------------------------------
" set project folder to x
map <leader>x :NERDTreeToggle<CR>
map <leader>b :NERDTreeFromBookmark<Space>
nnoremap <silent> <leader>f :call FindInNERDTree()<CR>
" files/dirs to ignore in NERDTree (mostly the same as my svn ignores)
let NERDTreeIgnore=[
    \'\~$',
    \'\.pt.cache$',
    \'\.Python$',
    \'\.svn$',
    \'\.git*$',
    \'\.pyc$',
    \'\.pyo$',
    \'\.mo$',
    \'\.o$',
    \'\.lo$',
    \'\.la$',
    \'\..*.rej$',
    \'\.rej$',
    \'\.DS_Store$']
" set the sort order to alphabetical
let NERDTreeSortOrder=[]
" when the root is changed, change Vim's working dir
let NERDTreeChDirMode=2
" -----------------------------------------------------------------


" Fuzzy finder TextMate plugin
" -----------------------------------------------------------------

map <leader>t :FufBuffer<CR>
map <leader>tf :FufFile<CR>
" max results, lot o' files in a buildout :)
let g:fuzzy_ceiling=35000
" show full paths
let g:fuzzy_path_display = 'highlighted_path'
" ignored files
let g:fuzzy_ignore = "*.png;*.PNG;*.pyc;*.pyo;*.JPG;*.jpg;*.GIF;*.gif;.svn/**;.git/**;*.mo;.DS_Store"
 
" -----------------------------------------------------------------
" GUI settings
" -----------------------------------------------------------------
if has("gui_running")
 
    " Default size of window
    set columns=215
    set lines=55
    
    " automagically open NERDTree in a GUI
    autocmd VimEnter * exe 'NERDTreeToggle' | wincmd l
    " close the NERDTree when opening it's all text and vimperator
    " editors
    autocmd VimEnter,BufNewFile,BufRead /*/itsalltext/*.txt,vimperator-* exe 'NERDTreeClose'
    autocmd VimEnter,BufNewFile,BufRead /*/itsalltext/*.txt,vimperator-* set nonumber nospell
 
    " turn off the gui elements
    set guioptions=
 
    " OS Specific
    if has("gui_macvim")
        " use the whole screen
        set fuoptions=maxvert,maxhorz
        " use Monaco with no antialiasing
        set guifont=Monaco:h14
        "set noantialias
        " maybe set the transparency
        "set transparency=2
    endif
endif



"fix for copy/paste gvim
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa"
