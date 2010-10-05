" Vim color file
" Converted from Textmate theme Brilliance Dull using Coloration v0.2.4 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Brilliance Dull"

hi Cursor  guifg=NONE guibg=#7979b7 ctermbg=103 gui=NONE
hi Visual  guifg=NONE guibg=#111149 ctermbg=17 gui=NONE
hi CursorLine  guifg=NONE guibg=#050511 ctermbg=0 gui=NONE
hi CursorColumn  guifg=NONE guibg=#050511 ctermbg=0 gui=NONE
hi LineNr  guifg=#696969 ctermfg=242 guibg=#050505 ctermbg=0 gui=NONE
hi VertSplit  guifg=#2b2b2b ctermfg=235 guibg=#2b2b2b ctermbg=235 gui=NONE
hi MatchParen  guifg=#a459a5 ctermfg=133 guibg=NONE gui=NONE
hi StatusLine  guifg=#cdcdcd ctermfg=252 guibg=#2b2b2b ctermbg=235 gui=bold
hi StatusLineNC  guifg=#cdcdcd ctermfg=252 guibg=#2b2b2b ctermbg=235 gui=NONE
hi Pmenu  guifg=NONE guibg=NONE gui=NONE
hi PmenuSel  guifg=NONE guibg=#111149 ctermbg=17 gui=NONE
hi IncSearch  guifg=NONE guibg=#39213a ctermbg=236 gui=NONE
hi Search  guifg=NONE guibg=#39213a ctermbg=236 gui=NONE
hi Directory  guifg=#57a57d ctermfg=72 guibg=NONE gui=NONE
hi Folded  guifg=#333333 ctermfg=236 guibg=#050505 ctermbg=0 gui=NONE

hi Normal  guifg=#cdcdcd ctermfg=252 guibg=#050505 ctermbg=0 gui=NONE
hi Boolean  guifg=#59a559 ctermfg=71 guibg=NONE gui=NONE
hi Character  guifg=#80a659 ctermfg=107 guibg=NONE gui=NONE
hi Comment  guifg=#333333 ctermfg=236 guibg=NONE gui=NONE
hi Conditional  guifg=#a459a5 ctermfg=133 guibg=#10041e ctermbg=233 gui=NONE
hi Constant  guifg=NONE guibg=NONE gui=NONE
hi Define  guifg=#a459a5 ctermfg=133 guibg=NONE gui=NONE
hi ErrorMsg  guifg=#211211 ctermfg=233 guibg=#a7595a ctermbg=131 gui=bold
hi WarningMsg  guifg=#211211 ctermfg=233 guibg=#a7595a ctermbg=131 gui=bold
hi Float  guifg=#95a658 ctermfg=107 guibg=NONE gui=NONE
hi Function  guifg=#a75980 ctermfg=132 guibg=NONE gui=NONE
hi Identifier  guifg=#a77d58 ctermfg=137 guibg=NONE gui=NONE
hi Keyword  guifg=#a459a5 ctermfg=133 guibg=NONE gui=NONE
hi Label  guifg=#d2d1ab ctermfg=187 guibg=#1e1004 ctermbg=233 gui=NONE
hi NonText  guifg=#191919 ctermfg=234 guibg=#050511 ctermbg=0 gui=NONE
hi Number  guifg=#95a658 ctermfg=107 guibg=NONE gui=NONE
hi Operator  guifg=#7979b7 ctermfg=103 guibg=NONE gui=bold
hi PreProc  guifg=#a459a5 ctermfg=133 guibg=NONE gui=NONE
hi Special  guifg=#cdcdcd ctermfg=252 guibg=NONE gui=NONE
hi SpecialKey  guifg=#191919 ctermfg=234 guibg=#050511 ctermbg=0 gui=NONE
hi Statement  guifg=#a459a5 ctermfg=133 guibg=#10041e ctermbg=233 gui=NONE
hi StorageClass  guifg=#a77d58 ctermfg=137 guibg=NONE gui=NONE
hi String  guifg=#d2d1ab ctermfg=187 guibg=#1e1004 ctermbg=233 gui=NONE
hi Tag  guifg=#505050 ctermfg=239 guibg=NONE gui=NONE
hi Title  guifg=#cdcdcd ctermfg=252 guibg=NONE gui=bold
hi Todo  guifg=#333333 ctermfg=236 guibg=NONE gui=inverse,bold
hi Type  guifg=NONE guibg=NONE gui=NONE
hi Underlined  guifg=NONE guibg=NONE gui=underline
hi rubyClass  guifg=#a459a5 ctermfg=133 guibg=#10041e ctermbg=233 gui=NONE
hi rubyFunction  guifg=#a75980 ctermfg=132 guibg=NONE gui=NONE
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE
hi rubySymbol  guifg=#57a57d ctermfg=72 guibg=NONE gui=NONE
hi rubyConstant  guifg=#a7595a ctermfg=131 guibg=#1e0405 ctermbg=233 gui=NONE
hi rubyStringDelimiter  guifg=#d2d1ab ctermfg=187 guibg=#1e1004 ctermbg=233 gui=NONE
hi rubyBlockParameter  guifg=#abacd2 ctermfg=146 guibg=#10041e ctermbg=233 gui=NONE
hi rubyInstanceVariable  guifg=#5e6b6b ctermfg=241 guibg=NONE gui=NONE
hi rubyInclude  guifg=#8d809d ctermfg=103 guibg=NONE gui=NONE
hi rubyGlobalVariable  guifg=#5780a6 ctermfg=67 guibg=NONE gui=NONE
hi rubyRegexp  guifg=#a6a458 ctermfg=143 guibg=#111e04 ctermbg=233 gui=NONE
hi rubyRegexpDelimiter  guifg=#a6a458 ctermfg=143 guibg=#111e04 ctermbg=233 gui=NONE
hi rubyEscape  guifg=#80a659 ctermfg=107 guibg=NONE gui=NONE
hi rubyControl  guifg=#a459a5 ctermfg=133 guibg=#10041e ctermbg=233 gui=NONE
hi rubyClassVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyOperator  guifg=#7979b7 ctermfg=103 guibg=NONE gui=bold
hi rubyException  guifg=#8d809d ctermfg=103 guibg=NONE gui=NONE
hi rubyPseudoVariable  guifg=#5e6b6b ctermfg=241 guibg=NONE gui=NONE
hi rubyRailsUserClass  guifg=#a7595a ctermfg=131 guibg=#1e0405 ctermbg=233 gui=NONE
hi rubyRailsARAssociationMethod  guifg=#634683 ctermfg=60 guibg=NONE gui=NONE
hi rubyRailsARMethod  guifg=#634683 ctermfg=60 guibg=NONE gui=NONE
hi rubyRailsRenderMethod  guifg=#634683 ctermfg=60 guibg=NONE gui=NONE
hi rubyRailsMethod  guifg=#634683 ctermfg=60 guibg=NONE gui=NONE
hi erubyDelimiter  guifg=#56a5a4 ctermfg=73 guibg=#051e1d ctermbg=233 gui=NONE
hi erubyComment  guifg=#333333 ctermfg=236 guibg=NONE gui=NONE
hi erubyRailsMethod  guifg=#634683 ctermfg=60 guibg=NONE gui=NONE
hi htmlTag  guifg=#333333 ctermfg=236 guibg=NONE gui=NONE
hi htmlEndTag  guifg=#333333 ctermfg=236 guibg=NONE gui=NONE
hi htmlTagName  guifg=#333333 ctermfg=236 guibg=NONE gui=NONE
hi htmlArg  guifg=#333333 ctermfg=236 guibg=NONE gui=NONE
hi htmlSpecialChar  guifg=#80a659 ctermfg=107 guibg=NONE gui=NONE
hi javaScriptFunction  guifg=#a77d58 ctermfg=137 guibg=NONE gui=NONE
hi javaScriptRailsFunction  guifg=#634683 ctermfg=60 guibg=NONE gui=NONE
hi javaScriptBraces  guifg=#ffffff ctermfg=15 guibg=NONE gui=bold
hi yamlKey  guifg=#505050 ctermfg=239 guibg=NONE gui=NONE
hi yamlAnchor  guifg=#5780a6 ctermfg=67 guibg=NONE gui=NONE
hi yamlAlias  guifg=#5780a6 ctermfg=67 guibg=NONE gui=NONE
hi yamlDocumentHeader  guifg=#d2beab ctermfg=181 guibg=NONE gui=NONE
hi cssURL  guifg=#d2d1ab ctermfg=187 guibg=#1e1004 ctermbg=233 gui=NONE
hi cssFunctionName  guifg=#634683 ctermfg=60 guibg=NONE gui=NONE
hi cssColor  guifg=#57a57d ctermfg=72 guibg=NONE gui=NONE
hi cssPseudoClassId  guifg=#7c58a5 ctermfg=97 guibg=NONE gui=NONE
hi cssClassName  guifg=#373737 ctermfg=237 guibg=NONE gui=NONE
hi cssValueLength  guifg=#95a658 ctermfg=107 guibg=NONE gui=NONE
hi cssCommonAttr  guifg=#56a5a4 ctermfg=73 guibg=NONE gui=NONE
hi cssBraces  guifg=NONE guibg=NONE gui=NONE
