" Brian Arnold's .vimrc file
" Last modified: 2012-05-14 21:52:12
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

"-- Full key mappings
" Someone suggested F2 for NERDTree, and I've grown used to it
" See http://www.catonmat.net/blog/vim-plugins-nerdtree-vim/
noremap <F2> :NERDTreeToggle<CR>

" I seem to need a lot of semicolons
" Add one in insert mode at the end of the line
inoremap <c-cr> <esc>A;<cr>
" When in normal mode, tack one onto the end and move down a line
nnoremap <c-cr> A;<esc>

" Reselect visual block after indenting
vnoremap < <gv
vnoremap > >gv

"-- Leader mappings
" Trying to sort these by leader character to make it easier to tell
" where/what I have, when editing later

let mapleader = ","
let g:mapleader = ","

" Change directory to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

" Wrap stuff in <code> (useful for blog posts etc)
" Depends on surround.vim
nmap <leader>co ysiw<code>
vmap <leader>co s<code>

" Edit / source my .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" A shortcut for scaling up viewport when on the iMac
noremap <leader>g :set lines=75 columns=250<cr>

" Escape/Unescape HTML
map <silent> <leader>he :call HtmlEscape()<CR>
map <silent> <leader>hu :call HtmlUnEscape()<CR>

" For Hammer.vim: Load my preview
map <leader>p :Hammer<CR>


" Reload my snippets
noremap <leader>s :call ReloadAllSnippets()<cr>

" Clean up whitespace
nnoremap <leader>w :%s/\s\+$//<cr>

"---- Backup/swap handling
set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swap
set undodir=~/.vim/tmp/undo
set backup

"---- Colors and GUI
" Turn on syntax highlighting
syntax on

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
	" GitHub's scheme is nice
	"colorscheme github
	" Trying out Solairzed for now
	let g:solarized_visibility = 'low'
	set background=dark
	colorscheme solarized

	"---- Fonts
	set guifont=Consolas:h14		" I like big fonts and I cannot lie

	"---- Window size/position
	" Make the window a bit larger
	set lines=50 columns=175

	" Don't save window sizes
	set sessionoptions-=resize

	" Bind up ctrl/cmd+# to go to tabs
	if has("gui_macvim")
		noremap <D-1> 1gt<CR>
		noremap <D-2> 2gt<CR>
		noremap <D-3> 3gt<CR>
		noremap <D-4> 4gt<CR>
		noremap <D-5> 5gt<CR>
		noremap <D-6> 6gt<CR>
		noremap <D-7> 7gt<CR>
		noremap <D-8> 8gt<CR>
		noremap <D-9> 9gt<CR>
	else
		noremap <C-1> 1gt<CR>
		noremap <C-2> 2gt<CR>
		noremap <C-3> 3gt<CR>
		noremap <C-4> 4gt<CR>
		noremap <C-5> 5gt<CR>
		noremap <C-6> 6gt<CR>
		noremap <C-7> 7gt<CR>
		noremap <C-8> 8gt<CR>
		noremap <C-9> 9gt<CR>
	endif

	"---- Just for Windows
	if has("win32")
		" Upper left corner on Windows
		"winpos 0 0
	endif
else
	" Just some simple color tweaks
	" Old scheme with a tweak
	"colorscheme elflord
	"highlight SpecialKey ctermfg=DarkBlue guifg=DarkBlue
	" Trying out solarized for now
	set background=dark
	colorscheme solarized
endif

"--- Text Formatting
if has("autocmd") " Autocommands are available
	" If I'm editing asp/asa files, it's probably VB
	let g:filetype_asa = 'aspvbs'
	let g:filetype_asp = 'aspvbs'
	" Don't scan compressed files
	let g:ft_ignore_pat = '\.\(Z\|gz\|bz2\|zip\|tgz\)$'

	"---- Autocommands
	" Let's use an autocmd group so we can delete easily
	" This is admittedly somewhat cargo-cult-ish, I don't ever delete
	augroup BrianPresets
	au!

	" Kick off a LastMod call anytime I save a file
	autocmd BufWritePre *				mark s|call LastMod()|'s

	" Reload my .vimrc when it changes
	autocmd BufWritePost .vimrc			source ~/.vimrc

	" I want my simple text files to wrap at 78 characters
	autocmd FileType text setlocal textwidth=78

	" Same with Markdown
	autocmd FileType markdown setlocal textwidth=78

	" However, some others shouldn't wrap
	autocmd FileType textile setlocal textwidth=0
	autocmd FileType html setlocal textwidth=0

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
	autocmd BufRead,BufNewFile *.vb		set filetype=vbnet

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

"---- Text formatting optionsa
" Used to keep under an else from autocmd, but it seems potentially better to
" just have some solid defaults anyways
set textwidth=78				" Width of window
set formatoptions=cqrt			" Similar to defaults
set autoindent					" Newlines are indented the same as prev
set smartindent					" Indents for braces and some keywords
set cindent						" Indents according to a std C style
set colorcolumn=85				" Give me an idea of when I'm hitting width

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
set wildmode=list:longest,full	" Adjust wildcard completion display
set wildmenu					" Show completions in status line
set shell=$SHELL				" Defines my shell
set dictionary=/usr/dict/words	" Dictionary
set history=500					" Moar history
set number						" Show line numbers
set numberwidth=5				" with a bit of space
set backspace=indent,eol,start	" Backspace over it all
set fileformats=unix,dos,mac	" Preferred order of file format
set undofile					" Create undo files to preserve undo history

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
let html_number_lines=0		" Don't number the output
let html_use_css=1			" Shorter HTML, but needs better browser

"---- NERDTree Options
let NERDTreeDirArrows=0		" Don't use arrows for now, causes odd line
								" height issues
let NERDTreeMinimalUI=1		" Don't show the tips/hints/etc

"---- Syntastic Options
let g:syntastic_check_on_open=1	" Check when opening a file

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
endfunc

" HTML escaping/unescaping functions
function! HtmlEscape()
  silent s/&/\&amp;/eg
  silent s/</\&lt;/eg
  silent s/>/\&gt;/eg
endfunction

function! HtmlUnEscape()
  silent s/&lt;/</eg
  silent s/&gt;/>/eg
  silent s/&amp;/\&/eg
endfunction

"---- TESTING
