-- Lucid color scheme

-- A Lush port of https://github.com/cseelus/vim-colors-lucid

-- Lush: https://github.com/rktjmp/lush.nvim
-- Highlight groups reference: https://github.com/rktjmp/lush-template/blob/main/lua/lush_theme/lush_template.lua

local lush = require("lush")
local hsl = lush.hsl

local colors = {
  rock_dark = hsl(0, 0, 0),
  rock = hsl(263, 25, 10),
  rock_medium = hsl(262, 10, 22),
  gray_dark = hsl(261, 10, 34),
  gray = hsl(261, 8, 53),
  gray_medium = hsl(258, 16, 76),
  cloud = hsl(258, 27, 90),
  turquoise = hsl(158, 56, 52),
  fluoric = hsl(107, 100, 88),
  cyan = hsl(181, 100, 80),
  steel = hsl(212, 46, 67),
  powder = hsl(196, 51, 71),
  purple = hsl(243, 49, 62),
  sky = hsl(187, 58, 81),
  pink = hsl(323, 100, 43),
  sap = hsl(47, 96, 81),
}

---@diagnostic disable: undefined-global
local spec = lush(function()
  return {
    SpecialKey({ fg = colors.purple }),
    TermCursor({ gui = "reverse" }),
    TermCursorNC({ TermCursor }),
    NonText({ fg = colors.gray_dark }),
    EndOfBuffer({ NonText }),
    Whitespace({ NonText }),
    Directory({ fg = colors.fluoric }),
    ErrorMsg({ fg = colors.rock_dark, bg = colors.pink }),
    NvimInvalidSpacing({ ErrorMsg }),
    IncSearch({ gui = "reverse" }),
    Visual({ bg = colors.rock_medium }),
    Search({ bg = Visual.bg }),
    QuickFixLine({ Search }),
    Substitute({ Search }),
    MoreMsg({ fg = "seagreen", gui = "bold" }),
    ModeMsg({ fg = colors.turquoise, gui = "bold" }),
    LineNr({ fg = colors.gray_dark, bg = colors.rock_dark }),
    LineNrAbove({ LineNr }),
    LineNrBelow({ LineNr }),
    CursorLineNr({ fg = colors.gray_medium, bg = colors.rock_dark, gui = "bold" }),
    Question({ fg = "green", gui = "bold" }),
    StatusLine({ fg = colors.gray, bg = colors.rock }),
    MsgSeparator({ StatusLine }),
    StatusLineNC({ fg = colors.gray_dark, bg = colors.rock }),
    VertSplit({ fg = colors.rock, bg = colors.rock }),
    WinSeparator({ VertSplit }),
    Title({ fg = colors.pink, gui = "bold" }),
    TSTitle({ Title }),
    ptSection({ Title }),
    StartifySection({ Title }),
    texSection({ Title }),
    WarningMsg({ fg = colors.rock_dark, bg = colors.steel }),
    TSDanger({ WarningMsg }),
    vimWarn({ WarningMsg }),
    WildMenu({ fg = "black", bg = "yellow" }),
    Folded({ fg = colors.cloud, bg = colors.rock }),
    vimFold({ Folded }),
    FoldColumn({ bg = colors.rock_dark }),
    CursorLineFold({ FoldColumn }),
    SignColumn({ bg = colors.rock_dark }),
    CursorLineSign({ SignColumn }),
    Conceal({ fg = colors.sap, gui = "bold" }),
    SpellBad({ sp = "red", gui = "undercurl" }),
    SpellCap({ sp = "blue", gui = "undercurl" }),
    SpellRare({ sp = "magenta", gui = "undercurl" }),
    SpellLocal({ sp = "cyan", gui = "undercurl" }),
    TabLine({ gui = "underline", bg = "darkgrey" }),
    TabLineSel({ gui = "bold" }),
    TabLineFill({ gui = "reverse" }),
    CursorColumn({ bg = colors.rock_medium }),
    CursorLine({ bg = colors.rock_dark }),
    ColorColumn({ fg = colors.rock_dark, bg = colors.pink }),
    Cursor({ fg = "bg", bg = "fg" }),
    RedrawDebugNormal({ gui = "reverse" }),
    RedrawDebugClear({ bg = "yellow" }),
    RedrawDebugComposed({ bg = "green" }),
    RedrawDebugRecompose({ bg = "red" }),
    lCursor({ fg = "bg", bg = "fg" }),
    Normal({ fg = colors.cloud, bg = colors.rock_dark }),
    NormalNC({ Normal }),
    FloatBorder({ Normal }),
    NvimSpacing({ Normal }),
    vimUserFunc({ Normal }),
    vimEmbedError({ Normal }),
    NerdTreeDir({ Normal }),
    ptTask({ Normal }),
    phpParent({ Normal }),
    Pmenu({ Normal }),
    NormalFloat({ Pmenu }),
    PmenuSel({ fg = colors.rock_dark, bg = colors.turquoise }),
    PmenuSbar({ bg = colors.rock_dark }),
    PmenuThumb({ bg = "white" }),
    FloatShadow({ bg = "black", blend = 80 }),
    FloatShadowThrough({ bg = "black", blend = 100 }),
    Error({ fg = colors.rock_dark, bg = colors.pink }),
    NvimInvalid({ Error }),
    luaParenError({ Error }),
    luaBraceError({ Error }),
    luaError({ Error }),
    vimOperError({ Error }),
    vimUserAttrbError({ Error }),
    vimUserCmdError({ Error }),
    vimElseIfErr({ Error }),
    vimSynError({ Error }),
    vimSyncError({ Error }),
    vimError({ Error }),
    Todo({ fg = colors.rock_dark, bg = colors.powder }),
    TSWarning({ Todo }),
    TSTodo({ Todo }),
    luaTodo({ Todo }),
    vimTodo({ Todo }),
    String({ fg = colors.fluoric }),
    NvimString({ String }),
    TSLiteral({ String }),
    TSString({ String }),
    TSStringRegex({ String }),
    luaString2({ String }),
    luaString({ String }),
    vimString({ String }),
    gitcommitSummary({ String }),
    cssAttr({ String }),
    texInputFileOpt({ String }),
    Constant({ fg = colors.turquoise, gui = "bold" }),
    TSConstant({ Constant }),
    TSTextReference({ Constant }),
    luaConstant({ Constant }),
    gitcommitBranch({ Constant }),
    htmlTagName({ Constant }),
    jsClassDefinition({ Constant }),
    texDocType({ Constant }),
    rubyConstant({ Constant }),
    Number({ fg = colors.turquoise }),
    Boolean({ Number }),
    Float({ Number }),
    NvimNumber({ Number }),
    TSNumber({ Number }),
    luaNumber({ Number }),
    vimNumber({ Number }),
    vimMark({ Number }),
    vimHiNmbr({ Number }),
    ptCompleteTask({ Number }),
    Function({ fg = colors.steel }),
    Character({ Function }),
    Include({ Function }),
    TSFunction({ Function }),
    TSMethod({ Function }),
    luaFunction({ Function }),
    vimCmdSep({ Function }),
    vimFuncName({ Function }),
    CtrlPMatch({ Function }),
    NerdTreeHelpKey({ Function }),
    coffeeExtendedOp({ Function }),
    coffeeObjAssign({ Function }),
    coffeeParen({ Function }),
    hamlTag({ Function }),
    javascriptFuncArg({ Function }),
    javascriptFuncComma({ Function }),
    javascriptParens({ Function }),
    javascriptEndcolons({ Function }),
    jsExtendsKeyword({ Function }),
    jsFuncCall({ Function }),
    jsonKeyword({ Function }),
    texDocTypeArgs({ Function }),
    texStatement({ Function }),
    rubyCallback({ Function }),
    rubyEntity({ Function }),
    rubyMacro({ Function }),
    yamlBlockMappingKey({ Function }),
    xmlEndTag({ Function }),
    Identifier({ fg = colors.sky }),
    NvimIdentifier({ Identifier }),
    TSField({ Identifier }),
    TSParameter({ Identifier }),
    TSProperty({ Identifier }),
    TSSymbol({ Identifier }),
    luaFunc({ Identifier }),
    vimVar({ Identifier }),
    vimSpecFile({ Identifier }),
    vimFuncVar({ Identifier }),
    cssProp({ Identifier }),
    cssSelectorOp({ Identifier }),
    jsModuleKeyword({ Identifier }),
    jsNull({ Identifier }),
    jsObjectKey({ Identifier }),
    mkdCode({ Identifier }),
    mkdIndentCode({ Identifier }),
    MatchTag({ Identifier }),
    phpVarSelector({ Identifier }),
    sassIdChar({ Identifier }),
    Conditional({ fg = colors.cyan }),
    TSConditional({ Conditional }),
    luaElse({ Conditional }),
    luaCond({ Conditional }),
    Statement({ fg = colors.turquoise }),
    Repeat({ Statement }),
    Label({ Statement }),
    Keyword({ Statement }),
    luaStatement({ Statement }),
    vimCommand({ Statement }),
    vimSetSep({ Statement }),
    vimSearchDelim({ Statement }),
    vimKeyword({ Statement }),
    vimStatement({ Statement }),
    gitcommitSelectedFile({ Statement }),
    NerdTreeCWD({ Statement }),
    NerdTreeHelpTitle({ Statement }),
    NerdTreeOpenable({ Statement }),
    NerdTreeClosable({ Statement }),
    NerdTreeDirSlash({ Statement }),
    StartifyNumber({ Statement }),
    StartifyBracket({ Statement }),
    coffeeObject({ Statement }),
    javascriptFuncDef({ Statement }),
    javascriptFuncKeyword({ Statement }),
    texMathMatcher({ Statement }),
    rubyControl({ Statement }),
    PreProc({ fg = colors.pink }),
    Operator({ PreProc }),
    Exception({ PreProc }),
    Define({ PreProc }),
    Macro({ PreProc }),
    PreCondit({ PreProc }),
    TSAnnotation({ PreProc }),
    TSAttribute({ PreProc }),
    TSPreProc({ PreProc }),
    vimOption({ PreProc }),
    vimEnvvar({ PreProc }),
    vimMenuName({ PreProc }),
    vimHiAttrib({ PreProc }),
    vimCommentTitle({ PreProc }),
    vimHLMod({ PreProc }),
    apacheDeclaration({ PreProc }),
    jsClassKeyword({ PreProc }),
    jsTemplateBraces({ PreProc }),
    rubyKeyword({ PreProc }),
    StorageClass({ fg = colors.cloud, gui = "bold" }),
    TSStorageClass({ StorageClass }),
    StartifyFile({ StorageClass }),
    rubyFunction({ StorageClass }),
    Type({ fg = colors.steel }),
    Typedef({ Type }),
    NvimNumberPrefix({ Type }),
    NvimOptionSigil({ Type }),
    TSEnvironmentName({ Type }),
    TSTypeQualifier({ Type }),
    TSTypeBuiltin({ Type }),
    TSType({ Type }),
    vimGroup({ Type }),
    vimType({ Type }),
    vimPattern({ Type }),
    vimAutoEvent({ Type }),
    vimSynCase({ Type }),
    vimSynReg({ Type }),
    vimSyncC({ Type }),
    vimSyncKey({ Type }),
    vimSyncNone({ Type }),
    vimHiTerm({ Type }),
    vimSpecial({ Type }),
    ptContext({ Type }),
    cssClass({ Type }),
    javascriptOpSymbols({ Type }),
    sassClassChar({ Type }),
    Structure({ fg = colors.gray_medium }),
    luaTable({ Structure }),
    gitcommitDiscardedFile({ Structure }),
    gitcommitUntrackedFile({ Structure }),
    jsStorageClass({ Structure }),
    Special({ fg = colors.pink }),
    Tag({ Special }),
    SpecialChar({ Special }),
    Debug({ Special }),
    TSVariableBuiltin({ Special }),
    TSMath({ Special }),
    TSConstBuiltin({ Special }),
    TSConstructor({ Special }),
    TSFuncBuiltin({ Special }),
    vimNotation({ Special }),
    vimContinue({ Special }),
    vimFuncSID({ Special }),
    vimUserAttrbCmpltFunc({ Special }),
    vimSubstFlags({ Special }),
    vimLetHereDocStart({ Special }),
    vimLetHereDocStop({ Special }),
    vimAutoCmdMod({ Special }),
    vimGroupSpecial({ Special }),
    vimSynOption({ Special }),
    Delimiter({ fg = colors.pink }),
    NvimParenthesis({ Delimiter }),
    NvimColon({ Delimiter }),
    NvimComma({ Delimiter }),
    NvimArrow({ Delimiter }),
    TSPunctDelimiter({ Delimiter }),
    TSPunctBracket({ Delimiter }),
    TSPunctSpecial({ Delimiter }),
    TSTagDelimiter({ Delimiter }),
    vimParenSep({ Delimiter }),
    vimSep({ Delimiter }),
    vimSubstDelim({ Delimiter }),
    vimBracket({ Delimiter }),
    vimIskSep({ Delimiter }),
    jsBraces({ Delimiter }),
    DiagnosticError({ fg = colors.pink }),
    DiagnosticVirtualTextError({ DiagnosticError }),
    DiagnosticFloatingError({ DiagnosticError }),
    DiagnosticSignError({ DiagnosticError }),
    DiagnosticWarn({ fg = colors.sap }),
    DiagnosticVirtualTextWarn({ DiagnosticWarn }),
    DiagnosticFloatingWarn({ DiagnosticWarn }),
    DiagnosticSignWarn({ DiagnosticWarn }),
    DiagnosticInfo({ fg = colors.steel }),
    DiagnosticVirtualTextInfo({ DiagnosticInfo }),
    DiagnosticFloatingInfo({ DiagnosticInfo }),
    DiagnosticSignInfo({ DiagnosticInfo }),
    DiagnosticHint({ fg = colors.cyan }),
    DiagnosticVirtualTextHint({ DiagnosticHint }),
    DiagnosticFloatingHint({ DiagnosticHint }),
    DiagnosticSignHint({ DiagnosticHint }),
    DiagnosticUnderlineError({ DiagnosticError, gui = "underline" }),
    DiagnosticUnderlineWarn({ DiagnosticWarn, gui = "underline" }),
    DiagnosticUnderlineInfo({ DiagnosticInfo, gui = "underline" }),
    DiagnosticUnderlineHint({ DiagnosticHint, gui = "underline" }),
    MatchParen({ fg = colors.pink, bg = colors.rock_dark }),
    Comment({ fg = colors.gray, gui = "italic" }),
    TSComment({ Comment }),
    luaComment({ Comment }),
    vimComment({ Comment }),
    vim9Comment({ Comment }),
    vimScriptDelim({ Comment }),
    StartifyPath({ Comment }),
    StartifySlash({ Comment }),
    phpRegion({ Comment }),
    yamlDocumentStart({ Comment }),
    SpecialComment({ Comment }),
    Underlined({ fg = colors.turquoise, gui = "underline" }),
    TSURI({ Underlined }),
    Ignore({ fg = "bg" }),
    NvimInternalError({ Error }),
    NvimFigureBrace({ NvimInternalError }),
    NvimSingleQuotedUnknownEscape({ NvimInternalError }),
    NvimInvalidSingleQuotedUnknownEscape({ NvimInternalError }),
    Darker({ fg = colors.gray, bg = colors.rock_dark }),
    GitGutterAdd({ fg = colors.turquoise, bg = Normal.bg }),
    GitGutterChange({ fg = colors.sap, bg = Normal.bg }),
    GitGutterDelete({ fg = colors.pink, bg = Normal.bg }),
    GitGutterChangeDelete({ fg = colors.purple }),
    DiffAdd({ fg = GitGutterAdd.bg, bg = GitGutterAdd.fg }),
    DiffChange({ fg = GitGutterChange.bg, bg = GitGutterChange.fg }),
    DiffDelete({ fg = GitGutterDelete.bg, bg = GitGutterDelete.fg }),
    DiffText({ fg = colors.cyan }),
    Symbol({ fg = colors.sky }),
    texInputFile({ Symbol }),
    texMathSymbol({ Symbol }),
    texMathZoneA({ Symbol }),
    texMathZoneAS({ Symbol }),
    texTypeSize({ Symbol }),
    texTypeStyle({ Symbol }),
    mkdBlockquote({ Symbol }),
    rubySymbol({ Symbol }),
    Access({ fg = colors.purple, gui = "bold" }),
    rubyAccess({ Access }),
    Class({ fg = colors.pink, gui = "italic" }),
    rubyClass({ Class }),
    Module({ fg = colors.pink, gui = "underline" }),
    rubyModule({ Module }),
    Userdef({ fg = colors.sap }),
    -- Plugins
    LspSignatureActiveParameter({ fg = colors.fluoric, gui = "italic" }),
    LspInlayHint({ Comment }),
    FelineDiagnosticErrors({ DiagnosticError }),
    FelineDiagnosticHints({ DiagnosticHint }),
    FelineDiagnosticInfo({ DiagnosticInfo }),
    FelineDiagnosticWarnings({ DiagnosticWarn }),
    FelineFileInfo({ Comment }),
    FelineFileType({ Comment }),
    FelineGitDiffAdded({ GitGutterAdd }),
    FelineGitDiffChanged({ GitGutterChange }),
    FelineGitDiffRemoved({ GitGutterDelete }),
    GitSignsAdd({ GitGutterAdd }),
    GitSignsAddInline({ fg = GitGutterAdd.bg, bg = GitGutterAdd.fg }),
    GitSignsAddLn({ gui = "nocombine" }),
    GitSignsChange({ GitGutterChange }),
    GitSignsChangeInline({ fg = GitGutterChange.bg, bg = GitGutterChange.fg }),
    GitSignsDelete({ GitGutterDelete }),
    GitSignsDeleteLn({ gui = "nocombine" }),
    GitSignsDeleteInline({ fg = GitGutterDelete.bg, bg = GitGutterDelete.fg }),
    GitWordAdd({ DiffAdd }),
    GitWordDelete({ DiffDelete }),
    TelescopeMatching({ Special }),
    TelescopeMultiIcon({ Identifier }),
    TelescopeMultiSelection({ Type }),
    TelescopeNormal({ Normal }),
    TelescopePreviewBlock({ Constant }),
    TelescopePreviewCharDev({ Constant }),
    TelescopePreviewDate({ Directory }),
    TelescopePreviewDirectory({ Directory }),
    TelescopePreviewExecute({ String }),
    TelescopePreviewGroup({ Constant }),
    TelescopePreviewHyphen({ NonText }),
    TelescopePreviewLine({ Visual }),
    TelescopePreviewLink({ Special }),
    TelescopePreviewMatch({ Search }),
    TelescopePreviewPipe({ Constant }),
    TelescopePreviewRead({ Constant }),
    TelescopePreviewSize({ String }),
    TelescopePreviewSocket({ Statement }),
    TelescopePreviewUser({ Constant }),
    TelescopePreviewWrite({ Statement }),
    TelescopePromptCounter({ NonText }),
    TelescopePromptPrefix({ Identifier }),
    TelescopeResultsClass({ Function }),
    TelescopeResultsComment({ Comment }),
    TelescopeResultsConstant({ Constant }),
    TelescopeResultsDiffAdd({ DiffAdd }),
    TelescopeResultsDiffChange({ DiffChange }),
    TelescopeResultsDiffDelete({ DiffDelete }),
    TelescopeResultsDiffUntracked({ NonText }),
    TelescopeResultsField({ Function }),
    TelescopeResultsFileIcon({ Normal }),
    TelescopeResultsFunction({ Function }),
    TelescopeResultsIdentifier({ Identifier }),
    TelescopeResultsLineNr({ LineNr }),
    TelescopeResultsNumber({ Number }),
    TelescopeSelection({ Visual }),
    NeoTreeBufferNumber({ fg = colors.fluoric }),
    NeoTreeCursorLine({ Visual }),
    NeoTreeDimText({ fg = colors.gray_medium }),
    NeoTreeDirectoryIcon({ Directory }),
    NeoTreeDirectoryName({ NeoTreeDirectoryIcon }),
    NeoTreeDotfile({ fg = Normal.fg }),
    NeoTreeFileIcon({ NeoTreeDirectoryIcon }),
    NeoTreeFileName({ fg = Normal.fg }),
    NeoTreeFileNameOpened({ fg = Normal.fg }),
    NeoTreeFilterTerm({ fg = colors.sky }),
    NeoTreeFloatBorder({ NormalFloat }),
    NeoTreeFloatTitle({ Normal }),
    NeoTreeTitleBar({ Normal }),
    NeoTreeGitAdded({ fg = GitSignsAdd.fg }),
    NeoTreeGitConflict({ fg = Error.fg }),
    NeoTreeGitDeleted({ fg = GitSignsDelete.fg }),
    NeoTreeGitIgnored({ fg = Comment.fg }),
    NeoTreeGitModified({ fg = GitSignsChange.fg }),
    NeoTreeGitUnstaged({ fg = colors.purple }),
    NeoTreeGitUntracked({ fg = GitSignsAdd.fg }),
    NeoTreeGitStaged({ GitSignsAdd }),
    NeoTreeHiddenByName({ fg = Comment.fg }),
    NeoTreeIndentMarker({ fg = Normal.fg }),
    NeoTreeExpander({ NeoTreeDirectoryIcon }),
    NeoTreeNormal({ Normal }),
    NeoTreeNormalNC({ NormalNC }),
    NeoTreeSignColumn({ SignColumn }),
    NeoTreeStatusLine({ StatusLine }),
    NeoTreeStatusLineNC({ StatusLineNC }),
    NeoTreeVertSplit({ VertSplit }),
    NeoTreeWinSeparator({ WinSeparator }),
    NeoTreeEndOfBuffer({ EndOfBuffer }),
    NeoTreeRootName({ fg = colors.fluoric, gui = "italic bold" }),
    NeoTreeSymbolicLinkTarget({ Normal }),
    NeoTreeWindowsHidden({ fg = Comment.fg }),
  }
end)

local theme = { colors = colors, spec = spec }

-- To debug with `:Lushify`, return `spec`
return theme
