" Maintainer: Yoshimasa NIWA<niw@disense.com>
" Last Change: 14 Jun 2006
" Found at http://niw.at/articles/2006/08/06/twilight/en

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name="twilight"

hi Normal         guifg=#F8F8F8 ctermfg=15           guibg=#141414 ctermbg=233
hi Cursor         guifg=#F8F8F8 ctermfg=15           guibg=#A7A7A7 ctermbg=248
hi CursorIM       guifg=#F8F8F8 ctermfg=15           guibg=#5F5A60 ctermbg=59
hi Directory      guifg=#8F9D6A ctermfg=107           guibg=#141414 ctermbg=233
hi ErrorMsg       guifg=#CF6A4C ctermfg=167           guibg=#420E09 ctermbg=52
hi VertSplit      guifg=#AC885B ctermfg=137           guibg=#FFFFFF ctermbg=15
hi Folded         guifg=#F9EE98 ctermfg=228           guibg=#494949 ctermbg=238
hi IncSearch      guifg=#000000 ctermfg=0           guibg=#CF6A4C ctermbg=167
hi LineNr         guifg=#7587A6 ctermfg=103           guibg=#000000 ctermbg=0
hi ModeMsg        guifg=#CF7D34 ctermfg=173           guibg=#E9C062 ctermbg=179
hi MoreMsg        guifg=#CF7D34 ctermfg=173           guibg=#E9C062 ctermbg=179
hi NonText        guifg=#D2A8A1 ctermfg=181           guibg=#141414 ctermbg=233
hi Question       guifg=#7587A6 ctermfg=103           guibg=#0E2231 ctermbg=234
hi Search         guifg=#420E09 ctermfg=52           guibg=#CF6A4C ctermbg=167
hi SpecialKey     guifg=#CF7D34 ctermfg=173           guibg=#141414 ctermbg=233
hi StatusLine     guifg=#0E2231 ctermfg=234           guibg=#8693A5 ctermbg=103
hi StatusLineNC   guifg=#7587A6 ctermfg=103           guibg=#F8F8F8 ctermbg=15
hi Title          guifg=#8B98AB ctermfg=103           guibg=#0E2231 ctermbg=234
hi Visual         guifg=#0E2231 ctermfg=234           guibg=#AFC4DB ctermbg=152
hi WarningMsg     guifg=#CF6A4C ctermfg=167           guibg=#420E09 ctermbg=52
hi WildMenu       guifg=#AFC4DB ctermfg=152           guibg=#0E2231 ctermbg=234

"Syntax hilight groups

hi Comment        guifg=#8F9D6A ctermfg=107
hi Constant       guifg=#CF6A4C ctermfg=167
hi String         guifg=#8F9D6A ctermfg=107
hi Character      guifg=#E9C062 ctermfg=179
hi Number         guifg=#9B859D ctermfg=246
hi Boolean        guifg=#CF6A4C ctermfg=167
hi Float          guifg=#562D56 ctermfg=238
hi Identifier     guifg=#9B703F ctermfg=95
hi Function       guifg=#9B5C2E ctermfg=94
hi Statement      guifg=#CF7D34 ctermfg=173
hi Conditional    guifg=#9B703F ctermfg=95
hi Repeat         guifg=khaki
hi Label          guifg=#E9C062 ctermfg=179
hi Operator       guifg=#CF6A4C ctermfg=167
hi Keyword        guifg=#E9C062 ctermfg=179
hi Exception      guifg=khaki
hi PreProc        guifg=khaki4
hi Include        guifg=khaki4
hi Define         guifg=khaki1
hi Macro          guifg=#9B703F ctermfg=95
hi PreCondit      guifg=khaki3
hi Type           guifg=khaki3
hi StorageClass   guifg=tan
hi Structure      guifg=DarkGoldenrod
hi Typedef        guifg=khaki3
hi Special        guifg=IndianRed
hi SpecialChar    guifg=DarkGoldenrod
hi Tag            guifg=DarkKhaki
hi Delimiter      guifg=DarkGoldenrod
hi SpecialComment guifg=cornsilk
hi Debug          guifg=brown
hi Underlined     guifg=#Cf6A4C ctermfg=167
hi Ignore         guifg=#494949 ctermfg=238
hi Error          guifg=#CF6A4C ctermfg=167    guibg=#420E09 ctermbg=52
hi Todo           guifg=#7587A6 ctermfg=103    guibg=#0E2231 ctermbg=234
hi Pmenu          guifg=#141414 ctermfg=233    guibg=#CDA869 ctermbg=179
hi PmenuSel       guifg=#F8F8F8 ctermfg=15    guibg=#9B703F ctermbg=95
hi PmenuSbar      guibg=#DAEFA3 ctermbg=193
hi PmenuThumb     guifg=#8F9D6A ctermfg=107
