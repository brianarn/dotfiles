" Brian Arnold's .vimrc file
" Last change: 2010-06-29
"
" We're using Vim, not Vi, so let's use Vim settings
" Needs to be set first, as there are side effects
set nocompatible

"---- Mappings
" Soon to be some! Really!
let mapleader = ","
let g:mapleader = ","

"---- Colorization
" If term has color or we're in GUI, colorize!
if &t_Co > 2 || has("gui_running")
	syntax on					" Turn on Syntax highlighting
	set background=dark			" Set background to dark,
								" nicer syntax highlighting
	colorscheme elflord			" Nice coloring scheme
	" Alter the colorscheme just a bit
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

	" I want my simple text files to wrap at 78 characters
	autocmd FileType text setlocal textwidth=78

	" Javascript Stuff
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
	"set cindent					" Indents according to a std C style
endif " has("autocmd")

"---- More Text Formatting
set noexpandtab					" We like tabs
set shiftwidth=4				" Auto-indents four spaces
set tabstop=4					" Tabs at four spaces
set list						" Allows for specials to be shown
set lcs=tab:>-,trail:_			" Defines specials shown
set lcs+=extends:>,precedes:<	" when using :list

"---- Window options
set title					" Sets the title of the window
set ruler					" Show line/column
set showmatch				" Show matching () [] {}
set laststatus=2			" Shows stats all the time
set scrolloff=3				" Keep 3 lines when scrolling
set showmode				" Show current mode
set showcmd					" Show incomplete command
set ttyfast					" Smoother TTY experience,
							" if you have a faster connection

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
set history=50					" Moar history

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
