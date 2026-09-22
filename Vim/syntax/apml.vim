" Vim syntax file
" Language:     APML -- the Algodal Parser Machine Language
" Maintainer:   Algodal
"
" The word lists below are APML's RESERVED WORDS, and they are meant to match
" what the manual's Keywords chapter prints. A word missing here is not an error
" anywhere; it simply stops being coloured.

if exists("b:current_syntax")
  finish
endif

" ---- comments: `#` to end of line ------------------------------------------
syn match   apmlComment     "#.*$" contains=@Spell

" ---- literals ---------------------------------------------------------------
syn region  apmlString      start=+"+ skip=+\.+ end=+"+ contains=apmlEscape
syn match   apmlEscape      "\." contained
" a character literal: \x41, \u03A9, and their chains and ranges
syn match   apmlCharLit     "\[xu][0-9A-Fa-f]\+\%([,:][0-9A-Fa-f]\+\)*"
" a character BLOCK is a set of characters, never a regex
syn match   apmlBlock       "<[^>]*>"
syn match   apmlNumber      "\<\d\+\>"

" ---- an AST-map label, spent by the compiler and never in the binary --------
syn match   apmlLabel       "'[A-Za-z0-9_]\+'"

" ---- words ------------------------------------------------------------------
syn keyword apmlKeyword     program link parser config feat bindpow foreign
syn keyword apmlKeyword     node_id alias perm give if node
syn keyword apmlType        texvar numvar semvar scope
syn keyword apmlBuiltin     spc nl eol eof char error
syn keyword apmlLogic       AND OR NOT
syn keyword apmlBoolean     TRUE FALSE

" ---- called after `::` ------------------------------------------------------
syn match   apmlCall        "::\%(order\|oneof\|icase\|is\|not\|subkind\|part\|char_count\|to_num\|iter_steps\|first\|begin\|end\|clear\)\>"
syn match   apmlNamespace   "\<tex\%(::\)\@="
" binding to a precedence table at the call site: bp::-expr
syn match   apmlCall        "::-[A-Za-z_]\w*"

" ---- the name being defined, so a rule is findable by eye -------------------
syn match   apmlDefine      "^\s*[A-Za-z_]\w*\s*\ze\%(:=\|=[^=]\)"

" ---- `indent = _;` -- this action's body is C the host supplies -------------
syn match   apmlForeign     "\%(\w\)\@<!_\%(\w\)\@!"

" ---- operators. `.` between units is the inbetween skip, not punctuation ----
syn match   apmlOperator    ":=\|->\|=>\|::\|[=|/+*?:.!-]"

hi def link apmlComment     Comment
hi def link apmlString      String
hi def link apmlEscape      SpecialChar
hi def link apmlCharLit     Character
hi def link apmlBlock       Constant
hi def link apmlNumber      Number
hi def link apmlLabel       Identifier
hi def link apmlKeyword     Statement
hi def link apmlType        Type
hi def link apmlBuiltin     Function
hi def link apmlLogic       Operator
hi def link apmlBoolean     Boolean
hi def link apmlCall        Function
hi def link apmlNamespace   PreProc
hi def link apmlDefine      Function
hi def link apmlForeign     Special
hi def link apmlOperator    Operator

let b:current_syntax = "apml"
