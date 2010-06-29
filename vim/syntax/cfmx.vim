" Vim syntax file
"    Language: ColdFusion MX
"  Maintainer: Brian Arnold (blarnol@sandia.gov)
" Last Change: December 1, 2005
"	Usage: Since ColdFusion has its own version of html comments,
"	       make sure that you put
"	       'let html_wrong_comments=1' in your _vimrc file.
"	Notes: Extends upon the ColdFusion syntax distributed with Vim

" For version 5.x, clear all syntax items.
" For version 6.x, quit when a syntax file was already loaded.
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Use all the stuff from the original html and cf syntax files.
if version < 600
  source <sfile>:p:h/cf.vim
else
  runtime! syntax/cf.vim
endif

" Tag names.
syn keyword cfTagName contained cffunction cfargument cfreturn
syn keyword cfTagName contained cfinvoke cfinvokeargument
syn keyword cfTagName contained cfcomponent
syn keyword cfTagName contained cfchart cfchartseries cfchartdata

" Legal arguments.
syn keyword cfArg contained access format item returncode returntype rotated
syn keyword cfArg contained scalefrom scaleto seriescolor serieslabel seriesplacement
syn keyword cfArg contained show3d tipstyle var xoffset yoffset

" Cold Fusion Functions.
syn keyword cfFunctionName CreateUUID

" Special processing for CF comments
syn region cfComments start=+<!---+ end=+--->+

" Define the default highlighting - cfComments only, as the rest are in cf.vim
" For version 5.x and earlier, only when not done already.
" For version 5.8 and later, only when and item doesn't have highlighting yet.
if version >= 508 || !exists("did_cf_syn_inits")
  if version < 508
    let did_cf_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink cfComments PreProc

  delcommand HiLink
endif

" Most of the other normal stuff will be handled by cf.vim, so we just adjust
" our current syntax here and we're set.
let b:current_syntax = "cfmx"

" vim: ts=8 sw=2
