" Parser compiled on Fri 17 Aug 2012 05:14:04 PM CST,
" with VimPEG v0.2 and VimPEG Compiler v0.1
" from "grillzg.vimpeg"
" with the following grammar:

" ; Grill Expression Parser
" ; if [ condition ] [ true_action ]  -->  if ( condition ) { true_action }
" 
" ; Parser options {{{1
" .skip_white   = true
" .namespace    = 'grillz'
" .parser_name  = 'grillzg#parser'
" .root_element = 'grillz'
" .ignore_case  = false
" .debug        = false
" .verbose      = 0
" 
" grillz ::= open_condition | open_true_action | close_true_action | close_condition
" 
" open_condition    ::= kw '\[' -> #open_condition
" close_condition   ::= kw '(' b_expr* '\]' -> #close_condition
" open_true_action  ::= kw '(' p_expr* ')' '\[' -> #open_true_action
" close_true_action ::= kw '(' p_expr* ')' '{' b_expr* '\]' -> #close_true_action
" 
" balanced_b        ::= '\[' (!'\]' b_expr)* '\]'
" balanced_p        ::= '(' (!')' p_expr)* ')'
" 
" b_expr            ::= balanced_b | non_b_char
" p_expr            ::= balanced_p | non_p_char
" 
" non_b_char        ::= !'[\[\]]' '.'
" non_p_char        ::= !'[()]' '.'
" 
" kw                ::= 'if'

let s:p = vimpeg#parser({'root_element': 'grillz', 'skip_white': 1, 'ignore_case': 0, 'verbose': 0, 'parser_name': 'grillzg#parser', 'namespace': 'grillz', 'debug': 0})
call s:p.or(['open_condition', 'open_true_action', 'close_true_action', 'close_condition'],
      \{'id': 'grillz'})
call s:p.and(['kw', s:p.e('\[')],
      \{'id': 'open_condition', 'on_match': 'grillz#open_condition'})
call s:p.and(['kw', s:p.e('('), s:p.maybe_many('b_expr'), s:p.e('\]')],
      \{'id': 'close_condition', 'on_match': 'grillz#close_condition'})
call s:p.and(['kw', s:p.e('('), s:p.maybe_many('p_expr'), s:p.e(')'), s:p.e('\[')],
      \{'id': 'open_true_action', 'on_match': 'grillz#open_true_action'})
call s:p.and(['kw', s:p.e('('), s:p.maybe_many('p_expr'), s:p.e(')'), s:p.e('{'), s:p.maybe_many('b_expr'), s:p.e('\]')],
      \{'id': 'close_true_action', 'on_match': 'grillz#close_true_action'})
call s:p.and([s:p.e('\['), s:p.maybe_many(s:p.and([s:p.not_has(s:p.e('\]')), 'b_expr'])), s:p.e('\]')],
      \{'id': 'balanced_b'})
call s:p.and([s:p.e('('), s:p.maybe_many(s:p.and([s:p.not_has(s:p.e(')')), 'p_expr'])), s:p.e(')')],
      \{'id': 'balanced_p'})
call s:p.or(['balanced_b', 'non_b_char'],
      \{'id': 'b_expr'})
call s:p.or(['balanced_p', 'non_p_char'],
      \{'id': 'p_expr'})
call s:p.and([s:p.not_has(s:p.e('[\[\]]')), s:p.e('.')],
      \{'id': 'non_b_char'})
call s:p.and([s:p.not_has(s:p.e('[()]')), s:p.e('.')],
      \{'id': 'non_p_char'})
call s:p.e('if',
      \{'id': 'kw'})

let g:grillzg#parser = s:p.GetSym('grillz')
