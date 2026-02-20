" Brian Sinclair's .vimrc file
"
" This file is the result of over a decade's worth of arcane knowledge scraped
" from around the net, the manual, and as of recent years, lots and lots of
" GitHub dotfiles setups. In particular, thanks to:
" https://github.com/gf3/dotfiles
" https://github.com/carlhuda/janus/blob/master/janus/vim/core/before/plugin/mappings.vim
" http://vimcasts.org/
" https://github.com/captbaritone/dotfiles

" Additionally, this setting seems to impact a lot of other plugins/settings
" up front, so let's set it right away.
filetype plugin indent on

" matchit ships with Vim 8+ and Neovim, enable the built-in version
packadd! matchit

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

" Emmet is annoying to use the default approach with <C-y>, so here
imap <C-e> <plug>(emmet-expand-abbr)
vmap <C-e> <plug>(emmet-expand-abbr)

" Reselect visual block after indenting
vnoremap < <gv
vnoremap > >gv

" Navigate buffers much like tabs
nmap gb :bnext<CR>
nmap gB :bprev<CR>

" Visually select the text that was last edited or pasted
nmap gV `[v`]

" I got so used to CtrlP but I want it to be FZF now
" now with buffers
nmap <C-p> :Files<cr>

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

"-- Leader mappings
" Trying to sort these by leader character to make it easier to tell
" where/what I have, when editing later
let mapleader = ","
let g:mapleader = ","

" Wrap stuff in at-signs (useful in Textile)
nmap <leader>@ ysiw@

" ALE convenience mappings
nnoremap <leader>af :ALEFix<CR>
nnoremap <leader>at :ALEToggle<CR>

" Change directory to the directory of the open buffer
map <leader>cd :cd %:p:h<CR>

" Wrap stuff in <code> (useful for blog posts etc)
" Depends on vim-surround
nmap <leader>co ysiw<code>
vmap <leader>co s<code>

" Edit various files
nnoremap <leader>ev :tabnew ~/.vimrc<CR>
nnoremap <leader>ep :tabnew ~/.vim/plug.vim<CR>
nnoremap <leader>elv :tabnew ~/.vimrc.local<CR>
nnoremap <leader>elp :tabnew ~/.vimplug.local<CR>

" Fugitive mappings
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gw :Gwrite<CR>
" I like these two windows to be a bit larger
nnoremap <silent> <leader>gs :Gstatus<CR>:resize +20<CR>
nnoremap <silent> <leader>gc :Gcommit --verbose<CR>:resize +20<CR>

" Quick and easy Prettier
nnoremap <leader>p :Prettier<cr>

" Strip trailing whitespace via ALE
noremap <leader>ss :ALEFix trim_whitespace<CR>

" Make a new tab
noremap <leader>t :tabnew<CR>

" Simplify clipboard yanking
nnoremap <leader>y mZggVG"+y`Z
vnoremap <leader>y "+y

"---- Backup/swap handling
set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swap
set backup

"---- Undo options
set undofile                " Create undo files to preserve undo history
set undodir=~/.vim/tmp/undo " Where should those files go?

"---- Colors
" Turn on syntax highlighting
syntax on

" Force 256 colors in terminal Vim
if !has('nvim')
  set t_Co=256
endif

" Tinted colorschemes (base16 + base24)
let base16colorspace=256
if exists('$BASE24_THEME')
    \ && (!exists('g:colors_name') || g:colors_name != 'base24-$BASE24_THEME')
  colorscheme base24-$BASE24_THEME
elseif exists('$BASE16_THEME')
    \ && (!exists('g:colors_name') || g:colors_name != 'base16-$BASE16_THEME')
  colorscheme base16-$BASE16_THEME
else
  colorscheme base16-unikitty-dark
endif

" Color column display
let &colorcolumn="81,".join(range(121,320),",")

"--- NeoVim settings
if has("nvim")
  set inccommand=split " Interactive commands, showing preview in a split
endif

"--- Mouse
" Yeah yeah, purists gonna hate, whatever
set mouse=a

" ttymouse doesn't exist in Neovim
if !has('nvim')
  set ttymouse=xterm2
endif

"--- Autocommands
" Don't scan compressed files
let g:ft_ignore_pat = '\.\(Z\|gz\|bz2\|zip\|tgz\)$'

" Wrapped in an autogroup so that re-sourcing the file doesn't rebind the
" same autocommands
augroup BrianPresets
au!

" For Startify, go away when using NERDTree to open a file
autocmd User Startified setlocal buftype=

" Change some file extension mappings
autocmd BufRead,BufNewFile *.conf set filetype=conf " Useful for tmux

" JavaScript adjustments
autocmd FileType javascript let &l:colorcolumn=join(range(121,320),",")

autocmd BufRead,BufNewFile *.tsx set filetype=typescript.tsx

" Markdown adjustments
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd FileType markdown setlocal textwidth=80
autocmd FileType markdown let &l:colorcolumn=join(range(81,320),",")

augroup END

"---- Text formatting options
set formatoptions=cqrt      " Similar to defaults

"---- Text indentation, the great holy war
set shiftwidth=2        " Auto-indents two spaces
set tabstop=2           " Tabs at two spaces
set softtabstop=2       " Soft tabs too
set expandtab           " Spaces > Tabs
" Less holy-war fighting
set shiftround          " Round the indent to multiples of shiftwidth
set autoindent          " Newlines are indented the same as prev
set smartindent         " Indents for braces and some keywords

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
" Left-justified, 20 char min, Git status from Fugitive
set statusline+=%-20.(%{fugitive#statusline()}%)
" Left-justified, 12 char min, current line/total lines, current char/column
set statusline+=%-12.(%l/%L,%c%V%)
" Three-character file progress
set statusline+=\ %P
" Show the statusline all the time
set laststatus=2

"---- Window options
set title             " Sets the title of the window
set showmatch         " Show matching () [] {}
set scrolloff=3       " Keep 3 lines when scrolling
set noshowmode        " No need to show, Airline handles it
set showcmd           " Show incomplete command
set ttyfast           " Smoother TTY experience,
                      " if you have a faster connection
set splitbelow        " New horz splits at the bottom
set splitright        " New vert splits to the right
set showtabline=2     " Always show tab line
set cmdheight=2       " More room for messages
set updatetime=300    " Faster updates
set signcolumn=yes    " Always show the sign column

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
set wildignore+=*/tmp/*,*.swp,*~,._*
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

"---- JSX options
let g:jsx_ext_required = 0 " Highlight JSX in files that are suffix'd .js

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
let g:airline_theme = 'base16'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1
set ttimeoutlen=50

"---- NERDTree Options
" Some fonts cause weird line height issues with arrows, this makes it easy to
" enable/disable arrows instead of +/-
let NERDTreeDirArrows=1
let NERDTreeMinimalUI=1  " Don't show the tips/hints/etc
let NERDTreeHijacNetrw=0 " Play better with Startify

"---- Startify options
let g:startify_change_to_vcs_root = 1 " Changing to root of the repo is great!
let g:startify_change_to_dir = 0      " Changing to the root of the file is not.

"---- Ale options
let g:ale_fix_on_save = 0 " Run fixes on save
let g:ale_lint_on_text_changed = 'never' " Don't continuously lint
let g:ale_lint_on_insert_leave = 1 " but lint as soon as I'm done typing
let g:ale_fixers = {
\ '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'javascript': ['prettier', 'eslint'],
\ 'css': ['prettier'],
\ 'scss': ['prettier'],
\ 'typescript.tsx': ['prettier', 'eslint', 'tslint'],
\}

"---- coc.nvim options and things
" Add a command to run Prettier easily
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

"---- emmet-vim
let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}

"---- Commands
" Custom fzf commands
" Command for git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
" Like fzf.vim's Ag but using Ripgrep
command! -bang -nargs=* RGrep
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

"---- Functions
" Show syntax highlighting groups for word under cursor
nmap <leader>sy :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

"--- Local settings
source $HOME/.vimrc.local
