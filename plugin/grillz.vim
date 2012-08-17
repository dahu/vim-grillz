" Example VimPEG plugin for wicked grillz
" Maintainer:	Barry Arthur <barry.arthur@gmail.com>
" Version:	0.1
" Description:	if [ condition ] [ action ]  -->  if ( condition ) { action }
" Last Change:	2012-08-17
" License:	Vim License (see :help license)
" Location:	plugin/grillz.vim
" Website:	https://github.com/dahu/grillz
"
" See grillz.txt for help.  This can be accessed by doing:
"
" :helptags ~/.vim/doc
" :help grillz
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:grillz_version = '0.1'

" Vimscript Setup: {{{1
" Allow use of line continuation.
let s:save_cpo = &cpo
set cpo&vim

" load guard
" uncomment after plugin development
"if exists("g:loaded_grillz")
"      \ || v:version < 700
"      \ || v:version == 703 && !has('patch338')
"      \ || &compatible
"  let &cpo = s:save_cpo
"  finish
"endif
"let g:loaded_grillz = 1

" Private Functions: {{{1

function! s:Grillz(char)
  if search('^\s*if', 'bnW') > 0
    let line = getline('.') . a:char
    let grillz = g:grillzg#parser.match(line)
    if grillz.is_matched
      return grillz.value[0]
    else
      return a:char
    endif
  else
    return a:char
  endif
endfunction

" Maps: {{{1
inoremap <expr> [ <SID>Grillz('[')
inoremap <expr> ] <SID>Grillz(']')

" Teardown:{{{1
"reset &cpo back to users setting
let &cpo = s:save_cpo

" vim: set sw=2 sts=2 et fdm=marker:
