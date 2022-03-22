highlight clear

" A hint: use `:highlight` to see currently applied highlights!

function s:highlight(group, bg, fg, style)
  let gui = a:style == '' ? '' : 'gui=' . a:style
  let fg = a:fg == '' ? '' : 'guifg=' . a:fg
  let bg = a:bg == '' ? '' : 'guibg=' . a:bg
  exec 'hi ' . a:group . ' ' . bg . ' ' . fg  . ' ' . gui
endfunction

" Color palette
let g:Color0 = '#888888'
let g:Color1 = '#ddd3cc'
let g:Color2 = '#ff669c'
let g:Color3 = '#ffb966'
let g:Color4 = '#e6ac00'
let g:Color5 = '#66ffbf'
let g:Color6 = '#a000ff'
let g:Color7 = '#00b4cc'
let g:Color8 = '#00a0ff'
let g:Color9 = '#ff2020'
let g:Color10 = '#000000'
let g:Color11 = '#44ff44'
let g:Color12 = '#ff4444'
let g:Color13 = '#595959'
let g:Color14 = '#ffffff'
let g:Color15 = '#ff7039'

" # General

call s:highlight('ColorColumn', g:Color13, '', '')
call s:highlight('Comment', '', g:Color0, 'italic')
call s:highlight('Conditional', '', g:Color2, 'bold')
call s:highlight('Constant', '', g:Color4, '')
call s:highlight('Cursor', g:Color1, g:Color10, '')
call s:highlight('CursorLineNr', '', g:Color14, '')
call s:highlight('DiffAdd', g:Color10, '', '')
call s:highlight('DiffChange', g:Color10, '', '')
call s:highlight('DiffDelete', g:Color12, g:Color10, '')
call s:highlight('DiffText', g:Color4, '', '')
call s:highlight('EndOfBuffer', '', g:Color10, '')
call s:highlight('Error', '', g:Color9, '')
call s:highlight('Folded', g:Color10, g:Color0, 'italic')
call s:highlight('FoldColumn', g:Color10, g:Color5, '')
call s:highlight('Function', '', g:Color7, '')
call s:highlight('Identifier', '', g:Color3, '')
call s:highlight('Keyword', '', g:Color2, 'bold')
call s:highlight('LineNr', '', g:Color0, '')
call s:highlight('LineNrAbove', '', g:Color0, '')
call s:highlight('LineNrBelow', '', g:Color0, '')
call s:highlight('Macro', '', g:Color7, '')
call s:highlight('NonText', '', g:Color0, 'italic')
call s:highlight('Normal', g:Color10, g:Color1, '')
call s:highlight('Number', '', g:Color6, '')
call s:highlight('Operator', '', g:Color2, 'bold')
call s:highlight('Pmenu', g:Color10, g:Color1, '')
call s:highlight('PmenuSel', g:Color4, g:Color10, '')
call s:highlight('PmenuThumb', g:Color10, g:Color4, '')
call s:highlight('Repeat', '', g:Color2, 'bold')
call s:highlight('SignColumn', g:Color10, '', '')
call s:highlight('SpellBad', '', '', 'underline guisp=' . g:Color0)
call s:highlight('StatusLine', g:Color1, g:Color10, '')
call s:highlight('StatusLineNC', g:Color1, g:Color10, '')
call s:highlight('String', '', g:Color5, '')
call s:highlight('TabLine', g:Color10, g:Color4, '')
call s:highlight('TabLineFill', g:Color10, g:Color4, '')
call s:highlight('TabLineSel', g:Color4, g:Color10, '')
call s:highlight('Type', '', g:Color8, '')
call s:highlight('VertSplit', g:Color13, g:Color10, '')
call s:highlight('Visual', g:Color13, '', '')
call s:highlight('Whitespace', '', g:Color0, 'italic')
call s:highlight('WildMenu', g:Color10, g:Color4, '')

" # NvimTree

" Tree
call s:highlight('NvimTreeEmptyFolderName', '', g:Color5, '')
call s:highlight('NvimTreeExecFile', '', g:Color7, '')
call s:highlight('NvimTreeFolderIcon', '', g:Color5, '')
call s:highlight('NvimTreeFolderName', '', g:Color5, '')
call s:highlight('NvimTreeImageFile', '', g:Color8, '')
call s:highlight('NvimTreeOpenedFile', '', g:Color4, '')
call s:highlight('NvimTreeOpenedFolderName', '', g:Color5, '')
call s:highlight('NvimTreeRootFolder', '', g:Color2, 'bold')
call s:highlight('NvimTreeSpecialFile', '', g:Color2, 'bold')
call s:highlight('NvimTreeSymlink', '', g:Color2, 'bold')

" Diagnostics
call s:highlight('LspDiagnosticsError', '', g:Color9, '')
call s:highlight('LspDiagnosticsHint', '', g:Color7, '')
call s:highlight('LspDiagnosticsInformation', '', g:Color5, '')
call s:highlight('LspDiagnosticsWarning', '', g:Color3, '')

" Git
call s:highlight('NvimTreeGitDeleted', '', g:Color12, '')
call s:highlight('NvimTreeGitDirty', '', g:Color4, '')
call s:highlight('NvimTreeGitMerge', '', g:Color2, '')
call s:highlight('NvimTreeGitNew', '', g:Color11, '')
call s:highlight('NvimTreeGitRenamed', '', g:Color6, '')
call s:highlight('NvimTreeGitStaged', '', g:Color15, '')

" # Feline

call s:highlight('FelineDiagnosticErrors', '', g:Color9, '')
call s:highlight('FelineDiagnosticHints', '', g:Color7, '')
call s:highlight('FelineDiagnosticInfo', '', g:Color5, '')
call s:highlight('FelineDiagnosticWarnings', '', g:Color3, '')
call s:highlight('FelineFileInfo', '', g:Color0, 'bold')
call s:highlight('FelineFileType', '', g:Color0, 'bold')
call s:highlight('FelineGitDiffAdded', '', g:Color11, '')
call s:highlight('FelineGitDiffChanged', '', g:Color3, '')
call s:highlight('FelineGitDiffRemoved', '', g:Color9, '')

" # Telescope

call s:highlight('TelescopeNormal', '', g:Color1, '')
call s:highlight('TelescopePromptPrefix', '', g:Color1, '')

" # GitSigns

call s:highlight('GitSignsAdd', g:Color10, g:Color11, '')
call s:highlight('GitSignsAddInline', g:Color11, g:Color10, '')
call s:highlight('GitSignsAddLn', g:Color10, g:Color1, '')
call s:highlight('GitSignsChange', g:Color10, g:Color4, '')
call s:highlight('GitSignsChangeInline', g:Color4, g:Color10, '')
call s:highlight('GitSignsDelete', g:Color10, g:Color12, '')
call s:highlight('GitSignsDeleteInline', g:Color12, g:Color10, '')

" # Crates

" General
call s:highlight('CratesNvimError', '', g:Color12, '')
call s:highlight('CratesNvimLoading', '', g:Color7, '')
call s:highlight('CratesNvimNoMatch', '', g:Color3, '')
call s:highlight('CratesNvimPreRelease', '', g:Color15, '')
call s:highlight('CratesNvimUpgrade', '', g:Color4, '')
call s:highlight('CratesNvimVersion', '', g:Color7, '')
call s:highlight('CratesNvimYanked', '', g:Color12, '')

" Popup
call s:highlight('CratesNvimPopupEnabled', '', g:Color11, '')
call s:highlight('CratesNvimPopupFeature', '', g:Color7, '')
call s:highlight('CratesNvimPopupPreRelease', '', g:Color15, '')
call s:highlight('CratesNvimPopupTitle', '', g:Color2, 'bold')
call s:highlight('CratesNvimPopupTransitive', '', g:Color8, '')
call s:highlight('CratesNvimPopupVersion', '', g:Color7, '')
call s:highlight('CratesNvimPopupYanked', '', g:Color12, '')

" # TreeSitter

" Misc
call s:highlight('TSError', '', g:Color9, '')
call s:highlight('TSPunctBracket', '', g:Color1, '')
call s:highlight('TSPunctDelimiter', '', g:Color2, '')
call s:highlight('TSPunctSpecial', '', g:Color1, '')

" Constants
call s:highlight('TSBoolean', '', g:Color6, '')
call s:highlight('TSCharacter', '', g:Color5, '')
call s:highlight('TSConstBuiltin', '', g:Color8, '')
call s:highlight('TSConstant', '', g:Color7, '')
call s:highlight('TSFloat', '', g:Color6, '')
call s:highlight('TSNamespace', '', g:Color3, '')
call s:highlight('TSNumber', '', g:Color6, '')
call s:highlight('TSString', '', g:Color5, '')
call s:highlight('TSStringEscape', '', g:Color8, '')
call s:highlight('TSStringRegex', '', g:Color5, '')
highlight TSAnnotation guifg=#DCDCAA
highlight TSAttribute guifg=#FF00FF
highlight TSConstMacro guifg=#4EC9B0

" Functions
call s:highlight('TSField', '', g:Color3, '')
call s:highlight('TSFuncBuiltin', '', g:Color7, '')
call s:highlight('TSFuncMacro', '', g:Color7, '')
call s:highlight('TSFunction', '', g:Color7, '')
call s:highlight('TSMethod', '', g:Color7, '')
call s:highlight('TSParameter', '', g:Color3, '')
call s:highlight('TSProperty', '', g:Color3, '')
highlight TSConstructor guifg=#4EC9B0
highlight TSParameterReference guifg=#9CDCFE

" Keywords
call s:highlight('TSConditional', '', g:Color2, 'bold')
call s:highlight('TSInclude', '', g:Color2, 'bold')
call s:highlight('TSKeyword', '', g:Color15, 'bold')
call s:highlight('TSKeywordFunction', '', g:Color15, 'bold')
call s:highlight('TSLabel', '', g:Color8, '')
call s:highlight('TSOperator', '', g:Color2, '')
call s:highlight('TSRepeat', '', g:Color2, 'bold')
call s:highlight('TSType', '', g:Color8, '')
call s:highlight('TSTypeBuiltin', '', g:Color8, '')
highlight TSException guifg=#C586C0
highlight TSKeywordOperator guifg=#569CD6
highlight TSStructure guifg=#FF00FF

" Variable
call s:highlight('TSVariable', '', g:Color3, '')
call s:highlight('TSVariableBuiltin', '', g:Color15, 'italic')

" Text
call s:highlight('TSEmphasis', '', g:Color15, 'italic')
call s:highlight('TSLiteral', '', g:Color5, 'italic')
call s:highlight('TSStrong', '', g:Color15, 'italic,bold')
highlight TSText guifg=#FF00FF
call s:highlight('TSTitle', '', g:Color2, 'bold')
call s:highlight('TSURI', '', g:Color1, 'underline')
highlight TSUnderline guifg=#FF00FF

" Tags
highlight TSTag guifg=#569CD6
highlight TSTagDelimiter guifg=#5C6370
