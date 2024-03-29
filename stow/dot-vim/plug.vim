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

" matchit, which technically ships with Vim but this version may be newer?
" I know this ships with Vim, and in theory, I can `packadd! matchit`, but
" in practice that resulted in a pile of errors that I didn't want to bother
" fixing. Also, maybe newer fixes here. Maybe.
Plug 'tmhedberg/matchit'

" Ack, as it's better than Grep
" Disabling for now so I lean more on fzf/ripgrep
"Plug 'mileszs/ack.vim'
"Plug 'jremmen/vim-ripgrep'

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
" Keeping in case I need non-binary whatever but omg fzf is so much nicer
"Plug 'ctrlpvim/ctrlp.vim'

" fzf is amazing omg
"Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Repeat, which allows me to ... repeat more things
Plug 'tpope/vim-repeat'

" Endwise, since I seem to often forget endings now
Plug 'tpope/vim-endwise'

" Startify, because it's the best Quality of Life thing ever
Plug 'mhinz/vim-startify'

" Used to use: Syntastic, one of the best syntax checkers ever
" Plug 'vim-syntastic/syntastic'
" Trying out Ale for syntax checking, pretty great so far
Plug 'dense-analysis/ale'

" Dispatch, mostly for experimenting with RSpec stuff for now
Plug 'tpope/vim-dispatch'

" Checking out Goyo to hopefully make note taking maybe better?
Plug 'junegunn/goyo.vim'

" Is org-mode all it's really cracked up to be? Let's find out.
" 2017-12-06: Disabling because, well, I just didn't get into it here.
"Plug 'jceb/vim-orgmode'

" Installing speeddating because orgmode wants it, also seems neat
" 2017-12-06: I'm not using any of the features, soooooo
"Plug 'tpope/vim-speeddating'

" Trying to get used to diffing in Vim, and I need to do directory-based stuff
Plug 'will133/vim-dirdiff'

" Trying out CoC since I'm gonna be doing typescript more
" Initially found at:
" https://medium.com/swlh/ultimate-vim-typescript-setup-35b5ac5c8c4e
Plug 'neoclide/coc.nvim' , { 'branch' : 'release' }

"---- Language Syntaxes / Utilities

" CSV, because I do a lot more than I'd like to admit with CSVs via Vim
"Plug 'chrisbra/csv.vim'

" Dockerfiles are fun, but I don't need _all the source_ for now
"Plug 'docker/docker' , { 'rtp': '/contrib/syntax/vim/' }

" Emmet, because I tell myself I'll use it someday
Plug 'mattn/emmet-vim'

" Go! Which I don't need anymore and also I think it's not on Fatih now
"Plug 'fatih/vim-go', { 'for': 'go' }

" JavaScript
Plug 'pangloss/vim-javascript'

" JSDoc for JS
Plug 'heavenshell/vim-jsdoc'

" JSON
Plug 'elzr/vim-json', { 'for': 'json' }

" TypeScript
Plug 'leafgarland/typescript-vim'

" JSX
"Plug 'mxw/vim-jsx'
Plug 'MaxMEllon/vim-jsx-pretty'

" Pug (was Jade)
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }

" Handlebars (and Mustache too I guess)
Plug 'mustache/vim-mustache-handlebars'

" Markdown
Plug 'tpope/vim-markdown', { 'for': 'markdown' }

" Pencil, as I write a lot of prose in Vim and this seems handy
" except it's also kinda broken in one rough way and remains so, sooooo
"Plug 'reedes/vim-pencil'

" PHP, because I write a lot more of this stuff than I'd like
" and I don't know why I haven't tried to make this better already
Plug '2072/PHP-Indenting-for-VIm', { 'for': 'php' }
Plug 'StanAngeloff/php.vim', { 'for': 'php' }

" Rails, because people say it's useful for Rails
" Maybe I'll learn how to work it someday
" Except I don't do much with it now soooooo
"Plug 'tpope/vim-rails', { 'for': 'ruby' }
"Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' }

" SCSS
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }

" Stylus
Plug 'wavded/vim-stylus', { 'for': 'styl' }

" Textile, because Jira comments are in Textile and yeah :/
Plug 'amiorin/vim-textile', { 'for': 'textile' }

" Tmux is kinda like a language, right?
Plug 'keith/tmux.vim', { 'for': 'tmux' }

" Twig, for use with some Slim PHP code I maintain
" Technically abandoned, but still functional
Plug 'lumiliet/vim-twig', { 'for': 'twig' }

" Vue!
Plug 'posva/vim-vue', { 'for': 'vue' }

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
