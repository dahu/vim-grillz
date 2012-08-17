""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim library for short description
" Maintainer:	Barry Arthur <barry.arthur@gmail.com>
" Version:	0.1
" Description:	Long description.
" Last Change:	2012-08-17
" License:	Vim License (see :help license)
" Location:	autoload/grillz.vim
" Website:	https://github.com//grillz
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
"if exists("g:loaded_lib_grillz")
"      \ || v:version < 700
"      \ || v:version == 703 && !has('patch338')
"      \ || &compatible
"  let &cpo = s:save_cpo
"  finish
"endif
"let g:loaded_lib_grillz = 1

" Private Functions: {{{1
function! s:MyScriptLocalFunction()
  echom "change MyScriptLocalFunction"
endfunction

" Library Interface: {{{1
function! grillz#open_condition(args)
  return '('
endfunction

function! grillz#close_condition(args)
  return ')'
endfunction

function! grillz#open_true_action(args)
  return '{'
endfunction

function! grillz#close_true_action(args)
  return '}'
endfunction

" Teardown:{{{1
"reset &cpo back to users setting
let &cpo = s:save_cpo

" vim: set sw=2 sts=2 et fdm=marker:
