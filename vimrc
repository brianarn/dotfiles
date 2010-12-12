" Brian Arnold's .vimrc file
" Last modified: 2010-12-11 14:50:39
"
" We're using Vim, not Vi, so let's use Vim settings
" Needs to be set first, as there are side effects
set nocompatible

"---- Pathogen
" Make it easy to manage plugins for Vim as bundles
" There are a couple of calls that need to be ran before
" filetype detection is enabled, so I'm putting up here
" near the top of the script.
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"---- Mappings
let mapleader = ","
let g:mapleader = ","

" Edit my .vimrc
noremap <leader>v :e ~/.vimrc<cr>

" Reload settings
noremap <leader>r :source ~/.vimrc<cr>

" A shortcut for scaling up when on the iMac
noremap <leader>g :set lines=75 columns=250<cr>

" Someone suggested F2 for NERDTree, so I'll try that
" See http://www.catonmat.net/blog/vim-plugins-nerdtree-vim/
noremap <F2> :NERDTreeToggle<CR>

" Reload my snippets
noremap <leader>s :call ReloadAllSnippets()<cr>

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

" I seem to need a lot of semicolons
" Add one in insert mode at the end of the line
inoremap <c-cr> <esc>A;<cr>
" When in normal mode, tack one onto the end and move down a line
nnoremap <c-cr> A;<esc>

" Clean up whitespace
nnoremap <leader>w :%s/\s\+$//<cr>

"---- Backup/swap handling
set backupdir=~/.vim/backups
set directory=~/.vim/swapfiles

"---- Colors and GUI
" Turn on syntax highlighting
syntax on

" Dark backgrounds generally preferred
set background=dark

" GUI customizations
" I used to keep these in .gvimrc,
" but like the consistency of having one config now

" With GUI
if has("gui_running")
	"---- Colorization Tweaks
	"colorscheme murphy
	"highlight SpecialKey ctermfg=DarkGray guifg=gray32
	"highlight LineNr ctermfg=Cyan guifg=Cyan
	colorscheme github

	"---- Fonts
	set guifont=Consolas:h14		" I like big fonts and I cannot lie

	"---- Window size/position
	" Make the window a bit larger
	set lines=50 columns=175

	" Save window sizes
	set sessionoptions+=resize

	"---- Just for Windows
	if has("win32")
		" Upper left corner on Windows
		"winpos 0 0
	endif
else
	" Just some simple color tweaks
	colorscheme elflord
	highlight SpecialKey ctermfg=DarkBlue guifg=DarkBlue
endif

"--- Text Formatting
if has("autocmd") " Autocommands are available
	"---- Filetype Adjustments
	" Enable file type detection and indenting, etc
	filetype plugin indent on

	" If I'm editing asp/asa files, it's probably VB
	let g:filetype_asa = 'aspvbs'
	let g:filetype_asp = 'aspvbs'
	" Don't scan compressed files
	let g:ft_ignore_pat = '\.\(Z\|gz\|bz2\|zip\|tgz\)$'

	"---- Autocommands
	" Let's use an autocmd group so we can delete easily
	augroup BrianPresets
	au!

	" Kick off a LastMod call anytime I save a file
	autocmd BufWritePre *				mark s|call LastMod()|'s

	" Reload my .vimrc when it changes
	autocmd BufWritePost .vimrc			source ~/.vimrc

	" I want my simple text files to wrap at 78 characters
	autocmd FileType text setlocal textwidth=78

	" Javascript Stuff
	autocmd BufRead,BufNewFile *.smd	set filetype=javascript
	autocmd BufRead,BufNewFile *.json	set filetype=javascript

	" No wrapping with aspvbs files
	autocmd FileType aspvbs setlocal textwidth=0

	" Tweak for Ruby on Rails
	autocmd BufRead,BufNewFile *.rhtml	set filetype=eruby
	autocmd BufRead,BufNewFile *.erb	set filetype=eruby
	autocmd BufRead,BufNewFile *.rjs	set filetype=ruby

	" Use a custom CF MX format file for ColdFusion
	autocmd BufRead,BufNewFile *.cfm	set filetype=cfmx
	autocmd BufRead,BufNewFile *.cfc	set filetype=cfmx

	" Use a downloaded VB.NET syntax highlighter
	" See http://www.vim.org/scripts/script.php?script_id=1525
	autocmd BufRead,BufNewFile *.vb	set filetype=vbnet

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
else " No autocommands, so just set up some simple formatting
	set textwidth=78				" Width of window, I like mine small
	set formatoptions=cqrt			" Similar to defaults
	set autoindent					" Newlines are indented the same as prev
	set smartindent					" Indents for braces and some keywords
	set cindent						" Indents according to a std C style
endif " has("autocmd")

"---- More Text Formatting
set noexpandtab					" We like tabs
set shiftwidth=4				" Auto-indents four spaces
set tabstop=4					" Tabs at four spaces
set list						" Allows for specials to be shown
set lcs=tab:>-,trail:_			" Defines specials shown
set lcs+=extends:>,precedes:<	" when using :list

"---- Status line adjustments
" Sets what the status line displays as
" See :help statusline for details
set statusline=%f\ %y%m%r%=%-20.(%{fugitive#statusline()}%)%-15.(%l,%c%V%)\ %P
set laststatus=2			" Shows statusline all the time

"---- Window options
set title					" Sets the title of the window
set showmatch				" Show matching () [] {}
set scrolloff=3				" Keep 3 lines when scrolling
set showmode				" Show current mode
set showcmd					" Show incomplete command
set ttyfast					" Smoother TTY experience,
							" if you have a faster connection

"---- Session options
set sessionoptions+=slash	" Always use forward slashes
set sessionoptions+=unix	" Ensure Unix format

"---- Searching options
set magic						" Magic searching
set incsearch					" Incremental searching
set nohlsearch					" Don't highlight match for search
set ignorecase					" Ignore case when searching,
set smartcase					" unless case is used

"---- Miscellaneous settings
set wildchar=<TAB>				" Changes wildcard expansion from ^E
set wildmenu					" Show completions in status line
set shell=$SHELL				" Defines my shell
set dictionary=/usr/dict/words	" Dictionary
set history=500					" Moar history
set number						" Show line numbers
set numberwidth=5				" with a bit of space
set backspace=indent,eol,start	" Backspace over it all
set fileformats=unix,dos,mac	" Preferred order of file format

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
let html_wrong_comments=1			" Fixes ugly syntax due to
									" <!--- ---> comments in CF files
									" NO LONGER NECESSARY WOO

"---- Shell script customizations
let highlight_function_name=1		" Highlight function names in decls

"---- HTML generation options
let html_number_lines = 0		" Don't number the output
let html_use_css = 1			" Shorter HTML, but needs better browser

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
let g:snips_author="Brian Arnold"		" It"sa me

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
	exe "1," . lastModifiedline . "g/Last modified: /s/Last modified: .*/Last modified: " . strftime("%Y-%m-%d %H:%M:%S")
endfunc

"---- TESTING
" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
