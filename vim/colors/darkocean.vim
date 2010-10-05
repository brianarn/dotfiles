" Name Of File: darkocean.vim
"  Description: Gvim colorscheme, works best with version 6.0.
"   Maintainer: Naveen Chandra R <ncr AT iitbombay DOT org>
"  Last Change: Thursday, August 15, 2002
" Installation: Drop this file in your $VIMRUNTIME/colors/ directory
"               or manually source this file using ':so darkocean.vim'.

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="darkocean"

hi Cursor         gui=None            guibg=#add8e6 ctermbg=152    guifg=#000000 ctermfg=0
hi CursorIM       gui=None            guibg=#add8e6 ctermbg=152    guifg=#000000 ctermfg=0
hi Directory      gui=None            guibg=bg         guifg=#20b2aa ctermfg=37
hi DiffAdd        gui=Bold            guibg=#7e354d ctermbg=95    guifg=fg
hi DiffChange     gui=Bold            guibg=#103040 ctermbg=235    guifg=#cc3300 ctermfg=166
hi DiffDelete     gui=Bold,Reverse    guibg=#7e354d ctermbg=95    guifg=fg
hi DiffText       gui=Bold            guibg=#d74141 ctermbg=167    guifg=fg
hi ErrorMsg       gui=None            guibg=#b22222 ctermbg=124    guifg=#ffffe0 ctermfg=230
hi VertSplit      gui=None            guibg=#999999 ctermbg=246    guifg=#000000 ctermfg=0
hi Folded         gui=Bold            guibg=#003366 ctermbg=23    guifg=#999999 ctermfg=246
hi FoldColumn     gui=Bold            guibg=#305070 ctermbg=239    guifg=#b0d0e0 ctermfg=152
hi IncSearch      gui=Bold            guibg=#8db6cd ctermbg=110    guifg=fg
hi LineNr         gui=Bold            guibg=#0f0f0f ctermbg=233    guifg=#8db6cd ctermfg=110
hi MoreMsg        gui=Bold            guibg=bg         guifg=#bf9261 ctermfg=137
hi ModeMsg        gui=Bold            guibg=bg         guifg=#4682b4 ctermfg=67
hi NonText        gui=None            guibg=#0f0f0f ctermbg=233    guifg=#87cefa ctermfg=117
hi Normal         gui=None            guibg=#000000 ctermbg=0    guifg=#e0ffff ctermfg=195
hi Question       gui=Bold            guibg=bg         guifg=#f4bb7e ctermfg=216
hi Search         gui=Bold            guibg=#607b8b ctermbg=66    guifg=#000000 ctermfg=0
hi SpecialKey     gui=None            guibg=bg         guifg=#63b8ff ctermfg=75
hi StatusLine     gui=Bold            guibg=#8db6cd ctermbg=110    guifg=#000000 ctermfg=0
hi StatusLineNC   gui=None            guibg=#607b8b ctermbg=66    guifg=#1a1a1a ctermfg=234
hi Title          gui=Bold            guibg=bg         guifg=#5cacee ctermfg=75
hi Visual         gui=Reverse         guibg=#ffffff ctermbg=15    guifg=#36648b ctermfg=60
hi VisualNOS      gui=Bold,Underline  guibg=#4682b4 ctermbg=67    guifg=fg
hi WarningMsg     gui=Bold            guibg=bg         guifg=#b22222 ctermfg=124
hi WildMenu       gui=Bold            guibg=#607b8b ctermbg=66    guifg=#000000 ctermfg=0
hi Comment        gui=None            guibg=#102520 ctermbg=234    guifg=#8db6cd ctermfg=110
hi Constant       gui=None            guibg=bg         guifg=#c34a2c ctermfg=130
hi Identifier     gui=None            guibg=bg         guifg=#009acd ctermfg=32
hi Statement      gui=None            guibg=bg         guifg=#72a5ee ctermfg=75
hi PreProc        gui=None            guibg=bg         guifg=#c12869 ctermfg=125
hi Include        gui=None            guibg=bg         guifg=#ccccff ctermfg=189
hi Type           gui=None            guibg=bg         guifg=#3b9c9c ctermfg=73
hi Error          gui=None            guibg=#b22222 ctermbg=124    guifg=#ffffe0 ctermfg=230
hi Todo           gui=None            guibg=#507080 ctermbg=60    guifg=#3bcccc ctermfg=80
hi Ignore         gui=None            guibg=bg         guifg=#777777 ctermfg=243
hi TagName        gui=None            guibg=#660000 ctermbg=52    guifg=#a7a7a7 ctermfg=248
