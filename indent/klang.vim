" Vim indent file
" Pascal indent file used as base
" Language:    Kymdata K
" Maintainer:  Tuomas Jaakola <tuomas.jaakola@iki.fi>
" Created:     2016 Nov 7


if exists("b:did_indent")
	finish
endif
let b:did_indent = 1

setlocal indentexpr=GetKLangIndent(v:lnum)
setlocal indentkeys&
setlocal indentkeys+==END,=CONST,=TYPE,=VAR,=BEGIN,=REPEAT,=UNTIL,=FOR
setlocal indentkeys+==PROGRAM,=FUNCTION,=PROCEDURE
setlocal indentkeys+==IF,=ELSE,=CASE,=WHILE

if exists("*GetKLangIndent")
	finish
endif


function! s:GetPrevNonCommentLineNum( line_num )

	" Skip lines starting with a comment
	let SKIP_LINES = '^\s*\(\((\*\)\|\(\*\ \)\|\(\*)\)\|{\|}\)'

	let nline = a:line_num
	while nline > 0
		let nline = prevnonblank(nline-1)
		if getline(nline) !~? SKIP_LINES
			break
		endif
	endwhile

	return nline
endfunction


function! GetKLangIndent( line_num )
	" Line 0 always goes at column 0
	if a:line_num == 0
		return 0
	endif

	let this_codeline = getline( a:line_num )

	" If in the middle of a three-part comment
	if this_codeline =~ '^\s*\*'
		return indent( a:line_num )
	endif

	let prev_codeline_num = s:GetPrevNonCommentLineNum( a:line_num )
	let prev_codeline = getline( prev_codeline_num )
	let indnt = indent( prev_codeline_num )

	" Compiler directives should always go in column zero.
	if this_codeline =~ '^\s*{\(\$IFDEF\|\$ELSE\|\$ENDIF\)'
		return 0
	endif

	" These items have nothing before or after (not even a comment), and
	" go on column 0. Make sure that the ^\s* is followed by \( to make
	" ORs work properly, and not include the start of line (this must
	" always appear).
	" The bracketed expression with the underline is a routine
	" separator. This is one case where we do indent comment lines.
	if this_codeline =~ '^\s*\((\*\ _\+\ \*)\|\<\(const\|var\)\>\)$'
		return 0
	endif

	" These items may have text after them, and go on column 0 (in most
	" cases). The problem is that "function" and "procedure" keywords
	" should be indented if within a class declaration.
	if this_codeline =~ '^\s*\<\(PROGRAM\|PROCEDURE\|FUNCTION\)\>'
		return 0
	endif

	" BEGIN
	" If the begin does not come after "if", "for", or "else", then it
	" goes in column 0
	if this_codeline =~ '^\s*BEGIN\>' && prev_codeline !~ '^\s*\<\(IF\|FOR\|ELSE\)\>'
		return 0
	endif

	" If the previous line was indenting...
	if prev_codeline =~ '^\s*\<\(FOR\|IF\|CASE\|ELSE\|END\ ELSE\)\>'
		" then indent.
		let indnt = indnt + &shiftwidth
		" BUT... if this is the start of a multistatement block then we
		" need to align the begin with the previous line.
		if this_codeline =~ '^\s*BEGIN\>'
			return indnt - &shiftwidth
		endif

		" We also need to keep the indentation level constant if the
		" whole if-then statement was on one line.
		if prev_codeline =~ '\<THEN\>.\+'
			let indnt = indnt - &shiftwidth
		endif
	endif

	" PREVIOUS-LINE BEGIN
	" If the previous line was an indenting keyword then indent once...
	if prev_codeline =~ '^\s*\<\(CONST\|VAR\|BEGIN\|REPEAT\|PRIVATE\|WHILE\)\>'
		" But only if this is another var in a list.
		if this_codeline !~ '^\s*VAR\>'
			return indnt + &shiftwidth
		endif
	endif

	" PREVIOUS-LINE BEGIN
	" Indent code after a case statement begin
	if prev_codeline =~ '\:\ BEGIN\>'
		return indnt + &shiftwidth
	endif

	" If we just closed a bracket that started on a previous line, then
	" unindent. But don't return yet -- we need to check for further
	" unindentation (for end/until/else)
	if prev_codeline =~ '^[^(]*[^*])'
		let indnt = indnt - &shiftwidth
	endif

	" At the end of a block, we have to unindent both the current line
	" (the "end" for instance) and the newly-created line.
	if this_codeline =~ '^\s*\<\(END\|UNTIL\|ELSE\)\>'
		return indnt - &shiftwidth
	endif

	" If we have opened a bracket and it continues over one line,
	" then indent once.
	"
	" RE = an opening bracket followed by any amount of anything other
	" than a closing bracket and then the end-of-line.
	"
	" If we didn't include the end of line, this RE would match even
	" closed brackets, since it would match everything up to the closing
	" bracket.
	"
	" This test isn't clever enough to handle brackets inside strings or
	" comments.
	if prev_codeline =~ '([^*]\=[^)]*$'
		return indnt + &shiftwidth
	endif

	return indnt
endfunction
