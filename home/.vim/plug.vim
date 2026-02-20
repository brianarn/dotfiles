" ------------------------------------------------------------------------------
" Plugin management via Plug
" https://github.com/junegunn/vim-plug
"
" Borrows inspiration from
" https://github.com/captbaritone/dotfiles/blob/master/vim/plug.vim
" ------------------------------------------------------------------------------

" Install Plug and plugins if it doesn't already exist
" See https://github.com/junegunn/vim-plug/wiki/faq
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

"---- Start up Plug
call plug#begin('~/.vim/plugged')

"---- Git Utilities

" Git syntax improvements
Plug 'tpope/vim-git'

" Fugitive is one of the best interfaces to Git
Plug 'tpope/vim-fugitive'

" gitgutter, because I like the sigils in the sidebar
Plug 'airblade/vim-gitgutter'

"---- Miscellaneous Utilities

" Tinted colorschemes (base16 + base24)
Plug 'tinted-theming/tinted-vim'

" Airline, a phenomenal status/tabline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" NERDTree, project drawer of sorts
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

" fzf is amazing omg
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Repeat, which allows me to ... repeat more things
Plug 'tpope/vim-repeat'

" Endwise, since I seem to often forget endings now
Plug 'tpope/vim-endwise'

" Startify, because it's the best Quality of Life thing ever
Plug 'mhinz/vim-startify'

" ALE for linting and fixing
Plug 'dense-analysis/ale'

" Dispatch for async builds and test running
Plug 'tpope/vim-dispatch'

" Goyo for distraction-free writing
Plug 'junegunn/goyo.vim'

" CoC for LSP support in Neovim
if has('nvim')
  Plug 'neoclide/coc.nvim' , { 'branch' : 'release' }
endif

"---- Language Syntaxes / Utilities

" Emmet for expanding abbreviations into HTML/CSS
Plug 'mattn/emmet-vim'

" JavaScript
Plug 'pangloss/vim-javascript'

" JSDoc for JS
Plug 'heavenshell/vim-jsdoc'

" JSX
Plug 'MaxMEllon/vim-jsx-pretty'

" Pug (was Jade)
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }

" Handlebars and Mustache
Plug 'mustache/vim-mustache-handlebars'

" Markdown
Plug 'tpope/vim-markdown', { 'for': 'markdown' }

" PHP indentation and syntax
Plug '2072/PHP-Indenting-for-VIm', { 'for': 'php' }
Plug '2072/vim-syntax-for-PHP', { 'for': 'php' }

" SCSS
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }

" Tmux config syntax
Plug 'keith/tmux.vim', { 'for': 'tmux' }

" Vue
Plug 'leafOfTree/vim-vue-plugin', { 'for': 'vue' }

"---- Text Manipulation

" Abolish, primarily for Subvert which is so amazing
Plug 'tpope/vim-abolish'

" Commentary, because it's nice to quickly comment/uncomment
Plug 'tpope/vim-commentary'

" Unimpaired, as I like the ability to quickly move things about etc
Plug 'tpope/vim-unimpaired'

" Surround, as I like to change text surroundings
Plug 'tpope/vim-surround'

" Tabular, because aligning text is nice
Plug 'godlygeek/tabular'

"---- Local
source $HOME/.vimplug.local

"--- End
call plug#end()
