" Vim color file
" Converted from Textmate theme Mac Tweaks using Coloration v0.2.4 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "tm_tweaks"

hi Cursor  guifg=NONE guibg=#000000 ctermbg=0 gui=NONE
hi Visual  guifg=NONE guibg=#c6deff ctermbg=189 gui=NONE
hi CursorLine  guifg=NONE guibg=#ededed ctermbg=7 gui=NONE
hi CursorColumn  guifg=NONE guibg=#ededed ctermbg=7 gui=NONE
hi LineNr  guifg=#808080 ctermfg=244 guibg=#ffffff ctermbg=15 gui=NONE
hi VertSplit  guifg=#cfcfcf ctermfg=252 guibg=#cfcfcf ctermbg=252 gui=NONE
hi MatchParen  guifg=#0000ff ctermfg=21 guibg=NONE gui=bold
hi StatusLine  guifg=#000000 ctermfg=0 guibg=#cfcfcf ctermbg=252 gui=bold
hi StatusLineNC  guifg=#000000 ctermfg=0 guibg=#cfcfcf ctermbg=252 gui=NONE
hi Pmenu  guifg=NONE guibg=NONE gui=NONE
hi PmenuSel  guifg=NONE guibg=#c6deff ctermbg=189 gui=NONE
hi IncSearch  guifg=NONE guibg=#ababff ctermbg=147 gui=NONE
hi Search  guifg=NONE guibg=#ababff ctermbg=147 gui=NONE
hi Directory  guifg=#c5060b ctermfg=1 guibg=NONE gui=bold
hi Folded  guifg=#00b15c ctermfg=35 guibg=#ffffff ctermbg=15 gui=NONE

hi Normal  guifg=#000000 ctermfg=0 guibg=#ffffff ctermbg=15 gui=NONE
hi Boolean  guifg=#585cf6 ctermfg=12 guibg=NONE gui=bold
hi Character  guifg=#c5060b ctermfg=1 guibg=NONE gui=bold
hi Comment  guifg=#00b15c ctermfg=35 guibg=NONE gui=italic
hi Conditional  guifg=#0000ff ctermfg=21 guibg=NONE gui=bold
hi Constant  guifg=#c5060b ctermfg=1 guibg=NONE gui=bold
hi Define  guifg=#0000ff ctermfg=21 guibg=NONE gui=bold
hi ErrorMsg  guifg=#ffffff ctermfg=15 guibg=#990000 ctermbg=88 gui=NONE
hi WarningMsg  guifg=#ffffff ctermfg=15 guibg=#990000 ctermbg=88 gui=NONE
hi Float  guifg=#0000cd ctermfg=20 guibg=NONE gui=NONE
hi Function  guifg=#0000a2 ctermfg=19 guibg=NONE gui=bold
hi Identifier  guifg=#0000ff ctermfg=21 guibg=NONE gui=bold
hi Keyword  guifg=#0000ff ctermfg=21 guibg=NONE gui=bold
hi Label  guifg=#b830bb ctermfg=133 guibg=NONE gui=NONE
hi NonText  guifg=#bfbfbf ctermfg=250 guibg=#ededed ctermbg=7 gui=NONE
hi Number  guifg=#0000cd ctermfg=20 guibg=NONE gui=NONE
hi Operator  guifg=#0000ff ctermfg=21 guibg=NONE gui=bold
hi PreProc  guifg=#0000ff ctermfg=21 guibg=NONE gui=bold
hi Special  guifg=#000000 ctermfg=0 guibg=NONE gui=NONE
hi SpecialKey  guifg=#bfbfbf ctermfg=250 guibg=#ededed ctermbg=7 gui=NONE
hi Statement  guifg=#0000ff ctermfg=21 guibg=NONE gui=bold
hi StorageClass  guifg=#0000ff ctermfg=21 guibg=NONE gui=bold
hi String  guifg=#b830bb ctermfg=133 guibg=NONE gui=NONE
hi Tag  guifg=NONE guibg=NONE gui=NONE
hi Title  guifg=#000000 ctermfg=0 guibg=NONE gui=bold
hi Todo  guifg=#00b15c ctermfg=35 guibg=NONE gui=inverse,bold,italic
hi Type  guifg=NONE guibg=NONE gui=NONE
hi Underlined  guifg=NONE guibg=NONE gui=underline
hi rubyClass  guifg=#0000ff ctermfg=21 guibg=NONE gui=bold
hi rubyFunction  guifg=#0000a2 ctermfg=19 guibg=NONE gui=bold
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE
hi rubySymbol  guifg=#c5060b ctermfg=1 guibg=NONE gui=bold
hi rubyConstant  guifg=#6d79de ctermfg=68 guibg=NONE gui=bold
hi rubyStringDelimiter  guifg=#b830bb ctermfg=133 guibg=NONE gui=NONE
hi rubyBlockParameter  guifg=NONE guibg=NONE gui=NONE
hi rubyInstanceVariable  guifg=#d57925 ctermfg=172 guibg=NONE gui=NONE
hi rubyInclude  guifg=#0000ff ctermfg=21 guibg=NONE gui=bold
hi rubyGlobalVariable  guifg=#d57925 ctermfg=172 guibg=NONE gui=NONE
hi rubyRegexp  guifg=#b830bb ctermfg=133 guibg=NONE gui=NONE
hi rubyRegexpDelimiter  guifg=#b830bb ctermfg=133 guibg=NONE gui=NONE
hi rubyEscape  guifg=#26b31a ctermfg=34 guibg=NONE gui=NONE
hi rubyControl  guifg=#0000ff ctermfg=21 guibg=NONE gui=bold
hi rubyClassVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyOperator  guifg=#0000ff ctermfg=21 guibg=NONE gui=bold
hi rubyException  guifg=#0000ff ctermfg=21 guibg=NONE gui=bold
hi rubyPseudoVariable  guifg=#d57925 ctermfg=172 guibg=NONE gui=NONE
hi rubyRailsUserClass  guifg=#6d79de ctermfg=68 guibg=NONE gui=bold
hi rubyRailsARAssociationMethod  guifg=#3c4c72 ctermfg=240 guibg=NONE gui=bold
hi rubyRailsARMethod  guifg=#3c4c72 ctermfg=240 guibg=NONE gui=bold
hi rubyRailsRenderMethod  guifg=#3c4c72 ctermfg=240 guibg=NONE gui=bold
hi rubyRailsMethod  guifg=#3c4c72 ctermfg=240 guibg=NONE gui=bold
hi erubyDelimiter  guifg=NONE guibg=NONE gui=NONE
hi erubyComment  guifg=#00b15c ctermfg=35 guibg=NONE gui=italic
hi erubyRailsMethod  guifg=#3c4c72 ctermfg=240 guibg=NONE gui=bold
hi htmlTag  guifg=#1c02ff ctermfg=21 guibg=NONE gui=NONE
hi htmlEndTag  guifg=#1c02ff ctermfg=21 guibg=NONE gui=NONE
hi htmlTagName  guifg=#1c02ff ctermfg=21 guibg=NONE gui=NONE
hi htmlArg  guifg=#1c02ff ctermfg=21 guibg=NONE gui=NONE
hi htmlSpecialChar  guifg=#c5060b ctermfg=1 guibg=NONE gui=bold
hi javaScriptFunction  guifg=#0000ff ctermfg=21 guibg=NONE gui=bold
hi javaScriptRailsFunction  guifg=#3c4c72 ctermfg=240 guibg=NONE gui=bold
hi javaScriptBraces  guifg=NONE guibg=NONE gui=NONE
hi yamlKey  guifg=NONE guibg=NONE gui=NONE
hi yamlAnchor  guifg=#d57925 ctermfg=172 guibg=NONE gui=NONE
hi yamlAlias  guifg=#d57925 ctermfg=172 guibg=NONE gui=NONE
hi yamlDocumentHeader  guifg=NONE guibg=#f2f2f2 ctermbg=7 gui=NONE
hi cssURL  guifg=NONE guibg=NONE gui=NONE
hi cssFunctionName  guifg=#3c4c72 ctermfg=240 guibg=NONE gui=bold
hi cssColor  guifg=#c5060b ctermfg=1 guibg=NONE gui=bold
hi cssPseudoClassId  guifg=NONE guibg=NONE gui=NONE
hi cssClassName  guifg=NONE guibg=NONE gui=NONE
hi cssValueLength  guifg=#0000cd ctermfg=20 guibg=NONE gui=NONE
hi cssCommonAttr  guifg=#06960e ctermfg=28 guibg=NONE gui=bold
hi cssBraces  guifg=NONE guibg=NONE gui=NONE
