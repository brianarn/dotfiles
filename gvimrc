" Brian Arnold's .gvimrc file
" Last change: 2010-06-29
"
" Some specialized changes just for GUIs

"---- Colorization Tweaks
colorscheme murphy			" I prefer this look in a GUI
" Alter the colorscheme just a bit
highlight SpecialKey ctermfg=DarkGray guifg=DarkGray
highlight LineNr ctermfg=Cyan guifg=Cyan

"---- Fonts
set guifont=Consolas:h14		" I like big fonts and I cannot lie

"---- Window size/position
" Upper left corner on Windows
winpos 0 0
" Make the window a bit larger
set lines=50 columns=175
