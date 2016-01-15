" Brian Sinclair's .vimrc file
"
" This file is the result of over a decade's worth of arcane knowledge scraped
" from around the net, the manual, and as of recent years, lots and lots of
" GitHub dotfiles setups. In particular, thanks to:
" https://github.com/gf3/dotfiles
" https://github.com/carlhuda/janus/blob/master/janus/vim/core/before/plugin/mappings.vim
" http://vimcasts.org/
" https://github.com/captbaritone/dotfiles
"
" We're using Vim, not Vi, so let's use Vim settings
" Needs to be set first, as there are side effects
set nocompatible

"---- Plugins
source $HOME/.vim/plug.vim

"---- Mappings
" I'm trying to reserve the Z mark for any/all positional mappings, hence the
" frequent occurrence of "mZ<something>`Z"

"-- Full key mappings
" Someone suggested F2 for NERDTree, and I've grown used to it
" See http://www.catonmat.net/blog/vim-plugins-nerdtree-vim/
noremap <F2> :NERDTreeToggle<CR>

" I seem to need a lot of semicolons, so we'll add one on to the end
inoremap <C-CR> <Esc>mZA;<Esc>`Zi
nnoremap <C-CR> mZA;<Esc>`Z

" Reselect visual block after indenting
vnoremap < <gv
vnoremap > >gv

" Navigate buffers much like tabs
nmap gb :bnext<CR>
nmap gB :bprev<CR>

" Visually select the text that was last edited or pasted
nmap gV `[v`]

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
nmap <C-k> [e
nmap <C-j> ]e

" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
vmap <C-k> [egv
vmap <C-j> ]egv

" Join lines and restore cursor location
nnoremap J mZJ`Z

" Toggle pasting
set pastetoggle=<F3>

"-- Leader mappings
" Trying to sort these by leader character to make it easier to tell
" where/what I have, when editing later
let mapleader = ","
let g:mapleader = ","

" Wrap stuff in at-signs (useful in Textile)
nmap <leader>@ ysiw@

" Change directory to the directory of the open buffer
map <leader>cd :cd %:p:h<CR>

" Wrap stuff in <code> (useful for blog posts etc)
" Depends on vim-surround
nmap <leader>co ysiw<code>
vmap <leader>co s<code>

" Fugitive mappings
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gw :Gwrite<CR>
" I like these two windows to be a bit larger
nnoremap <silent> <leader>gs :Gstatus<CR>:resize +20<CR>
nnoremap <silent> <leader>gc :Gcommit --verbose<CR>:resize +20<CR>

" Reload my snippets
"noremap <leader>sr :call ReloadAllSnippets()<CR>

" Strip trailing whitespace
noremap <leader>ss :call StripWhitespace()<CR>

" Make a new tab
noremap <leader>t :tabnew<CR>

" Edit / source my .vimrc
nnoremap <leader>ve :tabnew $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>

" Simplify clipboard yanking
nnoremap <leader>y mZggVG"+y`Z
vnoremap <leader>y "+y

"---- Backup/swap handling
set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swap
set backup

"---- Undo options
if has("persistent_undo")
  set undofile                " Create undo files to preserve undo history
  set undodir=~/.vim/tmp/undo " Where should those files go?
endif

"---- Colors and GUI
" Turn on syntax highlighting
syntax on

" GUI customizations
" I used to keep these in .gvimrc,
" but like the consistency of having one config now

" With GUI
if has("gui_running")
  "---- Colorization Tweaks
  "set background=dark

  " One older scheme with variations
  "colorscheme murphy
  "highlight SpecialKey ctermfg=DarkGray guifg=gray32
  "highlight LineNr ctermfg=Cyan guifg=Cyan
  " Now using gf'3 molotov
  colorscheme molotov

  "---- Fonts
  " Consolas is an old standby, trying out SCP for now tho
  "set guifont=Consolas:h14
  set guifont=Source\ Code\ Pro:h14

  "---- Window size/position
  set lines=50 columns=175

  " Don't save window sizes
  "set sessionoptions-=resize
  set sessionoptions-=winsize

  " GUI options
  set guioptions-=T       " No toolbar needed, never use it

  " Custom GUI-specific adjustments that may vary from Mac to other environments
  if has("gui_macvim")
    " Map cmd+# to switch tabs
    noremap <D-1> 1gt<CR>
    inoremap <D-1> <Esc>1gt<CR>
    noremap <D-2> 2gt<CR>
    inoremap <D-2> <Esc>2gt<CR>
    noremap <D-3> 3gt<CR>
    inoremap <D-3> <Esc>3gt<CR>
    noremap <D-4> 4gt<CR>
    inoremap <D-4> <Esc>4gt<CR>
    noremap <D-5> 5gt<CR>
    inoremap <D-5> <Esc>5gt<CR>
    noremap <D-6> 6gt<CR>
    inoremap <D-6> <Esc>6gt<CR>
    noremap <D-7> 7gt<CR>
    inoremap <D-7> <Esc>7gt<CR>
    noremap <D-8> 8gt<CR>
    inoremap <D-8> <Esc>8gt<CR>
    noremap <D-9> 9gt<CR>
    inoremap <D-9> <Esc>9gt<CR>

  else
    " Map ctrl+# to switch tabs
    noremap <C-1> 1gt<CR>
    inoremap <C-1> <Esc>1gt<CR>
    noremap <C-2> 2gt<CR>
    inoremap <C-2> <Esc>2gt<CR>
    noremap <C-3> 3gt<CR>
    inoremap <C-3> <Esc>3gt<CR>
    noremap <C-4> 4gt<CR>
    inoremap <C-4> <Esc>4gt<CR>
    noremap <C-5> 5gt<CR>
    inoremap <C-5> <Esc>5gt<CR>
    noremap <C-6> 6gt<CR>
    inoremap <C-6> <Esc>6gt<CR>
    noremap <C-7> 7gt<CR>
    inoremap <C-7> <Esc>7gt<CR>
    noremap <C-8> 8gt<CR>
    inoremap <C-8> <Esc>8gt<CR>
    noremap <C-9> 9gt<CR>
    inoremap <C-9> <Esc>9gt<CR>
  endif

  "---- Just for Windows
  if has("win32")
    " Upper left corner on Windows
    "winpos 0 0
  endif
else
  " Force 256 colors
  set t_Co=256

  " Old scheme with a tweak
  set background=dark
  colorscheme molotov
endif

" Color column display (Vim 7.3+)
if exists("+colorcolumn")
  let &colorcolumn="81,".join(range(121,320),",")        " Give me an idea of width
endif


"--- Mouse
if has("mouse")
  " Yeah yeah, purists gonna hate, whatever
  " Run my mouse everywhere
  set mouse=a

  " Make it work right in Mac / iTerm2
  " Not sure why this works, but it does:
  " http://stackoverflow.com/questions/9116225/how-to-enable-mouse-support-in-tmux-vim-so-it-continues-to-work-even-after-a-ssh
  set ttymouse=xterm2
endif

"--- Folding
" Trying to get into folding. See the following:
" http://vimcasts.org/episodes/how-to-fold/
" https://github.com/sjl/dotfiles/blob/eea18b00b8c74943f5094fddf91d3c2a7e0a7242/vim/vimrc#L534

" An option that would let me start fully folded
"set foldlevelstart=0

" Use <Space> to toggle folds
nnoremap <Space> za
vnoremap <Space> za

"--- Autocommands
if has("autocmd") " Autocommands are available
  " Don't scan compressed files
  let g:ft_ignore_pat = '\.\(Z\|gz\|bz2\|zip\|tgz\)$'

  " Wrapped in an autogroup so that re-sourcing the file doesn't rebind the
  " same autocmmands
  augroup BrianPresets
  au!

  " Kick off a LastMod call anytime I save a file
  autocmd BufWritePre * mark Z|call LastMod()|'Z

  " Reload my .vimrc when it changes
  autocmd BufWritePost .vimrc source ~/.vimrc

  " For Startify, go away when using CtrlP/NERDTree to open a file
  autocmd User Startified setlocal buftype=

  " Change some file extension mappings
  autocmd BufRead,BufNewFile *.conf set filetype=conf " Useful for tmux
  "autocmd BufRead,BufNewFile *.json set filetype=javascript

  " JavaScript adjustments
  if exists("+colorcolumn")
    autocmd FileType javascript let &l:colorcolumn=join(range(121,320),",") " Give me an idea of width
  endif

  " Markdown adjustments
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd FileType markdown setlocal textwidth=80
  if exists("+colorcolumn")
    autocmd FileType markdown let &l:colorcolumn=join(range(81,320),",") " Give me an idea of width
  endif

  " Vimwiki adjustments
  autocmd FileType vimwiki setlocal textwidth=80

  " Vagrant
  autocmd BufRead,BufNewFile Vagrantfile set filetype=ruby

  " Ruby on Rails
  autocmd BufRead,BufNewFile *.rhtml set filetype=eruby
  autocmd BufRead,BufNewFile *.erb set filetype=eruby
  autocmd BufRead,BufNewFile *.rjs set filetype=ruby

  augroup END
endif " has("autocmd")

"---- Text formatting options
" Used to keep under an else from autocmd, but it seems potentially better to
" just have some solid defaults anyways
set formatoptions=cqrt      " Similar to defaults

"---- Text indentation, the great holy war
" The way I used to feel:
"set shiftwidth=4       " Auto-indents four spaces
"set tabstop=4          " Tabs at four spaces
"set softtabstop=4      " Soft tabs too
"set noexpandtab        " Tabs > spaces
" The way I feel now
set shiftwidth=2        " Auto-indents two spaces
set tabstop=2           " Tabs at two spaces
set softtabstop=2       " Soft tabs too
set expandtab           " Spaces > Tabs
" Less holy-war fighting
set shiftround            " Round the indent to multiples of shiftwidth
set autoindent            " Newlines are indented the same as prev
set smartindent           " Indents for braces and some keywords
filetype plugin indent on " Let file plugins handle indenting

"---- More text-related options
set encoding=utf-8            " Yay UTF-8
set list                      " Allows for specials to be shown
set lcs=tab:>-,trail:_        " Defines specials shown
set lcs+=extends:>,precedes:< " when using :list
set hidden                    " Hide, not unload, buffers when abandoned

"---- Status line adjustments
" Sets what the status line displays as
" See :help statusline for details
" Split per inspiration from:
" http://learnvimscriptthehardway.stevelosh.com/chapters/17.html
" Path to file (relative to cwd)
set statusline=%f
" Flags: filetype, modified, readonly
set statusline+=\ %y%m%r
" Quickfix list or Location list
set statusline+=%q
" Left/right separator
set statusline+=%=
" Left-justified, 30 char min, Syntastic status
"set statusline+=%-30.(%#warningmsg#%{SyntasticStatuslineFlag()}%*%)
" Left-justified, 20 char min, Git status from Fugitive
set statusline+=%-20.(%{fugitive#statusline()}%)
" Left-justified, 12 char min, current line/total lines, current char/column
set statusline+=%-12.(%l/%L,%c%V%)
" Three-character file progress
set statusline+=\ %P

" Show the statusline all the time
set laststatus=2

"---- Window options
set title         " Sets the title of the window
set showmatch     " Show matching () [] {}
set scrolloff=3   " Keep 3 lines when scrolling
set noshowmode    " No need to show, Airline handles it
set showcmd       " Show incomplete command
set ttyfast       " Smoother TTY experience,
                  " if you have a faster connection
set splitbelow    " New horz splits at the bottom
set splitright    " New vert splits to the right
set showtabline=2 " Always show tab line

"---- Session options
set sessionoptions+=slash " Always use forward slashes
set sessionoptions+=unix  " Ensure Unix format

"---- Searching options
set magic      " Magic searching
set incsearch  " Incremental searching
set nohlsearch " Don't highlight match for search
set ignorecase " Ignore case when searching,
set smartcase  " unless case is used

"---- Wildcard settings
set wildchar=<TAB>             " Changes wildcard expansion from ^E
set wildmode=list:longest,full " Adjust wildcard completion display
set wildmenu                   " Show completions in status line
" Ignore output, VCS, archives, and tmp files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
" Ignore archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
" Ignore bundler and sass cache - I don't use them often, but good to avoid
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
" Disable temp and backup files
set wildignore+=*.swp,*~,._*
" Skip node_modules and dist dirs
set wildignore+=*/node_modules/*,*/dist/*

"---- Miscellaneous settings
set shell=$SHELL               " Defines my shell
set history=500                " Moar history
set number                     " Show line numbers
set numberwidth=5              " with a bit of space
set backspace=indent,eol,start " Backspace over everything
set fileformats=unix,dos,mac   " Preferred order of file format

"---- HTML indentation options
"---- Related to HTML indent script #2075,
"---- automatically included via javascript bundle
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

"---- JS Options
" Not sure these matter anymore, disabling for now
"set cinoptions+=j1 " Indenting Java anonymous classes
"set cinoptions+=J1 " Indenting JS object declarations

"---- Perl customizations
let perl_include_pod=1             " Recognize POD, color differently
let perl_want_scope_in_variables=1 " Gives package names another color
let perl_extended_vars=1           " Deeper parsing
let perl_string_as_statement=1     " Changes highlighting of strings

"---- PHP customizations
let php_sql_query=1     " SQL syntax highlighting in strings
let php_baselib=1       " Highlight Baselib methods
let php_htmlInStrings=1 " Highlight HTML syntax in strings
let php_asp_tags=1      " Higlight ASP-style short tags

" ---- Shell script customizations
let highlight_function_name=1 " Highlight function names in decls

"---- HTML generation options
let html_number_lines=0 " Don't number the output
let html_use_css=1      " CSS > inline styles

"---- Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0
set ttimeoutlen=50

"---- NERDTree Options
" Some fonts cause weird line height issues with arrows, this makes it easy to
" enable/disable arrows instead of +/-
let NERDTreeDirArrows=1
let NERDTreeMinimalUI=1  " Don't show the tips/hints/etc
let NERDTreeHijacNetrw=0 " Play better with Startify

"---- Syntastic Options
let g:syntastic_check_on_open=1            " Check when opening a file
let g:syntastic_always_populate_loc_list=1 " Always push errors into Location list
" Format for statusline display
let g:syntastic_stl_format='[%E{Err: %fe (%e)}%B{, }%W{Warn: %fw (%w)}]'
" Ignore some file types that don't have clean linting
let g:syntastic_ignore_files=['\.hbs$', '\.twig$']

"---- Explorer options
let g:explVertical=1   " Split vertically
let g:explSplitRight=1 " Put new window to the right
let g:explWinSize=15   " When opening a file with o, shrink
                       " explorer window down to 15 rows/cols
                       " Default: 15
let g:explDateFormat='%Y-%m-%d %H:%M' " Format of date - this format
                                      " sorts better
let g:explDetailedList=1              " Show me detailed view by default
let g:explHideFiles='^\.,.gz$,.exe$,.zip$,^vssver.scc$'  " Hide files matching regex
let g:explSuffixesLast=0  " Don't push specified files to end
let g:explUseSeparators=1 " Show a separator between dirs/files

"---- snipMate options
let g:snips_author="Brian Sinclair"

"---- CtrlP options
"let g:ctrlp_working_path_mode = 2  " Smart path mode

"---- Vitality options
"let g:vitality_fix_focus=0    " I don't care about focus fixes, just bar change

"---- VimWiki
" Let's see what we can do here
" Set up a customized wiki, fairly straightforward
" let wiki = {}
" let wiki.path = '~/Dropbox/vimwiki'
" let wiki.diary_rel_path = 'journal'
" let wiki.diary_index = 'index'
" let wiki.syntax = 'markdown'
" let wiki.ext = '.md'
" let wiki.nested_syntaxes = {'javascript': 'javascript', 'js': 'javascript'}
" let wiki.auto_tags = 1
" let g:vimwiki_list = [wiki]
" " Let me use the mouse in some way
" let g:vimwiki_use_mouse=1
" " I use Markdown, don't just assume temporary wikis everywhere I open markdown
" let g:vimwiki_global_ext=0

"---- Functions
" LastMod said it was already defined, but I wanted to change the format
" So, I'm just forcing it here to be YYYY-MM-DD
" Found this through 'Learning the Vi and Vim Editors 7e' from O'Reilly
function! LastMod()
  " If there are more than 20 lines, set our max to 20,
  " otherwise, scan entire file.
  if line("$") > 20
    let lastModifiedline = 20
  else
    let lastModifiedline = line("$")
  endif
  exe "1," . lastModifiedline . "g/Last modified: /s/Last modified:.*/Last modified: " . strftime("%Y-%m-%d %H:%M:%S")
endfunction

" Strip trailing whitespace (,ss)
function! StripWhitespace ()
  " Copy our current position / query
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  " Strip the whitespace, /e suppresses notice of pattern not found
  :%s/\s\+$//e
  " Restore our previous position / query
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction

" Show syntax highlighting groups for word under cursor
nmap <leader>sy :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
