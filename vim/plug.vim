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

" Git syntax improvements are nice
Plug 'tpope/vim-git'

" Fugitive is one of the best interfaces to Git, so great
Plug 'tpope/vim-fugitive'

" gitgutter, because I like the sigils in the sidebar
Plug 'airblade/vim-gitgutter'

"---- Miscellaneous Utilities

" Ack, as it's better than Grep
Plug 'mileszs/ack.vim'

" Base16 for tons of color options
Plug 'chriskempson/base16-vim'

" Airline, a phenomenal status/tabline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" EditorConfig, since it suppresses several holy wars
Plug 'editorconfig/editorconfig-vim'

" NERDTree, project drawer of sorts, but I don't always use it.
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" CtrlP, because it's a pretty snazzy and solid fuzzy file finder
Plug 'ctrlpvim/ctrlp.vim'

" Repeat, which allows me to ... repeat more things
Plug 'tpope/vim-repeat'

" Startify, because it's the best Quality of Life thing ever
Plug 'mhinz/vim-startify'

" Syntastic, one of the best syntax checkers ever
Plug 'scrooloose/syntastic'

" Trying out this Xdebug addon, which is pretty sweet so far
"Plug 'joonty/vdebug' ", { 'on': 'VdebugStart' }

"---- Language Syntaxes / Utilities

" CSV, because I do a lot more than I'd like to admit with CSVs via Vim
"Plug 'chrisbra/csv.vim'

" Emmet, because I tell myself I'll use it someday
Plug 'mattn/emmet-vim', { 'for': ['html', 'php'] }

" JavaScript
Plug 'pangloss/vim-javascript'

" JSON
Plug 'elzr/vim-json', { 'for': 'json' }

" Handlebars (and Mustache too I guess
Plug 'mustache/vim-mustache-handlebars'

" Markdown
Plug 'tpope/vim-markdown', { 'for': 'markdown' }

" Pencil, as I write a lot of prose in Vim and this seems handy
"Plug 'reedes/vim-pencil'

" Rails, because people say it's useful for Rails
" Maybe I'll learn how to work it someday
Plug 'tpope/vim-rails', { 'for': 'ruby' }

" SCSS
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }

" Stylus
Plug 'wavded/vim-stylus', { 'for': ['styl'] }

" Textile, because Jira comments are in Textile and yeah :/
Plug 'amiorin/vim-textile', { 'for': 'textile' }

" Twig, for use with some Slim PHP code I maintain
" Technically abandoned, but still functional
Plug 'evidens/vim-twig'

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

" Finish things up
call plug#end()
