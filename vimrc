" Brian Arnold's .vimrc file
" Last modified: 2013-08-06 09:20:48
"
" This file is the result of over a decade's worth of arcane knowledge scraped
" from around the net, the manual, and as of recent years, lots and lots of
" GitHub dotfiles setups. In particular, thanks to:
" https://github.com/gf3/dotfiles
" https://github.com/carlhuda/janus/blob/master/janus/vim/core/before/plugin/mappings.vim
" http://vimcasts.org/
"
" We're using Vim, not Vi, so let's use Vim settings
" Needs to be set first, as there are side effects
set nocompatible

"---- Pathogen
" Make it easy to manage plugins for Vim as bundles
" There are a couple of calls that need to be ran before
" filetype detection is enabled, so I'm putting up here
" near the top of the script.
" Based on the tip in the FAQ, I'm keeping pathogen itself as a bundle!
runtime bundle/vim-pathogen/autoload/pathogen.vim
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on

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

" Wrap stuff in at-signs (useful in Textile, which I write a lot of)
nmap <leader>@ ysiw@

" Change directory to the directory of the open buffer
map <leader>cd :cd %:p:h<CR>

" Wrap stuff in <code> (useful for blog posts etc)
" Depends on surround.vim
nmap <leader>co ysiw<code>
vmap <leader>co s<code>

" Fugitive helpers
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gw :Gwrite<CR>

" For Hammer.vim: Load my preview
map <leader>h :Hammer<CR>

" Reload my snippets
noremap <leader>sr :call ReloadAllSnippets()<CR>

" Strip trailing whitespace
noremap <leader>ss :call StripWhitespace()<CR>

" Create a new tab and set it to Textile
" as I frequently need to do this for Redmine/ChiliProject posts
"noremap <leader>t :set lines=75 columns=120<CR>:setf textile<CR>
noremap <leader>t :vnew<CR>:setf textile<CR>
noremap <leader>T :tabnew<CR>:setf textile<CR>

" Edit / source my .vimrc
nnoremap <leader>ve :tabnew $MYVIMRC<CR>
nnoremap <leader>vs :source $MYVIMRC<CR>

" A shortcut for adjusting viewport quickly
noremap <leader>ws :set lines=50 columns=175<CR>
noremap <leader>wl :set lines=75 columns=250<CR>
noremap <leader>wt :set lines=75 columns=120<CR>

" Simplify clipboard yanking
nnoremap <leader>y mZggVG"+y`Z
vnoremap <leader>y "+y

"---- Backup/swap handling
set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swap
set backup

"---- Undo options
if has("persistent_undo")
	set undofile					" Create undo files to preserve undo history
	set undodir=~/.vim/tmp/undo		" Where should those files go?
endif

"---- Colors and GUI
" Turn on syntax highlighting
syntax on

if exists("+colorcolumn")
	set colorcolumn=85				" Give me an idea of width
endif

" GUI customizations
" I used to keep these in .gvimrc,
" but like the consistency of having one config now

" With GUI
if has("gui_running")
	"---- Colorization Tweaks
	" One older scheme with variations
	"colorscheme murphy
	"highlight SpecialKey ctermfg=DarkGray guifg=gray32
	"highlight LineNr ctermfg=Cyan guifg=Cyan
	" GitHub's scheme is okay
	"colorscheme github
	" Solarized Dark is wonderful, though
	let g:solarized_visibility = 'low'
	set background=dark
	colorscheme solarized

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
	set guioptions-=T				" No toolbar needed, never use it

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
	"colorscheme elflord
	"highlight SpecialKey ctermfg=DarkBlue guifg=DarkBlue
	" Trying out solarized for now
	set background=dark
	colorscheme solarized

"	" Change the cursor display when editing
"	if &term =~ "xterm"
"		" From https://gist.github.com/andyfowler/1195581 :
"		" tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
"		" http://sourceforge.net/mailarchive/forum.php?thread_name=AANLkTinkbdoZ8eNR1X2UobLTeww1jFrvfJxTMfKSq-L%2B%40mail.gmail.com&forum_name=tmux-users
"		if exists('$TMUX')
"			let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"			let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
"		else
"			let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"			let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"		endif
"	endif
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

"--- Autocommands!
if has("autocmd") " Autocommands are available
	" Don't scan compressed files
	let g:ft_ignore_pat = '\.\(Z\|gz\|bz2\|zip\|tgz\)$'

	"---- Autocommands
	" Wrapped in an autogroup so that re-sourcing the file doesn't rebind the
	" same autocmmands
	augroup BrianPresets
	au!

	" Kick off a LastMod call anytime I save a file
	autocmd BufWritePre * mark Z|call LastMod()|'Z

	" Reload my .vimrc when it changes
	autocmd BufWritePost .vimrc source ~/.vimrc

	" Treat some nonstandard JS files as JS
	autocmd BufRead,BufNewFile *.smd set filetype=javascript
	autocmd BufRead,BufNewFile *.json set filetype=javascript

	" Markdown adjustments
	autocmd FileType markdown setlocal textwidth=0
	if exists("+colorcolumn")
		autocmd FileType markdown setlocal colorcolumn=81
	endif

	" Tweak for Ruby on Rails
	autocmd BufRead,BufNewFile *.rhtml set filetype=eruby
	autocmd BufRead,BufNewFile *.erb set filetype=eruby
	autocmd BufRead,BufNewFile *.rjs set filetype=ruby

	" Use a custom CF MX format file for ColdFusion
	autocmd BufRead,BufNewFile *.cfm set filetype=cfmx
	autocmd BufRead,BufNewFile *.cfc set filetype=cfmx

	" Use a downloaded VB.NET syntax highlighter
	" See http://www.vim.org/scripts/script.php?script_id=1525
	autocmd BufRead,BufNewFile *.vb set filetype=vbnet

	" Special tweaks for Windows
	if has("win32")
		" Old CompIQ stuff below
		" Set PRC and UDF as SQL files
		"autocmd BufRead,BufNewFile *.PRC	set filetype=sql
		"autocmd BufRead,BufNewFile *.UDF	set filetype=sql
		" Set inc as aspvbs files
		"autocmd BufRead,BufNewFile *.inc	set filetype=aspvbs
		" End Old CompIQ stuff
		" Old BHI Settings
		" Assume .cls are VB files
		"autocmd BufRead,BufNewFile *.cls	set filetype=vb
	endif

	augroup END
endif " has("autocmd")

"---- Text formatting options
" Used to keep under an else from autocmd, but it seems potentially better to
" just have some solid defaults anyways
"set textwidth=78				" Trying out no default hard break width
set formatoptions=cqrt			" Similar to defaults
set autoindent					" Newlines are indented the same as prev
set smartindent					" Indents for braces and some keywords
"set cindent					" Indents according to a std C style

"---- More text-related options
set shiftwidth=4				" Auto-indents four spaces
set tabstop=4					" Tabs at four spaces
set softtabstop=4				" Soft tabs too
set noexpandtab					" Tabs > spaces
set encoding=utf-8				" Yay UTF-8
set list						" Allows for specials to be shown
set lcs=tab:>-,trail:_			" Defines specials shown
set lcs+=extends:>,precedes:<	" when using :list
set hidden						" Hide, not unload, buffers when abandoned

"---- Status line adjustments
" Sets what the status line displays as
" See :help statusline for details
" Split per inspiration from:
" http://learnvimscriptthehardway.stevelosh.com/chapters/17.html
" Original statusline, pre-split:
"set statusline=%f\ %y%m%r%=%-20.(%{fugitive#statusline()}%)%-15.(%l,%c%V%)\ %P
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

set laststatus=2			" Shows statusline all the time

"---- Window options
set title					" Sets the title of the window
set showmatch				" Show matching () [] {}
set scrolloff=3				" Keep 3 lines when scrolling
set showmode				" Show current mode
set showcmd					" Show incomplete command
set ttyfast					" Smoother TTY experience,
							" if you have a faster connection
set splitbelow				" New horz splits at the bottom
set splitright				" New vert splits to the right

"---- Session options
set sessionoptions+=slash	" Always use forward slashes
set sessionoptions+=unix	" Ensure Unix format

"---- Searching options
set magic						" Magic searching
set incsearch					" Incremental searching
set nohlsearch					" Don't highlight match for search
set ignorecase					" Ignore case when searching,
set smartcase					" unless case is used

"---- Wildcard settings
set wildchar=<TAB>				" Changes wildcard expansion from ^E
set wildmode=list:longest,full	" Adjust wildcard completion display
set wildmenu					" Show completions in status line
" Ignore output, VCS, archives, and tmp files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem
" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
" Ignore bundler and sass cache - I don't use them often, but good to avoid
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*
" Disable temp and backup files
set wildignore+=*.swp,*~,._*

"---- Miscellaneous settings
set shell=$SHELL				" Defines my shell
"set dictionary=/usr/dict/words	" Dictionary
set history=500					" Moar history
set number						" Show line numbers
set numberwidth=5				" with a bit of space
set backspace=indent,eol,start	" Backspace over everything
set fileformats=unix,dos,mac	" Preferred order of file format

"---- HTML indentation options
"---- Related to HTML indent script #2075,
"---- automatically included via javascript bundle
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

"---- JS Options
set cinoptions+=j1					" Indenting Java anonymous classes
set cinoptions+=J1					" Indenting JS object declarations

"---- Perl customizations
let perl_include_pod=1				" Recognize POD, color differently
let perl_want_scope_in_variables=1	" Gives package names another color
let perl_extended_vars=1			" Deeper parsing
let perl_string_as_statement=1		" Changes highlighting of strings

"---- PHP customizations
let php_sql_query=1					" SQL syntax highlighting in strings
let php_baselib=1					" Highlight Baselib methods
let php_htmlInStrings=1				" Highlight HTML syntax in strings
let php_asp_tags=1					" Higlight ASP-style short tags

"---- ColdFusion customizations
"let html_wrong_comments=1			" Fixes ugly syntax due to
									" <!--- ---> comments in CF files
									" NO LONGER NECESSARY WOO

"---- Shell script customizations
let highlight_function_name=1		" Highlight function names in decls

"---- HTML generation options
let html_number_lines=0		" Don't number the output
let html_use_css=1			" CSS > inline styles

"---- NERDTree Options
" Some fonts cause weird line height issues with arrows, this makes it easy to
" enable/disable arrows instead of +/-
let NERDTreeDirArrows=1
let NERDTreeMinimalUI=1		" Don't show the tips/hints/etc

"---- Syntastic Options
let g:syntastic_check_on_open=1				" Check when opening a file
let g:syntastic_always_populate_loc_list=1	" Always push errors into Location list
" Format for statusline display
let g:syntastic_stl_format='[%E{Err: %fe (%e)}%B{, }%W{Warn: %fw (%w)}]'
" Ignore some file types
let g:syntastic_ignore_files=['\.hbs$']

"---- Explorer options
let g:explVertical=1			" Split vertically
let g:explSplitRight=1			" Put new window to the right
let g:explWinSize=15			" When opening a file with o, shrink
								" explorer window down to 15 rows/cols
								" Default: 15
let g:explDateFormat='%Y-%m-%d %H:%M'	" Format of date - this format
										" sorts better
let g:explDetailedList=1		" Show me detailed view by default
let g:explHideFiles='^\.,.gz$,.exe$,.zip$,^vssver.scc$'	" Hide files
														" matching regex
														" - csv
let g:explSuffixesLast=0		" Don't push specified files to end
let g:explUseSeparators=1		" Show a separator between dirs/files

"---- snipMate options
let g:snips_author="Brian Arnold"		" It'sa me

"---- CtrlP options
"let g:ctrlp_working_path_mode = 2	" Smart path mode

"---- Vitality options
let g:vitality_fix_focus=0		" I don't care about focus fixes, just bar change

"---- Functions
" LastMod said it was already defined, but I wanted to change the format
" So, I'm just forcing it here to be YYYY-MM-DD
" Found this through "Learning the Vi and Vim Editors 7e" from O'Reilly
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
