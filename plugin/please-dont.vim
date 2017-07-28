command! PleaseDo :call PleaseDo()
command! PleaseDont :call PleaseDont()
let g:in_pleasedont_mode = 0

function! PleaseDont()
	if !g:in_pleasedont_mode
		" Save all mappings. These must only be saved if we weren't
		" already in pleasedont-mode, otherwise we'll overwrite our
		" old mappings.
		let g:in_pleasedont_mode = 1
		if !empty(maparg("}", "i"))
			let g:pleasedont_rightbracket = maparg("}", "i")
		else
			let g:pleasedont_rightbracket = "}"
		endif
		if !empty(maparg("{", "i"))
			let g:pleasedont_leftbracket = maparg("{", "i")
		else
			let g:pleasedont_leftbracket = "{"
		endif
		if !empty(maparg(";", "i"))                                             
			let g:pleasedont_semicolon = maparg(";", "i")
		else
			let g:pleasedont_semicolon = ";"
		endif
		let g:pleasedont_autoindent = &autoindent
		let g:pleasedont_cindent = &cindent
		let g:pleasedont_smartindent = &smartindent
		let g:pleasedont_indentexpr = &indentexpr
		let g:pleasedont_indentkeys = &indentkeys
		set noai nocin nosi inde=
	endif
	inoremap } <Esc>:call BadlyIndent()<CR>a}
	inoremap { <Esc>:call BadlyIndent()<CR>a{
	inoremap ; <Esc>:call BadlyIndent()<CR>a;

	if !exists('g:pleasedont_indent_col')
		let g:pleasedont_indent_col = 80
	end
endfunction

function! PleaseDo()
	let g:in_pleasedont_mode = 0
	" First, we restore all our indentation settings
	if exists('g:pleasedont_autoindent')
		" No idea what kind of dimwit thought, that being unable to set
		" boolean values with `set option=0` was a good idea. In case you
		" know, please tell me whether there's a way to set these without
		" getting carpal-tunnel-syndrome.
		if (g:pleasedont_autoindent)
			set autoindent
		else
			set noautoindent
		endif
		if (g:pleasedont_cindent)
			set cindent
		else
			set nocindent
		endif
		if (g:pleasedont_smartindent)
			set smartindent
		else
			set nosmartindent
		endif
		exe "set indentexpr=".g:pleasedont_indentexpr
		exe "set indentkeys=".g:pleasedont_indentkeys
	endif
	if exists('g:pleasedont_rightbracket')
		exe 'inoremap } ' . g:pleasedont_rightbracket
		exe 'inoremap { ' . g:pleasedont_leftbracket
		exe 'inoremap ; ' . g:pleasedont_semicolon
	endif
endfunction

function! BadlyIndent()
	let cursorpos = virtcol(".")
	if cursorpos < g:pleasedont_indent_col && (col(".") == len(getline(".")) || len(getline(".")) == 0)
		let indentation = repeat(" ", g:pleasedont_indent_col - cursorpos)
		call setline(".", getline(".") . indentation)
		normal $
	endif
endfunction
