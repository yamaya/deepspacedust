" Spacedust Revised Colorscheme
" Original Spacedust theme by	Mikkel Malmberg
"		- https://github.com/mhallendal/spacedust-theme
set background=dark
hi clear
if exists("syntax_on")
   syntax reset
endif
let g:colors_name = "deepspacedust"

" Default GUI Colours
"
" Light yellow: #ECF0C1 (default foreground)
" Background: #041E23
" Selection background: #06496F
" Line number: #244F61
" Active row background: #0F2930
" Brown: #6E5346 (comments)
" Dark orange: #E35B00 (class/interface/protocol names)
" Light orange: #CB7636 (property)
" Dark yellow: #EBC562 (keywords)
" Dark green: #008080 (typedef)
" Light green: #4A9D8F (strings)
" Dark blue: #09699D (macros)
" Light blue: #009FC5 (function name)
" Gutter background: #0F2930
"
let s:foreground = "ECF0C1"
let s:background = "041E23"
let s:selection = "06496F" " Selection background
let s:lineno = "244F61"
let s:line = "0F2930" " highlighted line (no line number)
let s:comment = "6E5346"
let s:brown = "CC7636"
let s:dark_orange = "E35B00" " class/interface/protocol names
let s:orange = "CB7636" " property
let s:yellow = "EBC562" " keywords
let s:yellow_green = "cdeb62"
let s:yellow1 = "f1d68f"
let s:dark_green = "008080" " typedef
let s:green = "4A9D8F" " strings, constant
let s:dark_blue = "09699D" " macros
let s:blue = "009FC5" " function namae
let s:window = "0F2930" " Gutter background (statusline, splitline)
let s:purple = "d33682" " none in spacedust original
let s:gray1 = "666666"
let s:folded = "333333"
let s:beige = "f4dea6"

" Console 256 Colours
if !has("gui_running")
	let s:background = "003333"
	let s:window = "003333"
	let s:line = "333333"
	let s:selection = "585858"
end

if has("gui_running") || &t_Co == 88 || &t_Co == 256
	" Returns an approximate grey index for the given grey level
	fun <SID>grey_number(x)
		if &t_Co == 88
			if a:x < 23
				return 0
			elseif a:x < 69
				return 1
			elseif a:x < 103
				return 2
			elseif a:x < 127
				return 3
			elseif a:x < 150
				return 4
			elseif a:x < 173
				return 5
			elseif a:x < 196
				return 6
			elseif a:x < 219
				return 7
			elseif a:x < 243
				return 8
			else
				return 9
			endif
		else
			if a:x < 14
				return 0
			else
				let l:n = (a:x - 8) / 10
				let l:m = (a:x - 8) % 10
				if l:m < 5
					return l:n
				else
					return l:n + 1
				endif
			endif
		endif
	endfun

	" Returns the actual grey level represented by the grey index
	fun <SID>grey_level(n)
		if &t_Co == 88
			if a:n == 0
				return 0
			elseif a:n == 1
				return 46
			elseif a:n == 2
				return 92
			elseif a:n == 3
				return 115
			elseif a:n == 4
				return 139
			elseif a:n == 5
				return 162
			elseif a:n == 6
				return 185
			elseif a:n == 7
				return 208
			elseif a:n == 8
				return 231
			else
				return 255
			endif
		else
			if a:n == 0
				return 0
			else
				return 8 + (a:n * 10)
			endif
		endif
	endfun

	" Returns the palette index for the given grey index
	fun <SID>grey_colour(n)
		if &t_Co == 88
			if a:n == 0
				return 16
			elseif a:n == 9
				return 79
			else
				return 79 + a:n
			endif
		else
			if a:n == 0
				return 16
			elseif a:n == 25
				return 231
			else
				return 231 + a:n
			endif
		endif
	endfun

	" Returns an approximate colour index for the given colour level
	fun <SID>rgb_number(x)
		if &t_Co == 88
			if a:x < 69
				return 0
			elseif a:x < 172
				return 1
			elseif a:x < 230
				return 2
			else
				return 3
			endif
		else
			if a:x < 75
				return 0
			else
				let l:n = (a:x - 55) / 40
				let l:m = (a:x - 55) % 40
				if l:m < 20
					return l:n
				else
					return l:n + 1
				endif
			endif
		endif
	endfun

	" Returns the actual colour level for the given colour index
	fun <SID>rgb_level(n)
		if &t_Co == 88
			if a:n == 0
				return 0
			elseif a:n == 1
				return 139
			elseif a:n == 2
				return 205
			else
				return 255
			endif
		else
			if a:n == 0
				return 0
			else
				return 55 + (a:n * 40)
			endif
		endif
	endfun

	" Returns the palette index for the given R/G/B colour indices
	fun <SID>rgb_colour(x, y, z)
		if &t_Co == 88
			return 16 + (a:x * 16) + (a:y * 4) + a:z
		else
			return 16 + (a:x * 36) + (a:y * 6) + a:z
		endif
	endfun

	" Returns the palette index to approximate the given R/G/B colour levels
	fun <SID>colour(r, g, b)
		" Get the closest grey
		let l:gx = <SID>grey_number(a:r)
		let l:gy = <SID>grey_number(a:g)
		let l:gz = <SID>grey_number(a:b)

		" Get the closest colour
		let l:x = <SID>rgb_number(a:r)
		let l:y = <SID>rgb_number(a:g)
		let l:z = <SID>rgb_number(a:b)

		if l:gx == l:gy && l:gy == l:gz
			" There are two possibilities
			let l:dgr = <SID>grey_level(l:gx) - a:r
			let l:dgg = <SID>grey_level(l:gy) - a:g
			let l:dgb = <SID>grey_level(l:gz) - a:b
			let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
			let l:dr = <SID>rgb_level(l:gx) - a:r
			let l:dg = <SID>rgb_level(l:gy) - a:g
			let l:db = <SID>rgb_level(l:gz) - a:b
			let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
			if l:dgrey < l:drgb
				" Use the grey
				return <SID>grey_colour(l:gx)
			else
				" Use the colour
				return <SID>rgb_colour(l:x, l:y, l:z)
			endif
		else
			" Only one possibility
			return <SID>rgb_colour(l:x, l:y, l:z)
		endif
	endfun

	" Returns the palette index to approximate the 'rrggbb' hex string
	fun <SID>rgb(rgb)
		let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
		let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
		let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

		return <SID>colour(l:r, l:g, l:b)
	endfun

	" Sets the highlighting for the given group
	fun <SID>X(group, fg, bg, attr)
		if a:fg != ""
			exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
		endif
		if a:bg != ""
			exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
		endif
		if a:attr != ""
			exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
		endif
	endfun

	" Vim highlighting
	call <SID>X('Normal', s:foreground, s:background, '')
	call <SID>X('LineNr', s:lineno, '', '')
	call <SID>X('NonText', s:selection, '', '')
	call <SID>X('SpecialKey', s:selection, '', '')
	call <SID>X('Search', s:background, s:yellow, 'bold')
	call <SID>X('TabLine', s:foreground, s:background, 'reverse')
	call <SID>X('StatusLine', s:window, s:yellow, 'reverse,bold')
	call <SID>X('StatusLineNC', s:window, s:foreground, 'reverse')
	call <SID>X('VertSplit', s:window, s:window, 'none')
	call <SID>X('Visual', '', s:selection, '')
	call <SID>X('Directory', s:blue, '', 'bold')
	call <SID>X('ModeMsg', s:green, '', '')
	call <SID>X('MoreMsg', s:green, '', '')
	call <SID>X('Question', s:green, '', '')
	call <SID>X('WarningMsg', s:dark_orange, '', '')
	call <SID>X('MatchParen', '', s:selection, '')
	call <SID>X('Folded', s:folded, s:background, '')
	call <SID>X('FoldColumn', '', s:background, '')
	call <SID>X('CursorLine', '', s:line, 'none')
	call <SID>X('CursorColumn', '', s:line, 'none')
	call <SID>X('PMenu', s:foreground, s:selection, 'none')
	call <SID>X('PMenuSel', s:foreground, s:selection, 'reverse')
	call <SID>X('SignColumn', s:brown, s:background, 'none')
	if version >= 703
		call <SID>X('ColorColumn', '', s:line, 'none')
	end

	" Standard Highlighting
	call <SID>X('Comment', s:comment, '', 'italic')
	call <SID>X('Constant', s:green, '', '')
	call <SID>X('Identifier', s:orange, '', 'none')
	call <SID>X('Function', s:blue, '', '')
	call <SID>X('Statement', s:yellow, '', 'bold')
	call <SID>X('Conditional', s:yellow, '', 'bold')
	call <SID>X('Repeat', s:yellow, '', 'bold')
	call <SID>X('Label', s:yellow, '', 'bold')
	call <SID>X('Operator', s:yellow, '', 'bold')
	call <SID>X('Keyword', s:yellow, '', 'bold')
	call <SID>X('Exception', s:yellow, '', 'bold')
	call <SID>X('PreProc', s:yellow, '', '')
	call <SID>X('Type', s:yellow, '', 'none')
	call <SID>X('Structure', s:yellow, '', 'bold')
	call <SID>X('Special', s:dark_orange, '', '')
	call <SID>X('SpecialChar', s:dark_orange, '', 'bold')
	call <SID>X('SpecialComment', s:purple, '', 'none')
	call <SID>X('Tag', s:brown, '', '')
	call <SID>X('Error', s:background, s:dark_orange, 'bold')
	call <SID>X('Todo', s:background, s:brown, 'bold')

	"
	call <SID>X("Title", s:yellow_green, "", "bold")
	call <SID>X("cCppOut", s:folded, "", "")
	call <SID>X("objcStorageClass", s:yellow_green, "", "")
	"call <SID>X("cBlocksBracket", s:yellow_green, "", "bold")
	"call <SID>X('cBlocksBracket', '', s:selection, 'bold')

	" Syntastic
	call <SID>X('SignColumn', s:brown, s:background, 'none')
	call <SID>X('SyntasticErrorSign', s:purple, s:background, 'bold')
	call <SID>X('SyntasticWarningSign', s:brown, s:background, 'bold')

	if 0
		" ShowMarks Highlighting
		call <SID>X("ShowMarksHLl", s:orange, s:background, "none")
		call <SID>X("ShowMarksHLo", s:purple, s:background, "none")
		call <SID>X("ShowMarksHLu", s:yellow, s:background, "none")
		call <SID>X("ShowMarksHLm", s:blue, s:background, "none")

		" Vim Highlighting
		call <SID>X("vimCommand", s:dark_orange, "", "none")

		" C Highlighting
		call <SID>X("cType", s:yellow, "", "")
		call <SID>X("cStorageClass", s:purple, "", "")
		call <SID>X("cConditional", s:purple, "", "")
		call <SID>X("cRepeat", s:purple, "", "")

		" PHP Highlighting
		call <SID>X("phpVarSelector", s:dark_orange, "", "")
		call <SID>X("phpKeyword", s:purple, "", "")
		call <SID>X("phpRepeat", s:purple, "", "")
		call <SID>X("phpConditional", s:purple, "", "")
		call <SID>X("phpStatement", s:purple, "", "")
		call <SID>X("phpMemberSelector", s:foreground, "", "")

		" Ruby Highlighting
		call <SID>X("rubySymbol", s:green, "", "")
		call <SID>X("rubyConstant", s:yellow, "", "")
		call <SID>X("rubyAttribute", s:blue, "", "")
		call <SID>X("rubyInclude", s:blue, "", "")
		call <SID>X("rubyLocalVariableOrMethod", s:orange, "", "")
		call <SID>X("rubyCurlyBlock", s:orange, "", "")
		call <SID>X("rubyStringDelimiter", s:green, "", "")
		call <SID>X("rubyInterpolationDelimiter", s:orange, "", "")
		call <SID>X("rubyConditional", s:purple, "", "")
		call <SID>X("rubyRepeat", s:purple, "", "")

		" Python Highlighting
		call <SID>X("pythonInclude", s:purple, "", "")
		call <SID>X("pythonStatement", s:purple, "", "")
		call <SID>X("pythonConditional", s:purple, "", "")
		call <SID>X("pythonFunction", s:blue, "", "")

		" JavaScript Highlighting
		call <SID>X("javaScriptBraces", s:foreground, "", "")
		call <SID>X("javaScriptFunction", s:purple, "", "")
		call <SID>X("javaScriptConditional", s:purple, "", "")
		call <SID>X("javaScriptRepeat", s:purple, "", "")
		call <SID>X("javaScriptNumber", s:orange, "", "")
		call <SID>X("javaScriptMember", s:orange, "", "")

		" Diff Highlighting
		call <SID>X("diffAdded", s:green, "", "")
		call <SID>X("diffRemoved", s:dark_orange, "", "")
	endif

	" Delete Functions
	delf <SID>X
	delf <SID>rgb
	delf <SID>colour
	delf <SID>rgb_colour
	delf <SID>rgb_level
	delf <SID>rgb_number
	delf <SID>grey_colour
	delf <SID>grey_level
	delf <SID>grey_number
endif

