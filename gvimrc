" Brian Arnold's .gvimrc file
" Last change: 2010-06-29
"
" Some specialized changes just for GUIs

"---- Colorization Tweaks
colorscheme murphy			" I prefer this look in a GUI
" Alter the colorscheme just a bit
highlight SpecialKey ctermfg=DarkGray guifg=gray32
highlight LineNr ctermfg=Cyan guifg=Cyan

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
