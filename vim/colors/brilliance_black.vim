" Vim color file
" Converted from Textmate theme Brilliance Black using Coloration v0.2.4 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "Brilliance Black"

hi Cursor  guifg=NONE guibg=#3333ff ctermbg=12 gui=NONE
hi Visual  guifg=NONE guibg=#050f71 ctermbg=17 gui=NONE
hi CursorLine  guifg=NONE guibg=#0a0a24 ctermbg=233 gui=NONE
hi CursorColumn  guifg=NONE guibg=#0a0a24 ctermbg=233 gui=NONE
hi LineNr  guifg=#7e7e7e ctermfg=8 guibg=#0d0d0d ctermbg=233 gui=NONE
hi VertSplit  guifg=#383838 ctermfg=237 guibg=#383838 ctermbg=237 gui=NONE
hi MatchParen  guifg=#eeeeee ctermfg=7 guibg=NONE gui=NONE
hi StatusLine  guifg=#eeeeee ctermfg=7 guibg=#383838 ctermbg=237 gui=bold
hi StatusLineNC  guifg=#eeeeee ctermfg=7 guibg=#383838 ctermbg=237 gui=NONE
hi Pmenu  guifg=NONE guibg=NONE gui=NONE
hi PmenuSel  guifg=NONE guibg=#050f71 ctermbg=17 gui=NONE
hi IncSearch  guifg=NONE guibg=#575757 ctermbg=240 gui=NONE
hi Search  guifg=NONE guibg=#575757 ctermbg=240 gui=NONE
hi Directory  guifg=#00ff79 ctermfg=48 guibg=NONE gui=NONE
hi Folded  guifg=#4c4c4c ctermfg=239 guibg=#0d0d0d ctermbg=233 gui=NONE

hi Normal  guifg=#eeeeee ctermfg=7 guibg=#0d0d0d ctermbg=233 gui=NONE
hi Boolean  guifg=#07ff00 ctermfg=10 guibg=NONE gui=NONE
hi Character  guifg=#86ff00 ctermfg=118 guibg=NONE gui=NONE
hi Comment  guifg=#4c4c4c ctermfg=239 guibg=#151515 ctermbg=233 gui=NONE
hi Conditional  guifg=#f800ff ctermfg=13 guibg=NONE gui=NONE
hi Constant  guifg=NONE guibg=NONE gui=NONE
hi Define  guifg=NONE guibg=NONE gui=NONE
hi ErrorMsg  guifg=#330004 ctermfg=233 guibg=#ff0007 ctermbg=9 gui=bold
hi WarningMsg  guifg=#330004 ctermfg=233 guibg=#ff0007 ctermbg=9 gui=bold
hi Float  guifg=#c6ff00 ctermfg=190 guibg=NONE gui=NONE
hi Function  guifg=#ff0086 ctermfg=198 guibg=NONE gui=NONE
hi Identifier  guifg=#7e0080 ctermfg=90 guibg=NONE gui=NONE
hi Keyword  guifg=NONE guibg=NONE gui=NONE
hi Label  guifg=#fffc80 ctermfg=228 guibg=#24170a ctermbg=233 gui=NONE
hi NonText  guifg=#202020 ctermfg=234 guibg=#0a0a24 ctermbg=233 gui=NONE
hi Number  guifg=#c6ff00 ctermfg=190 guibg=NONE gui=NONE
hi Operator  guifg=#0000ce ctermfg=20 guibg=NONE gui=NONE
hi PreProc  guifg=#7900ff ctermfg=93 guibg=NONE gui=NONE
hi Special  guifg=#eeeeee ctermfg=7 guibg=NONE gui=NONE
hi SpecialKey  guifg=#202020 ctermfg=234 guibg=#0a0a24 ctermbg=233 gui=NONE
hi Statement  guifg=#f800ff ctermfg=13 guibg=NONE gui=NONE
hi StorageClass  guifg=#7e0080 ctermfg=90 guibg=NONE gui=NONE
hi String  guifg=#fffc80 ctermfg=228 guibg=#24170a ctermbg=233 gui=NONE
hi Tag  guifg=#565656 ctermfg=240 guibg=NONE gui=NONE
hi Title  guifg=#eeeeee ctermfg=7 guibg=NONE gui=bold
hi Todo  guifg=#4c4c4c ctermfg=239 guibg=#151515 ctermbg=233 gui=inverse,bold
hi Type  guifg=NONE guibg=NONE gui=NONE
hi Underlined  guifg=NONE guibg=NONE gui=underline
hi rubyClass  guifg=#f800ff ctermfg=13 guibg=NONE gui=NONE
hi rubyFunction  guifg=#ff0086 ctermfg=198 guibg=NONE gui=NONE
hi rubyInterpolationDelimiter  guifg=NONE guibg=NONE gui=NONE
hi rubySymbol  guifg=#00ff79 ctermfg=48 guibg=NONE gui=NONE
hi rubyConstant  guifg=#ff0000 ctermfg=9 guibg=#250a0a ctermbg=233 gui=NONE
hi rubyStringDelimiter  guifg=#fffc80 ctermfg=228 guibg=#24170a ctermbg=233 gui=NONE
hi rubyBlockParameter  guifg=#9799ff ctermfg=105 guibg=NONE gui=NONE
hi rubyInstanceVariable  guifg=#00ff79 ctermfg=48 guibg=#0a2423 ctermbg=234 gui=NONE
hi rubyInclude  guifg=#782ec1 ctermfg=91 guibg=NONE gui=NONE
hi rubyGlobalVariable  guifg=#31a6ff ctermfg=75 guibg=NONE gui=NONE
hi rubyRegexp  guifg=#fff800 ctermfg=11 guibg=#18240a ctermbg=234 gui=NONE
hi rubyRegexpDelimiter  guifg=#fff800 ctermfg=11 guibg=#18240a ctermbg=234 gui=NONE
hi rubyEscape  guifg=#86ff00 ctermfg=118 guibg=NONE gui=NONE
hi rubyControl  guifg=#f800ff ctermfg=13 guibg=NONE gui=NONE
hi rubyClassVariable  guifg=NONE guibg=NONE gui=NONE
hi rubyOperator  guifg=#0000ce ctermfg=20 guibg=NONE gui=NONE
hi rubyException  guifg=#782ec1 ctermfg=91 guibg=NONE gui=NONE
hi rubyPseudoVariable  guifg=#00ff79 ctermfg=48 guibg=#0a2423 ctermbg=234 gui=NONE
hi rubyRailsUserClass  guifg=#ff0000 ctermfg=9 guibg=#250a0a ctermbg=233 gui=NONE
hi rubyRailsARAssociationMethod  guifg=#782ec1 ctermfg=91 guibg=NONE gui=NONE
hi rubyRailsARMethod  guifg=#782ec1 ctermfg=91 guibg=NONE gui=NONE
hi rubyRailsRenderMethod  guifg=#782ec1 ctermfg=91 guibg=NONE gui=NONE
hi rubyRailsMethod  guifg=#782ec1 ctermfg=91 guibg=NONE gui=NONE
hi erubyDelimiter  guifg=#00fff8 ctermfg=14 guibg=#0c2525 ctermbg=234 gui=NONE
hi erubyComment  guifg=#4c4c4c ctermfg=239 guibg=#151515 ctermbg=233 gui=NONE
hi erubyRailsMethod  guifg=#782ec1 ctermfg=91 guibg=NONE gui=NONE
hi htmlTag  guifg=#333333 ctermfg=236 guibg=NONE gui=NONE
hi htmlEndTag  guifg=#333333 ctermfg=236 guibg=NONE gui=NONE
hi htmlTagName  guifg=#333333 ctermfg=236 guibg=NONE gui=NONE
hi htmlArg  guifg=#333333 ctermfg=236 guibg=NONE gui=NONE
hi htmlSpecialChar  guifg=#86ff00 ctermfg=118 guibg=NONE gui=NONE
hi javaScriptFunction  guifg=#7e0080 ctermfg=90 guibg=NONE gui=NONE
hi javaScriptRailsFunction  guifg=#782ec1 ctermfg=91 guibg=NONE gui=NONE
hi javaScriptBraces  guifg=NONE guibg=NONE gui=NONE
hi yamlKey  guifg=#565656 ctermfg=240 guibg=NONE gui=NONE
hi yamlAnchor  guifg=#31a6ff ctermfg=75 guibg=NONE gui=NONE
hi yamlAlias  guifg=#31a6ff ctermfg=75 guibg=NONE gui=NONE
hi yamlDocumentHeader  guifg=#ffbc80 ctermfg=216 guibg=NONE gui=NONE
hi cssURL  guifg=#fffc80 ctermfg=228 guibg=#24170a ctermbg=233 gui=NONE
hi cssFunctionName  guifg=#782ec1 ctermfg=91 guibg=NONE gui=NONE
hi cssColor  guifg=#00ff79 ctermfg=48 guibg=NONE gui=NONE
hi cssPseudoClassId  guifg=#7900ff ctermfg=93 guibg=NONE gui=NONE
hi cssClassName  guifg=#3d3d3d ctermfg=237 guibg=NONE gui=NONE
hi cssValueLength  guifg=#c6ff00 ctermfg=190 guibg=NONE gui=NONE
hi cssCommonAttr  guifg=#00fff8 ctermfg=14 guibg=NONE gui=NONE
hi cssBraces  guifg=NONE guibg=NONE gui=NONE
