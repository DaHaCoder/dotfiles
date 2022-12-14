" Vim syntax file
" Language:	TeX
" Maintainer:	Charles E. Campbell <NcampObell@SdrPchip.AorgM-NOSPAM>
" Last Change:	Apr 22, 2022
" Version:	121
" URL:		http://www.drchip.org/astronaut/vim/index.html#SYNTAX_TEX
"
" Notes: {{{1
"
" 1. If you have a \begin{verbatim} that appears to overrun its boundaries,
"    use %stopzone.
"
" 2. Run-on equations ($..$ and $$..$$, particularly) can also be stopped
"    by suitable use of %stopzone.
"
" 3. If you have a slow computer, you may wish to modify
"
"	syn sync maxlines=200
"	syn sync minlines=50
"
"    to values that are more to your liking.
"
" 4. There is no match-syncing for $...$ and $$...$$; hence large
"    equation blocks constructed that way may exhibit syncing problems.
"    (there's no difference between begin/end patterns)
"
" 5. If you have the variable "g:tex_no_error" defined then none of the
"    lexical error-checking will be done.
"
"    ie. let g:tex_no_error=1
"
" 6. Please see  :help latex-syntax  for information on
"      syntax folding           :help tex-folding
"      spell checking           :help tex-nospell
"      commands and mathzones   :help tex-runon
"      new command highlighting :help tex-morecommands
"      error highlighting       :help tex-error
"      new math groups          :help tex-math
"      new styles               :help tex-style
"      using conceal mode       :help tex-conceal

" Version Clears: {{{1
" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif
let s:keepcpo= &cpo
set cpo&vim
scriptencoding utf-8

" by default, enable all region-based highlighting
let s:tex_fast= "bcmMprsSvV"
if exists("g:tex_fast")
 if type(g:tex_fast) != 1
  " g:tex_fast exists and is not a string, so
  " turn off all optional region-based highighting
  let s:tex_fast= ""
 else
  let s:tex_fast= g:tex_fast
 endif
endif

" let user determine which classes of concealment will be supported
"   a=accents/ligatures d=delimiters m=math symbols  g=Greek  s=superscripts/subscripts
if !exists("g:tex_conceal")
 let s:tex_conceal= 'abdmgsS'
else
 let s:tex_conceal= g:tex_conceal
endif
if !exists("g:tex_superscripts")
 let s:tex_superscripts= '[0-9a-zA-W.,:;+-<>/()=]'
else
 let s:tex_superscripts= g:tex_superscripts
endif
if !exists("g:tex_subscripts")
 let s:tex_subscripts= '[0-9aehijklmnoprstuvx,+-/().]'
else
 let s:tex_subscripts= g:tex_subscripts
endif

" Determine whether or not to use "*.sty" mode {{{1
" The user may override the normal determination by setting
"   g:tex_stylish to 1      (for    "*.sty" mode)
"    or to           0 else (normal "*.tex" mode)
" or on a buffer-by-buffer basis with b:tex_stylish
let s:extfname=expand("%:e")
if exists("g:tex_stylish")
 let b:tex_stylish= g:tex_stylish
elseif !exists("b:tex_stylish")
 if s:extfname == "sty" || s:extfname == "cls" || s:extfname == "clo" || s:extfname == "dtx" || s:extfname == "ltx"
  let b:tex_stylish= 1
 else
  let b:tex_stylish= 0
 endif
endif

" handle folding {{{1
if !exists("g:tex_fold_enabled")
 let s:tex_fold_enabled= 0
elseif g:tex_fold_enabled && !has("folding")
 let s:tex_fold_enabled= 0
 echomsg "Ignoring g:tex_fold_enabled=".g:tex_fold_enabled."; need to re-compile vim for +fold support"
else
 let s:tex_fold_enabled= 1
endif
if s:tex_fold_enabled && &fdm == "manual"
 setl fdm=syntax
endif
if s:tex_fold_enabled && has("folding")
 com! -nargs=* TexFold <args> fold 
else
 com! -nargs=* TexFold <args> 
endif

" (La)TeX keywords: uses the characters 0-9,a-z,A-Z,192-255 only... {{{1
" but _ is the only one that causes problems.
" One may override this iskeyword setting by providing
" g:tex_isk
if exists("g:tex_isk")
 if b:tex_stylish && g:tex_isk !~ '@'
  let b:tex_isk= '@,'.g:tex_isk
 else
  let b:tex_isk= g:tex_isk
 endif
elseif b:tex_stylish
 let b:tex_isk="@,48-57,a-z,A-Z,192-255"
else
 let b:tex_isk="48-57,a-z,A-Z,192-255"
endif
if (v:version == 704 && has("patch-7.4.1142")) || v:version > 704
 exe "syn iskeyword ".b:tex_isk
else
 exe "setl isk=".b:tex_isk
endif
if exists("g:tex_no_error") && g:tex_no_error
 let s:tex_no_error= 1
else
 let s:tex_no_error= 0
endif
if exists("g:tex_comment_nospell") && g:tex_comment_nospell
 let s:tex_comment_nospell= 1
else
 let s:tex_comment_nospell= 0
endif
if exists("g:tex_nospell") && g:tex_nospell
 let s:tex_nospell = 1
else
 let s:tex_nospell = 0
endif
if exists("g:tex_matchcheck")
 let s:tex_matchcheck= g:tex_matchcheck
else
 let s:tex_matchcheck= '[({[]'
endif
if exists("g:tex_excludematcher")
 let s:tex_excludematcher= g:tex_excludematcher
else
 let s:tex_excludematcher= 0
endif

" Clusters: {{{1
" --------
syn cluster texCmdGroup			contains=texCmdBody,texComment,texDefParm,texDelimiter,texDocType,texInput,texLength,texLigature,texMathDelim,texMathOper,texNewCmd,texNewEnv,texRefZone,texSection,texBeginEnd,texBeginEndName,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,@texMathZones
if !s:tex_no_error
 syn cluster texCmdGroup		add=texMathError
endif
syn cluster texEnvGroup			contains=texMatcher,texMathDelim,texSpecialChar,texStatement
syn cluster texFoldGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texInputFile,texLength,texLigature,texMatcher,texMathZoneV,texMathZoneW,texMathZoneX,texMathZoneY,texMathZoneZ,texNewCmd,texNewEnv,texOnlyMath,texOption,texParen,texRefZone,texSection,texBeginEnd,texSectionZone,texSpaceCode,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texZone,@texMathZones,texTitle,texAbstract,texBoldStyle,texItalStyle,texEmphStyle,texNoSpell
syn cluster texBoldGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texInputFile,texLength,texLigature,texMathZoneV,texMathZoneW,texMathZoneX,texMathZoneY,texMathZoneZ,texNewCmd,texNewEnv,texOnlyMath,texOption,texParen,texRefZone,texSection,texBeginEnd,texSectionZone,texSpaceCode,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texZone,@texMathZones,texTitle,texAbstract,texBoldStyle,texBoldItalStyle,texNoSpell
syn cluster texItalGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texInputFile,texLength,texLigature,texMathZoneV,texMathZoneW,texMathZoneX,texMathZoneY,texMathZoneZ,texNewCmd,texNewEnv,texOnlyMath,texOption,texParen,texRefZone,texSection,texBeginEnd,texSectionZone,texSpaceCode,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texZone,@texMathZones,texTitle,texAbstract,texItalStyle,texEmphStyle,texItalBoldStyle,texNoSpell
if !s:tex_excludematcher
 syn cluster texBoldGroup add=texMatcher
 syn cluster texItalGroup add=texMatcher
endif
if !s:tex_nospell
 if !s:tex_no_error
  syn cluster texMatchGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texError,texInput,texLength,texLigature,texMatcher,texNewCmd,texNewEnv,texOnlyMath,texParen,texRefZone,texSection,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texBoldStyle,texBoldItalStyle,texItalStyle,texItalBoldStyle,texZone,texInputFile,texOption,@Spell
  syn cluster texMatchNMGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texError,texInput,texLength,texLigature,texMatcherNM,texNewCmd,texNewEnv,texOnlyMath,texParen,texRefZone,texSection,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texBoldStyle,texBoldItalStyle,texItalStyle,texItalBoldStyle,texZone,texInputFile,texOption,@Spell
  syn cluster texStyleGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texError,texInput,texLength,texLigature,texNewCmd,texNewEnv,texOnlyMath,texParen,texRefZone,texSection,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texBoldStyle,texBoldItalStyle,texItalStyle,texItalBoldStyle,texZone,texInputFile,texOption,texStyleStatement,texStyleMatcher,@Spell
 else
  syn cluster texMatchGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texLength,texLigature,texMatcher,texNewCmd,texNewEnv,texOnlyMath,texParen,texRefZone,texSection,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texBoldStyle,texBoldItalStyle,texItalStyle,texItalBoldStyle,texZone,texInputFile,texOption,@Spell
  syn cluster texMatchNMGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texLength,texLigature,texMatcherNM,texNewCmd,texNewEnv,texOnlyMath,texParen,texRefZone,texSection,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texBoldStyle,texBoldItalStyle,texItalStyle,texItalBoldStyle,texZone,texInputFile,texOption,@Spell
  syn cluster texStyleGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texLength,texLigature,texNewCmd,texNewEnv,texOnlyMath,texParen,texRefZone,texSection,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texBoldStyle,texBoldItalStyle,texItalStyle,texItalBoldStyle,texZone,texInputFile,texOption,texStyleStatement,texStyleMatcher,@Spell
 endif
else
 if !s:tex_no_error
  syn cluster texMatchGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texError,texInput,texLength,texLigature,texMatcher,texNewCmd,texNewEnv,texOnlyMath,texParen,texRefZone,texSection,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texZone,texInputFile,texOption
  syn cluster texMatchNMGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texError,texInput,texLength,texLigature,texMatcherNM,texNewCmd,texNewEnv,texOnlyMath,texParen,texRefZone,texSection,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texZone,texInputFile,texOption
  syn cluster texStyleGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texError,texInput,texLength,texLigature,texNewCmd,texNewEnv,texOnlyMath,texParen,texRefZone,texSection,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texZone,texInputFile,texOption,texStyleStatement,texStyleMatcher
 else
  syn cluster texMatchGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texLength,texLigature,texMatcher,texNewCmd,texNewEnv,texOnlyMath,texParen,texRefZone,texSection,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texZone,texInputFile,texOption
  syn cluster texMatchNMGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texLength,texLigature,texMatcherNM,texNewCmd,texNewEnv,texOnlyMath,texParen,texRefZone,texSection,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texZone,texInputFile,texOption
  syn cluster texStyleGroup		contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texLength,texLigature,texNewCmd,texNewEnv,texOnlyMath,texParen,texRefZone,texSection,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texZone,texInputFile,texOption,texStyleStatement,texStyleMatcher
 endif
endif
syn cluster texPreambleMatchGroup	contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texLength,texLigature,texMatcherNM,texNewCmd,texNewEnv,texOnlyMath,texParen,texRefZone,texSection,texSpecialChar,texStatement,texString,texTitle,texTypeSize,texTypeStyle,texZone,texInputFile,texOption,texMathZoneZ
syn cluster texRefGroup			contains=texMatcher,texComment,texDelimiter
if !exists("g:tex_no_math")
 syn cluster texPreambleMatchGroup	contains=texAccent,texBadMath,texComment,texDefCmd,texDelimiter,texDocType,texInput,texLength,texLigature,texMatcherNM,texNewCmd,texNewEnv,texOnlyMath,texParen,texRefZone,texSection,texSpecialChar,texStatement,texString,texTitle,texTypeSize,texTypeStyle,texZone,texInputFile,texOption,texMathZoneZ
 syn cluster texMathZones		contains=texMathZoneV,texMathZoneW,texMathZoneX,texMathZoneY,texMathZoneZ
 syn cluster texMatchGroup		add=@texMathZones
 syn cluster texMathDelimGroup		contains=texMathDelimBad,texMathDelimKey,texMathDelimSet1,texMathDelimSet2
 syn cluster texMathMatchGroup		contains=@texMathZones,texComment,texDefCmd,texDelimiter,texDocType,texInput,texLength,texLigature,texMathDelim,texMathMatcher,texMathOper,texNewCmd,texNewEnv,texRefZone,texSection,texSpecialChar,texStatement,texString,texTypeSize,texTypeStyle,texZone
 syn cluster texMathZoneGroup		contains=texBadPar,texComment,texDelimiter,texLength,texMathDelim,texMathMatcher,texMathOper,texMathSymbol,texMathText,texRefZone,texSpecialChar,texStatement,texTypeSize,texTypeStyle
 if !s:tex_no_error
  syn cluster texMathMatchGroup		add=texMathError
  syn cluster texMathZoneGroup		add=texMathError
 endif
 syn cluster texMathZoneGroup		add=@NoSpell
 " following used in the \part \chapter \section \subsection \subsubsection
 " \paragraph \subparagraph \author \title highlighting
 syn cluster texDocGroup		contains=texPartZone,@texPartGroup
 syn cluster texPartGroup		contains=texChapterZone,texSectionZone,texParaZone
 syn cluster texChapterGroup		contains=texSectionZone,texParaZone
 syn cluster texSectionGroup		contains=texSubSectionZone,texParaZone
 syn cluster texSubSectionGroup		contains=texSubSubSectionZone,texParaZone
 syn cluster texSubSubSectionGroup	contains=texParaZone
 syn cluster texParaGroup		contains=texSubParaZone
 if has("conceal") && &enc == 'utf-8'
  syn cluster texMathZoneGroup		add=texGreek,texSuperscript,texSubscript,texMathSymbol
  syn cluster texMathMatchGroup		add=texGreek,texSuperscript,texSubscript,texMathSymbol
 endif
endif

" Try to flag {}, [], and () mismatches: {{{1
if s:tex_fast =~# 'm'
  if !s:tex_no_error
   if s:tex_matchcheck =~ '{'
    syn region texMatcher	matchgroup=texDelimiter start="{" skip="\\\\\|\\[{}]"	end="}"			transparent contains=@texMatchGroup,texError
    syn region texMatcherNM	matchgroup=texDelimiter start="{" skip="\\\\\|\\[{}]"	end="}"			transparent contains=@texMatchNMGroup,texError
   endif
   if s:tex_matchcheck =~ '\['
    syn region texMatcher	matchgroup=texDelimiter start="\["				end="]"			transparent contains=@texMatchGroup,texError,@NoSpell
    syn region texMatcherNM	matchgroup=texDelimiter start="\["				end="]"			transparent contains=@texMatchNMGroup,texError,@NoSpell
   endif
  else
   if s:tex_matchcheck =~ '{'
    syn region texMatcher	matchgroup=texDelimiter start="{" skip="\\\\\|\\[{}]"	end="}"			transparent contains=@texMatchGroup
    syn region texMatcherNM	matchgroup=texDelimiter start="{" skip="\\\\\|\\[{}]"	end="}"			transparent contains=@texMatchNMGroup
   endif
   if s:tex_matchcheck =~ '\['
    syn region texMatcher	matchgroup=texDelimiter start="\["				end="]"			transparent contains=@texMatchGroup
    syn region texMatcherNM	matchgroup=texDelimiter start="\["				end="]"			transparent contains=@texMatchNMGroup
   endif
  endif
  if s:tex_matchcheck =~ '('
   if !s:tex_nospell
    syn region texParen		start="("	end=")"								transparent contains=@texMatchGroup,@Spell
   else
    syn region texParen		start="("	end=")"								transparent contains=@texMatchGroup
   endif
  endif
endif
if !s:tex_no_error
 if s:tex_matchcheck =~ '('
  syn match  texError		"[}\]]"
 else
  syn match  texError		"[}\])]"
 endif
endif
if s:tex_fast =~# 'M'
  if !exists("g:tex_no_math")
   if !s:tex_no_error
    syn match  texMathError	"}"	contained
   endif
   syn region texMathMatcher	matchgroup=texDelimiter	start="{"          skip="\%(\\\\\)*\\}"     end="}" end="%stopzone\>"	contained contains=@texMathMatchGroup
  endif
endif

" TeX/LaTeX keywords: {{{1
" Instead of trying to be All Knowing, I just match \..alphameric..
" Note that *.tex files may not have "@" in their \commands
if exists("g:tex_tex") || b:tex_stylish
  syn match texStatement	"\\[a-zA-Z@]\+"
else
  syn match texStatement	"\\\a\+"
  if !s:tex_no_error
   syn match texError		"\\\a*@[a-zA-Z@]*"
  endif
endif

" TeX/LaTeX delimiters: {{{1
syn match texDelimiter		"&"
syn match texDelimiter		"\\\\"

" Tex/Latex Options: {{{1
syn match texOption		"[^\\]\zs#\d\+\|^#\d\+"

" texAccent (tnx to Karim Belabas) avoids annoying highlighting for accents: {{{1
if b:tex_stylish
  syn match texAccent		"\\[bcdvuH][^a-zA-Z@]"me=e-1
  syn match texLigature		"\\\([ijolL]\|ae\|oe\|ss\|AA\|AE\|OE\)[^a-zA-Z@]"me=e-1
else
  syn match texAccent		"\\[bcdvuH]\A"me=e-1
  syn match texLigature		"\\\([ijolL]\|ae\|oe\|ss\|AA\|AE\|OE\)\A"me=e-1
endif
syn match texAccent		"\\[bcdvuH]$"
syn match texAccent		+\\[=^.\~"`']+
syn match texAccent		+\\['=t'.c^ud"vb~Hr]{\a}+
syn match texLigature		"\\\([ijolL]\|ae\|oe\|ss\|AA\|AE\|OE\)$"


" \begin{}/\end{} section markers: {{{1
syn match  texBeginEnd		"\\begin\>\|\\end\>" nextgroup=texBeginEndName
if s:tex_fast =~# 'm'
  syn region texBeginEndName		matchgroup=texDelimiter	start="{"		end="}"	contained	nextgroup=texBeginEndModifier	contains=texComment
  syn region texBeginEndModifier	matchgroup=texDelimiter	start="\["		end="]"	contained	contains=texComment,@texMathZones,@NoSpell
endif

" \documentclass, \documentstyle, \usepackage: {{{1
syn match  texDocType		"\\documentclass\>\|\\documentstyle\>\|\\usepackage\>"	nextgroup=texBeginEndName,texDocTypeArgs
if s:tex_fast =~# 'm'
  syn region texDocTypeArgs	matchgroup=texDelimiter start="\[" end="]"			contained	nextgroup=texBeginEndName	contains=texComment,@NoSpell
endif

" Preamble syntax-based folding support: {{{1
if s:tex_fold_enabled && has("folding")
 syn region texPreamble	transparent fold	start='\zs\\documentclass\>' end='\ze\\begin{document}'	contains=texStyle,@texPreambleMatchGroup
endif

" TeX input: {{{1
syn match texInput		"\\input\s\+[a-zA-Z/.0-9_^]\+"hs=s+7				contains=texStatement
syn match texInputFile		"\\include\(graphics\|list\)\=\(\[.\{-}\]\)\=\s*{.\{-}}"	contains=texStatement,texInputCurlies,texInputFileOpt
syn match texInputFile		"\\\(epsfig\|input\|usepackage\)\s*\(\[.*\]\)\={.\{-}}"		contains=texStatement,texInputCurlies,texInputFileOpt
syn match texInputCurlies	"[{}]"								contained
if s:tex_fast =~# 'm'
 syn region texInputFileOpt	matchgroup=texDelimiter start="\[" end="\]"			contained	contains=texComment
endif

" Type Styles (LaTeX 2.09): {{{1
syn match texTypeStyle		"\\rm\>"
syn match texTypeStyle		"\\em\>"
syn match texTypeStyle		"\\bf\>"
syn match texTypeStyle		"\\it\>"
syn match texTypeStyle		"\\sl\>"
syn match texTypeStyle		"\\sf\>"
syn match texTypeStyle		"\\sc\>"
syn match texTypeStyle		"\\tt\>"

" Type Styles: attributes, commands, families, etc (LaTeX2E): {{{1
if s:tex_conceal !~# 'b'
 syn match texTypeStyle		"\\textbf\>"
 syn match texTypeStyle		"\\textit\>"
 syn match texTypeStyle		"\\emph\>"
endif
syn match texTypeStyle		"\\textmd\>"
syn match texTypeStyle		"\\textrm\>"

syn match texTypeStyle		"\\mathbf\>"
syn match texTypeStyle		"\\mathcal\>"
syn match texTypeStyle		"\\mathit\>"
syn match texTypeStyle		"\\mathnormal\>"
syn match texTypeStyle		"\\mathrm\>"
syn match texTypeStyle		"\\mathsf\>"
syn match texTypeStyle		"\\mathtt\>"

syn match texTypeStyle		"\\rmfamily\>"
syn match texTypeStyle		"\\sffamily\>"
syn match texTypeStyle		"\\ttfamily\>"

syn match texTypeStyle		"\\itshape\>"
syn match texTypeStyle		"\\scshape\>"
syn match texTypeStyle		"\\slshape\>"
syn match texTypeStyle		"\\upshape\>"

syn match texTypeStyle		"\\bfseries\>"
syn match texTypeStyle		"\\mdseries\>"

" Some type sizes: {{{1
syn match texTypeSize		"\\tiny\>"
syn match texTypeSize		"\\scriptsize\>"
syn match texTypeSize		"\\footnotesize\>"
syn match texTypeSize		"\\small\>"
syn match texTypeSize		"\\normalsize\>"
syn match texTypeSize		"\\large\>"
syn match texTypeSize		"\\Large\>"
syn match texTypeSize		"\\LARGE\>"
syn match texTypeSize		"\\huge\>"
syn match texTypeSize		"\\Huge\>"

" Spacecodes (TeX'isms): {{{1
" \mathcode`\^^@="2201  \delcode`\(="028300  \sfcode`\)=0 \uccode`X=`X  \lccode`x=`x
syn match texSpaceCode		"\\\(math\|cat\|del\|lc\|sf\|uc\)code`"me=e-1 nextgroup=texSpaceCodeChar
syn match texSpaceCodeChar    "`\\\=.\(\^.\)\==\(\d\|\"\x\{1,6}\|`.\)"	contained

" Sections, subsections, etc: {{{1
if s:tex_fast =~# 'p'
 if !s:tex_nospell
  TexFold syn region texDocZone			matchgroup=texSection start='\\begin\s*{\s*document\s*}' end='\\end\s*{\s*document\s*}'											contains=@texFoldGroup,@texDocGroup,@Spell
  TexFold syn region texPartZone		matchgroup=texSection start='\\part\>'			 end='\ze\s*\\\%(part\>\|end\s*{\s*document\s*}\)'								contains=@texFoldGroup,@texPartGroup,@Spell
  TexFold syn region texChapterZone		matchgroup=texSection start='\\chapter\>'		 end='\ze\s*\\\%(chapter\>\|part\>\|end\s*{\s*document\s*}\)'							contains=@texFoldGroup,@texChapterGroup,@Spell
  TexFold syn region texSectionZone		matchgroup=texSection start='\\section\>'		 end='\ze\s*\\\%(section\>\|chapter\>\|part\>\|end\s*{\s*document\s*}\)'					contains=@texFoldGroup,@texSectionGroup,@Spell
  TexFold syn region texSubSectionZone		matchgroup=texSection start='\\subsection\>'		 end='\ze\s*\\\%(\%(sub\)\=section\>\|chapter\>\|part\>\|end\s*{\s*document\s*}\)'				contains=@texFoldGroup,@texSubSectionGroup,@Spell
  TexFold syn region texSubSubSectionZone	matchgroup=texSection start='\\subsubsection\>'		 end='\ze\s*\\\%(\%(sub\)\{,2}section\>\|chapter\>\|part\>\|end\s*{\s*document\s*}\)'				contains=@texFoldGroup,@texSubSubSectionGroup,@Spell
  TexFold syn region texParaZone		matchgroup=texSection start='\\paragraph\>'		 end='\ze\s*\\\%(paragraph\>\|\%(sub\)*section\>\|chapter\>\|part\>\|end\s*{\s*document\s*}\)'			contains=@texFoldGroup,@texParaGroup,@Spell
  TexFold syn region texSubParaZone		matchgroup=texSection start='\\subparagraph\>'		 end='\ze\s*\\\%(\%(sub\)\=paragraph\>\|\%(sub\)*section\>\|chapter\>\|part\>\|end\s*{\s*document\s*}\)'	contains=@texFoldGroup,@Spell
  TexFold syn region texTitle			matchgroup=texSection start='\\\%(author\|title\)\>\s*{' end='}'													contains=@texFoldGroup,@Spell
  TexFold syn region texAbstract		matchgroup=texSection start='\\begin\s*{\s*abstract\s*}' end='\\end\s*{\s*abstract\s*}'											contains=@texFoldGroup,@Spell
 else
  TexFold syn region texDocZone			matchgroup=texSection start='\\begin\s*{\s*document\s*}' end='\\end\s*{\s*document\s*}'											contains=@texFoldGroup,@texDocGroup
  TexFold syn region texPartZone		matchgroup=texSection start='\\part\>'			 end='\ze\s*\\\%(part\>\|end\s*{\s*document\s*}\)'								contains=@texFoldGroup,@texPartGroup
  TexFold syn region texChapterZone		matchgroup=texSection start='\\chapter\>'		 end='\ze\s*\\\%(chapter\>\|part\>\|end\s*{\s*document\s*}\)'							contains=@texFoldGroup,@texChapterGroup
  TexFold syn region texSectionZone		matchgroup=texSection start='\\section\>'		 end='\ze\s*\\\%(section\>\|chapter\>\|part\>\|end\s*{\s*document\s*}\)'					contains=@texFoldGroup,@texSectionGroup
  TexFold syn region texSubSectionZone		matchgroup=texSection start='\\subsection\>'		 end='\ze\s*\\\%(\%(sub\)\=section\>\|chapter\>\|part\>\|end\s*{\s*document\s*}\)'				contains=@texFoldGroup,@texSubSectionGroup
  TexFold syn region texSubSubSectionZone	matchgroup=texSection start='\\subsubsection\>'		 end='\ze\s*\\\%(\%(sub\)\{,2}section\>\|chapter\>\|part\>\|end\s*{\s*document\s*}\)'				contains=@texFoldGroup,@texSubSubSectionGroup
  TexFold syn region texParaZone		matchgroup=texSection start='\\paragraph\>'		 end='\ze\s*\\\%(paragraph\>\|\%(sub\)*section\>\|chapter\>\|part\>\|end\s*{\s*document\s*}\)'			contains=@texFoldGroup,@texParaGroup
  TexFold syn region texSubParaZone		matchgroup=texSection start='\\subparagraph\>'		 end='\ze\s*\\\%(\%(sub\)\=paragraph\>\|\%(sub\)*section\>\|chapter\>\|part\>\|end\s*{\s*document\s*}\)'	contains=@texFoldGroup
  TexFold syn region texTitle			matchgroup=texSection start='\\\%(author\|title\)\>\s*{' end='}'													contains=@texFoldGroup
  TexFold syn region texAbstract		matchgroup=texSection start='\\begin\s*{\s*abstract\s*}' end='\\end\s*{\s*abstract\s*}'											contains=@texFoldGroup
  endif
endif

" particular support for bold and italic {{{1
if s:tex_fast =~# 'b'
  if s:tex_conceal =~# 'b'
   if !exists("g:tex_nospell") || !g:tex_nospell
    syn region texBoldStyle	matchgroup=texTypeStyle start="\\textbf\s*{" matchgroup=texTypeStyle  end="}" concealends contains=@texBoldGroup,@Spell
    syn region texBoldItalStyle	matchgroup=texTypeStyle start="\\textit\s*{" matchgroup=texTypeStyle  end="}" concealends contains=@texItalGroup,@Spell
    syn region texItalStyle	matchgroup=texTypeStyle start="\\textit\s*{" matchgroup=texTypeStyle  end="}" concealends contains=@texItalGroup,@Spell
    syn region texItalBoldStyle	matchgroup=texTypeStyle start="\\textbf\s*{" matchgroup=texTypeStyle  end="}" concealends contains=@texBoldGroup,@Spell
    syn region texEmphStyle	matchgroup=texTypeStyle start="\\emph\s*{"   matchgroup=texTypeStyle  end="}" concealends contains=@texItalGroup,@Spell
    syn region texEmphStyle	matchgroup=texTypeStyle start="\\texts[cfl]\s*{" matchgroup=texTypeStyle  end="}" concealends contains=@texBoldGroup,@Spell
    syn region texEmphStyle	matchgroup=texTypeStyle start="\\textup\s*{" matchgroup=texTypeStyle  end="}" concealends contains=@texBoldGroup,@Spell
    syn region texEmphStyle	matchgroup=texTypeStyle start="\\texttt\s*{" matchgroup=texTypeStyle  end="}" concealends contains=@texBoldGroup,@Spell
   else                                                                                              
    syn region texBoldStyle	matchgroup=texTypeStyle start="\\textbf\s*{" matchgroup=texTypeStyle  end="}" concealends contains=@texBoldGroup
    syn region texBoldItalStyle	matchgroup=texTypeStyle start="\\textit\s*{" matchgroup=texTypeStyle  end="}" concealends contains=@texItalGroup
    syn region texItalStyle	matchgroup=texTypeStyle start="\\textit\s*{" matchgroup=texTypeStyle  end="}" concealends contains=@texItalGroup
    syn region texItalBoldStyle	matchgroup=texTypeStyle start="\\textbf\s*{" matchgroup=texTypeStyle  end="}" concealends contains=@texBoldGroup
    syn region texEmphStyle	matchgroup=texTypeStyle start="\\emph\s*{"   matchgroup=texTypeStyle  end="}" concealends contains=@texItalGroup
    syn region texEmphStyle	matchgroup=texTypeStyle start="\\texts[cfl]\s*{" matchgroup=texTypeStyle  end="}" concealends contains=@texEmphGroup
    syn region texEmphStyle	matchgroup=texTypeStyle start="\\textup\s*{" matchgroup=texTypeStyle  end="}" concealends contains=@texEmphGroup
    syn region texEmphStyle	matchgroup=texTypeStyle start="\\texttt\s*{" matchgroup=texTypeStyle  end="}" concealends contains=@texEmphGroup
   endif
  endif
endif

" Bad Math (mismatched): {{{1
if !exists("g:tex_no_math") && !s:tex_no_error
 syn match texBadMath		"\\end\s*{\s*\(array\|[bBpvV]matrix\|split\|smallmatrix\)\s*}"
 syn match texBadMath		"\\end\s*{\s*\(displaymath\|equation\|eqnarray\|math\)\*\=\s*}"
 syn match texBadMath		"\\[\])]"
 syn match texBadPar	contained  "\%(\\par\>\|^\s*\n.\)"
endif

" Math Zones: {{{1
if !exists("g:tex_no_math")
 " TexNewMathZone: function creates a mathzone with the given suffix and mathzone name. {{{2
 "                 Starred forms are created if starform is true.  Starred
 "                 forms have syntax group and synchronization groups with a
 "                 "S" appended.  Handles: cluster, syntax, sync, and highlighting.
 fun! TexNewMathZone(sfx,mathzone,starform)
   let grpname  = "texMathZone".a:sfx
   let syncname = "texSyncMathZone".a:sfx
   if s:tex_fold_enabled
    let foldcmd= " fold"
   else
    let foldcmd= ""
   endif
   exe "syn cluster texMathZones add=".grpname
   if s:tex_fast =~# 'M'
    exe 'syn region '.grpname.' start='."'".'\\begin\s*{\s*'.a:mathzone.'\s*}'."'".' end='."'".'\\end\s*{\s*'.a:mathzone.'\s*}'."'".' keepend contains=@texMathZoneGroup'.foldcmd
    exe 'syn sync match '.syncname.' grouphere '.grpname.' "\\begin\s*{\s*'.a:mathzone.'\*\s*}"'
    exe 'syn sync match '.syncname.' grouphere '.grpname.' "\\begin\s*{\s*'.a:mathzone.'\*\s*}"'
   endif
   exe 'hi def link '.grpname.' texMath'
   if a:starform
    let grpname  = "texMathZone".a:sfx.'S'
    let syncname = "texSyncMathZone".a:sfx.'S'
    exe "syn cluster texMathZones add=".grpname
    if s:tex_fast =~# 'M'
     exe 'syn region '.grpname.' start='."'".'\\begin\s*{\s*'.a:mathzone.'\*\s*}'."'".' end='."'".'\\end\s*{\s*'.a:mathzone.'\*\s*}'."'".' keepend contains=@texMathZoneGroup'.foldcmd
     exe 'syn sync match '.syncname.' grouphere '.grpname.' "\\begin\s*{\s*'.a:mathzone.'\*\s*}"'
     exe 'syn sync match '.syncname.' grouphere '.grpname.' "\\begin\s*{\s*'.a:mathzone.'\*\s*}"'
    endif
    exe 'hi def link '.grpname.' texMath'
   endif
 endfun

 " Standard Math Zones: {{{2
 call TexNewMathZone("A","displaymath",1)
 call TexNewMathZone("B","eqnarray",1)
 call TexNewMathZone("C","equation",1)
 call TexNewMathZone("D","math",1)

 " Inline Math Zones: {{{2
 if s:tex_fast =~# 'M'
  if has("conceal") && &enc == 'utf-8' && s:tex_conceal =~# 'd'
   syn region texMathZoneV	matchgroup=texDelimiter start="\\("			matchgroup=texDelimiter	end="\\)\|%stopzone\>"			keepend concealends contains=@texMathZoneGroup
   syn region texMathZoneW	matchgroup=texDelimiter start="\\\["			matchgroup=texDelimiter	end="\\]\|%stopzone\>"			keepend concealends contains=@texMathZoneGroup
   syn region texMathZoneX	matchgroup=texDelimiter start="\$" skip="\\\\\|\\\$"	matchgroup=texDelimiter	end="\$"	end="%stopzone\>"		concealends contains=@texMathZoneGroup
   syn region texMathZoneY	matchgroup=texDelimiter start="\$\$" 			matchgroup=texDelimiter	end="\$\$"	end="%stopzone\>"	keepend concealends contains=@texMathZoneGroup
  else
   syn region texMathZoneV	matchgroup=texDelimiter start="\\("			matchgroup=texDelimiter	end="\\)\|%stopzone\>"			keepend contains=@texMathZoneGroup
   syn region texMathZoneW	matchgroup=texDelimiter start="\\\["			matchgroup=texDelimiter	end="\\]\|%stopzone\>"			keepend contains=@texMathZoneGroup
   syn region texMathZoneX	matchgroup=texDelimiter start="\$" skip="\%(\\\\\)*\\\$"	matchgroup=texDelimiter	end="\$"	end="%stopzone\>"		contains=@texMathZoneGroup
   syn region texMathZoneY	matchgroup=texDelimiter start="\$\$" 			matchgroup=texDelimiter	end="\$\$"	end="%stopzone\>"	keepend	contains=@texMathZoneGroup
  endif
  syn region texMathZoneZ	matchgroup=texStatement start="\\ensuremath\s*{"	matchgroup=texStatement	end="}"		end="%stopzone\>"	contains=@texMathZoneGroup
 endif

 syn match texMathOper		"[_^=]" contained

 " Text Inside Math Zones: {{{2
 if s:tex_fast =~# 'M'
  if !exists("g:tex_nospell") || !g:tex_nospell
   syn region texMathText matchgroup=texStatement start='\\\(\(inter\)\=text\|mbox\)\s*{'	end='}'	contains=@texFoldGroup,@Spell
  else
   syn region texMathText matchgroup=texStatement start='\\\(\(inter\)\=text\|mbox\)\s*{'	end='}'	contains=@texFoldGroup
  endif
 endif

 " \left..something.. and \right..something.. support: {{{2
 syn match   texMathDelimBad	contained		"\S"
 if has("conceal") && &enc == 'utf-8' && s:tex_conceal =~# 'm'
  syn match   texMathDelim	contained		"\\left\["
  syn match   texMathDelim	contained		"\\left\\{"	skipwhite nextgroup=texMathDelimSet1,texMathDelimSet2,texMathDelimBad contains=texMathSymbol cchar={
  syn match   texMathDelim	contained		"\\right\\}"	skipwhite nextgroup=texMathDelimSet1,texMathDelimSet2,texMathDelimBad contains=texMathSymbol cchar=}
  let s:texMathDelimList=[
     \ ['<'            , '<'] ,
     \ ['>'            , '>'] ,
     \ ['('            , '('] ,
     \ [')'            , ')'] ,
     \ ['\['           , '['] ,
     \ [']'            , ']'] ,
     \ ['\\{'          , '{'] ,
     \ ['\\}'          , '}'] ,
     \ ['|'            , '|'] ,
     \ ['\\|'          , '???'] ,
     \ ['\\backslash'  , '\'] ,
     \ ['\\downarrow'  , '???'] ,
     \ ['\\Downarrow'  , '???'] ,
     \ ['\\lbrace'     , '['] ,
     \ ['\\lceil'      , '???'] ,
     \ ['\\lfloor'     , '???'] ,
     \ ['\\lgroup'     , '???'] ,
     \ ['\\lmoustache' , '???'] ,
     \ ['\\rbrace'     , ']'] ,
     \ ['\\rceil'      , '???'] ,
     \ ['\\rfloor'     , '???'] ,
     \ ['\\rgroup'     , '???'] ,
     \ ['\\rmoustache' , '???'] ,
     \ ['\\uparrow'    , '???'] ,
     \ ['\\Uparrow'    , '???'] ,
     \ ['\\updownarrow', '???'] ,
     \ ['\\Updownarrow', '???']]
  if &ambw == "double" || exists("g:tex_usedblwidth")
    let s:texMathDelimList= s:texMathDelimList + [
     \ ['\\langle'     , '???'] ,
     \ ['\\rangle'     , '???']]
  else
    let s:texMathDelimList= s:texMathDelimList + [
     \ ['\\langle'     , '<'] ,
     \ ['\\rangle'     , '>']]
  endif
  syn match texMathDelim	'\\[bB]igg\=[lr]' contained nextgroup=texMathDelimBad
  for texmath in s:texMathDelimList
   exe "syn match texMathDelim	'\\\\[bB]igg\\=[lr]\\=".texmath[0]."'	contained conceal cchar=".texmath[1]
  endfor

 else
  syn match   texMathDelim	contained		"\\\(left\|right\)\>"	skipwhite nextgroup=texMathDelimSet1,texMathDelimSet2,texMathDelimBad
  syn match   texMathDelim	contained		"\\[bB]igg\=[lr]\=\>"	skipwhite nextgroup=texMathDelimSet1,texMathDelimSet2,texMathDelimBad
  syn match   texMathDelimSet2	contained	"\\"		nextgroup=texMathDelimKey,texMathDelimBad
  syn match   texMathDelimSet1	contained	"[<>()[\]|/.]\|\\[{}|]"
  syn keyword texMathDelimKey	contained	backslash       lceil           lVert           rgroup          uparrow
  syn keyword texMathDelimKey	contained	downarrow       lfloor          rangle          rmoustache      Uparrow
  syn keyword texMathDelimKey	contained	Downarrow       lgroup          rbrace          rvert           updownarrow
  syn keyword texMathDelimKey	contained	langle          lmoustache      rceil           rVert           Updownarrow
  syn keyword texMathDelimKey	contained	lbrace          lvert           rfloor
 endif
 syn match   texMathDelim	contained		"\\\(left\|right\)arrow\>\|\<\([aA]rrow\|brace\)\=vert\>"
 syn match   texMathDelim	contained		"\\lefteqn\>"
endif

" Special TeX characters  ( \$ \& \% \# \{ \} \_ \S \P ) : {{{1
syn match texSpecialChar	"\\[$&%#{}_]"
if b:tex_stylish
  syn match texSpecialChar	"\\[SP@][^a-zA-Z@]"me=e-1
else
  syn match texSpecialChar	"\\[SP@]\A"me=e-1
endif
syn match texSpecialChar	"\\\\"
if !exists("g:tex_no_math")
 syn match texOnlyMath		"[_^]"
endif
syn match texSpecialChar	"\^\^[0-9a-f]\{2}\|\^\^\S"
if s:tex_conceal !~# 'S'
 syn match texSpecialChar	'\\glq\>'	contained conceal cchar=???
 syn match texSpecialChar	'\\grq\>'	contained conceal cchar=???
 syn match texSpecialChar	'\\glqq\>'	contained conceal cchar=???
 syn match texSpecialChar	'\\grqq\>'	contained conceal cchar=???
 syn match texSpecialChar	'\\hyp\>'	contained conceal cchar=-
endif

" Comments: {{{1
"    Normal TeX LaTeX     :   %....
"    Documented TeX Format:  ^^A...	-and-	leading %s (only)
if !s:tex_comment_nospell
 syn cluster texCommentGroup	contains=texTodo,@Spell
else
 syn cluster texCommentGroup	contains=texTodo,@NoSpell
endif
syn case ignore
syn keyword texTodo		contained		combak	fixme	todo	xxx
syn case match
if s:extfname == "dtx"
 syn match texComment		"\^\^A.*$"	contains=@texCommentGroup
 syn match texComment		"^%\+"		contains=@texCommentGroup
else
 if s:tex_fold_enabled
  " allows syntax-folding of 2 or more contiguous comment lines
  " single-line comments are not folded
  syn match  texComment	"%.*$"				contains=@texCommentGroup
  if s:tex_fast =~# 'c'
   TexFold syn region texComment						start="^\zs\s*%.*\_s*%"	skip="^\s*%"	end='^\ze\s*[^%]'	contains=@texCommentGroup
   TexFold syn region texNoSpell	contained	matchgroup=texComment	start="%\s*nospell\s*{"	end="%\s*nospell\s*}"			contains=@texFoldGroup,@NoSpell
  endif
 else
  syn match texComment		"%.*$"			contains=@texCommentGroup
  if s:tex_fast =~# 'c'
   syn region texNoSpell		contained	matchgroup=texComment start="%\s*nospell\s*{"	end="%\s*nospell\s*}"	contains=@texFoldGroup,@NoSpell
  endif
 endif
endif

" %begin-include ... %end-include acts like a texDocZone for \include'd files.  Permits spell checking, for example, in such files.
if !s:tex_nospell
 TexFold syn region texDocZone			matchgroup=texSection start='^\s*%begin-include\>'	 end='^\s*%end-include\>'											contains=@texFoldGroup,@texDocGroup,@Spell
else
 TexFold syn region texDocZone			matchgroup=texSection start='^\s*%begin-include\>'	 end='^\s*%end-include\>'											contains=@texFoldGroup,@texDocGroup
endif

" Separate lines used for verb` and verb# so that the end conditions {{{1
" will appropriately terminate.
" If g:tex_verbspell exists, then verbatim texZones will permit spellchecking there.
if s:tex_fast =~# 'v'
  if exists("g:tex_verbspell") && g:tex_verbspell
   syn region texZone		start="\\begin{[vV]erbatim}"		end="\\end{[vV]erbatim}\|%stopzone\>"	contains=@Spell
   " listings package:
   if b:tex_stylish
    syn region texZone		start="\\verb\*\=\z([^\ta-zA-Z@]\)"	end="\z1\|%stopzone\>"			contains=@Spell
   else
    syn region texZone		start="\\verb\*\=\z([^\ta-zA-Z]\)"	end="\z1\|%stopzone\>"			contains=@Spell
   endif
  else
   syn region texZone		start="\\begin{[vV]erbatim}"		end="\\end{[vV]erbatim}\|%stopzone\>"
   if b:tex_stylish
     syn region texZone		start="\\verb\*\=\z([^\ta-zA-Z@]\)"	end="\z1\|%stopzone\>"
   else
     syn region texZone		start="\\verb\*\=\z([^\ta-zA-Z]\)"	end="\z1\|%stopzone\>"
   endif
  endif
endif

" Tex Reference Zones: {{{1
if s:tex_fast =~# 'r'
  syn region texZone		matchgroup=texStatement start="@samp{"			end="}\|%stopzone\>"	contains=@texRefGroup
  syn region texRefZone		matchgroup=texStatement start="\\nocite{"		end="}\|%stopzone\>"	contains=@texRefGroup
  syn region texRefZone		matchgroup=texStatement start="\\bibliography{"		end="}\|%stopzone\>"	contains=@texRefGroup
  syn region texRefZone		matchgroup=texStatement start="\\label{"		end="}\|%stopzone\>"	contains=@texRefGroup
  syn region texRefZone		matchgroup=texStatement start="\\\(page\|eq\)ref{"	end="}\|%stopzone\>"	contains=@texRefGroup
  syn region texRefZone		matchgroup=texStatement start="\\v\=ref{"		end="}\|%stopzone\>"	contains=@texRefGroup
  syn region texRefOption	contained	matchgroup=texDelimiter start='\[' end=']'		contains=@texRefGroup,texRefZone	nextgroup=texRefOption,texCite
  syn region texCite		contained	matchgroup=texDelimiter start='{' end='}'		contains=@texRefGroup,texRefZone,texCite
endif
syn match  texRefZone		'\\cite\%([tp]\*\=\)\=\>' nextgroup=texRefOption,texCite

" Handle (re)newcommand, (re)newenvironment : {{{1
syn match  texNewCmd				"\\\%(re\)\=newcommand\>"		nextgroup=texCmdName skipwhite skipnl
if s:tex_fast =~# 'V'
  syn region texCmdName contained matchgroup=texDelimiter start="{"rs=s+1  end="}"		nextgroup=texCmdArgs,texCmdBody skipwhite skipnl
  syn region texCmdArgs contained matchgroup=texDelimiter start="\["rs=s+1 end="]"		nextgroup=texCmdBody skipwhite skipnl
  syn region texCmdBody contained matchgroup=texDelimiter start="{"rs=s+1 skip="\\\\\|\\[{}]"	matchgroup=texDelimiter end="}" contains=@texCmdGroup
endif
syn match  texNewEnv				"\\\%(re\)\=newenvironment\>"		nextgroup=texEnvName skipwhite skipnl
if s:tex_fast =~# 'V'
  syn region texEnvName contained matchgroup=texDelimiter start="{"rs=s+1  end="}"		nextgroup=texEnvBgn skipwhite skipnl
  syn region texEnvBgn  contained matchgroup=texDelimiter start="{"rs=s+1  end="}"		nextgroup=texEnvEnd skipwhite skipnl contains=@texEnvGroup
  syn region texEnvEnd  contained matchgroup=texDelimiter start="{"rs=s+1  end="}"		skipwhite skipnl contains=@texEnvGroup
endif

" Definitions/Commands: {{{1
syn match texDefCmd				"\\def\>"				nextgroup=texDefName skipwhite skipnl
if b:tex_stylish
  syn match texDefName contained		"\\[a-zA-Z@]\+"				nextgroup=texDefParms,texCmdBody skipwhite skipnl
  syn match texDefName contained		"\\[^a-zA-Z@]"				nextgroup=texDefParms,texCmdBody skipwhite skipnl
else
  syn match texDefName contained		"\\\a\+"				nextgroup=texDefParms,texCmdBody skipwhite skipnl
  syn match texDefName contained		"\\\A"					nextgroup=texDefParms,texCmdBody skipwhite skipnl
endif
syn match texDefParms  contained		"#[^{]*"	contains=texDefParm	nextgroup=texCmdBody skipwhite skipnl
syn match  texDefParm  contained		"#\d\+"

" TeX Lengths: {{{1
syn match  texLength		"\<\d\+\([.,]\d\+\)\=\s*\(true\)\=\s*\(bp\|cc\|cm\|dd\|em\|ex\|in\|mm\|pc\|pt\|sp\)\>"

" TeX String Delimiters: {{{1
syn match texString		"\(``\|''\|,,\)"

" makeatletter -- makeatother sections
if !s:tex_no_error
 if s:tex_fast =~# 'S'
  syn region texStyle			matchgroup=texStatement start='\\makeatletter' end='\\makeatother'	contains=@texStyleGroup contained
 endif
 syn match  texStyleStatement		"\\[a-zA-Z@]\+"	contained
 if s:tex_fast =~# 'S'
  syn region texStyleMatcher		matchgroup=texDelimiter start="{" skip="\\\\\|\\[{}]"	end="}"		contains=@texStyleGroup,texError	contained
  syn region texStyleMatcher		matchgroup=texDelimiter start="\["				end="]"		contains=@texStyleGroup,texError	contained
 endif
endif

" Conceal mode support (supports set cole=2) {{{1
if has("conceal") && &enc == 'utf-8'

 " Math Symbols {{{2
 " (many of these symbols were contributed by Bj??rn Winckler)
 if s:tex_conceal =~# 'm'
  let s:texMathList=[
    \ ['|'		, '???'],
    \ ['aleph'		, '???'],
    \ ['amalg'		, '???'],
    \ ['angle'		, '???'],
    \ ['approx'		, '???'],
    \ ['ast'		, '???'],
    \ ['asymp'		, '???'],
    \ ['backslash'	, '???'],
    \ ['bigcap'		, '???'],
    \ ['bigcirc'	, '???'],
    \ ['bigcup'		, '???'],
    \ ['bigodot'	, '???'],
    \ ['bigoplus'	, '???'],
    \ ['bigotimes'	, '???'],
    \ ['bigsqcup'	, '???'],
    \ ['bigtriangledown', '???'],
    \ ['bigtriangleup'	, '???'],
    \ ['bigvee'		, '???'],
    \ ['bigwedge'	, '???'],
    \ ['bot'		, '???'],
    \ ['bowtie'	        , '???'],
    \ ['bullet'	        , '???'],
    \ ['cap'		, '???'],
    \ ['cdot'		, '??'],
    \ ['cdots'		, '???'],
    \ ['circ'		, '???'],
    \ ['clubsuit'	, '???'],
    \ ['cong'		, '???'],
    \ ['coprod'		, '???'],
    \ ['copyright'	, '??'],
    \ ['cup'		, '???'],
    \ ['dagger'	        , '???'],
    \ ['dashv'		, '???'],
    \ ['ddagger'	, '???'],
    \ ['ddots'	        , '???'],
    \ ['diamond'	, '???'],
    \ ['diamondsuit'	, '???'],
    \ ['div'		, '??'],
    \ ['doteq'		, '???'],
    \ ['dots'		, '???'],
    \ ['downarrow'	, '???'],
    \ ['Downarrow'	, '???'],
    \ ['ell'		, '???'],
    \ ['emptyset'	, '???'],
    \ ['equiv'		, '???'],
    \ ['exists'		, '???'],
    \ ['flat'		, '???'],
    \ ['forall'		, '???'],
    \ ['frown'		, '???'],
    \ ['ge'		, '???'],
    \ ['geq'		, '???'],
    \ ['gets'		, '???'],
    \ ['gg'		, '???'],
    \ ['hbar'		, '???'],
    \ ['heartsuit'	, '???'],
    \ ['hookleftarrow'	, '???'],
    \ ['hookrightarrow'	, '???'],
    \ ['iff'            , '???'],
    \ ['Im'		, '???'],
    \ ['imath'		, '??'],
    \ ['in'		, '???'],
    \ ['infty'		, '???'],
    \ ['int'		, '???'],
    \ ['jmath'		, '????'],
    \ ['land'		, '???'],
    \ ['lceil'		, '???'],
    \ ['ldots'		, '???'],
    \ ['le'		, '???'],
    \ ['left|'		, '|'],
    \ ['left\\|'	, '???'],
    \ ['left('		, '('],
    \ ['left\['		, '['],
    \ ['left\\{'	, '{'],
    \ ['leftarrow'	, '???'],
    \ ['Leftarrow'	, '???'],
    \ ['leftharpoondown', '???'],
    \ ['leftharpoonup'	, '???'],
    \ ['leftrightarrow'	, '???'],
    \ ['Leftrightarrow'	, '???'],
    \ ['leq'		, '???'],
    \ ['leq'		, '???'],
    \ ['lfloor'		, '???'],
    \ ['ll'		, '???'],
    \ ['lmoustache'     , '???'],
    \ ['lor'		, '???'],
    \ ['mapsto'		, '???'],
    \ ['mid'		, '???'],
    \ ['models'		, '???'],
    \ ['mp'		, '???'],
    \ ['nabla'		, '???'],
    \ ['natural'	, '???'],
    \ ['ne'		, '???'],
    \ ['nearrow'	, '???'],
    \ ['neg'		, '??'],
    \ ['neq'		, '???'],
    \ ['ni'		, '???'],
    \ ['notin'		, '???'],
    \ ['nwarrow'	, '???'],
    \ ['odot'		, '???'],
    \ ['oint'		, '???'],
    \ ['ominus'		, '???'],
    \ ['oplus'		, '???'],
    \ ['oslash'		, '???'],
    \ ['otimes'		, '???'],
    \ ['owns'		, '???'],
    \ ['P'	        , '??'],
    \ ['parallel'	, '???'],
    \ ['partial'	, '???'],
    \ ['perp'		, '???'],
    \ ['pm'		, '??'],
    \ ['prec'		, '???'],
    \ ['preceq'		, '???'],
    \ ['prime'		, '???'],
    \ ['prod'		, '???'],
    \ ['propto'		, '???'],
    \ ['rceil'		, '???'],
    \ ['Re'		, '???'],
    \ ['quad'		, '???'],
    \ ['qquad'		, '???'],
    \ ['rfloor'		, '???'],
    \ ['right|'		, '|'],
    \ ['right\\|'	, '???'],
    \ ['right)'		, ')'],
    \ ['right]'		, ']'],
    \ ['right\\}'	, '}'],
    \ ['rightarrow'	, '???'],
    \ ['Rightarrow'	, '???'],
    \ ['rightleftharpoons', '???'],
    \ ['rmoustache'     , '???'],
    \ ['S'	        , '??'],
    \ ['searrow'	, '???'],
    \ ['setminus'	, '???'],
    \ ['sharp'		, '???'],
    \ ['sim'		, '???'],
    \ ['simeq'		, '???'],
    \ ['smile'		, '???'],
    \ ['spadesuit'	, '???'],
    \ ['sqcap'		, '???'],
    \ ['sqcup'		, '???'],
    \ ['sqsubset'	, '???'],
    \ ['sqsubseteq'	, '???'],
    \ ['sqsupset'	, '???'],
    \ ['sqsupseteq'	, '???'],
    \ ['star'		, '???'],
    \ ['subset'		, '???'],
    \ ['subseteq'	, '???'],
    \ ['succ'		, '???'],
    \ ['succeq'		, '???'],
    \ ['sum'		, '???'],
    \ ['supset'		, '???'],
    \ ['supseteq'	, '???'],
    \ ['surd'		, '???'],
    \ ['swarrow'	, '???'],
    \ ['times'		, '??'],
    \ ['to'		, '???'],
    \ ['top'		, '???'],
    \ ['triangle'	, '???'],
    \ ['triangleleft'	, '???'],
    \ ['triangleright'	, '???'],
    \ ['uparrow'	, '???'],
    \ ['Uparrow'	, '???'],
    \ ['updownarrow'	, '???'],
    \ ['Updownarrow'	, '???'],
    \ ['vdash'		, '???'],
    \ ['vdots'		, '???'],
    \ ['vee'		, '???'],
    \ ['wedge'		, '???'],
    \ ['wp'		, '???'],
    \ ['wr'		, '???']]
  if &ambw == "double" || exists("g:tex_usedblwidth")
    let s:texMathList= s:texMathList + [
    \ ['right\\rangle'	, '???'],
    \ ['left\\langle'	, '???']]
  else
    let s:texMathList= s:texMathList + [
    \ ['right\\rangle'	, '>'],
    \ ['left\\langle'	, '<']]
  endif
  for texmath in s:texMathList
   if texmath[0] =~# '\w$'
    exe "syn match texMathSymbol '\\\\".texmath[0]."\\>' contained conceal cchar=".texmath[1]
   else
    exe "syn match texMathSymbol '\\\\".texmath[0]."' contained conceal cchar=".texmath[1]
   endif
  endfor

  if &ambw == "double"
   syn match texMathSymbol '\\gg\>'			contained conceal cchar=???
   syn match texMathSymbol '\\ll\>'			contained conceal cchar=???
  else
   syn match texMathSymbol '\\gg\>'			contained conceal cchar=???
   syn match texMathSymbol '\\ll\>'			contained conceal cchar=???
  endif

  syn match texMathSymbol '\\hat{a}' contained conceal cchar=??
  syn match texMathSymbol '\\hat{A}' contained conceal cchar=??
  syn match texMathSymbol '\\hat{c}' contained conceal cchar=??
  syn match texMathSymbol '\\hat{C}' contained conceal cchar=??
  syn match texMathSymbol '\\hat{e}' contained conceal cchar=??
  syn match texMathSymbol '\\hat{E}' contained conceal cchar=??
  syn match texMathSymbol '\\hat{g}' contained conceal cchar=??
  syn match texMathSymbol '\\hat{G}' contained conceal cchar=??
  syn match texMathSymbol '\\hat{i}' contained conceal cchar=??
  syn match texMathSymbol '\\hat{I}' contained conceal cchar=??
  syn match texMathSymbol '\\hat{o}' contained conceal cchar=??
  syn match texMathSymbol '\\hat{O}' contained conceal cchar=??
  syn match texMathSymbol '\\hat{s}' contained conceal cchar=??
  syn match texMathSymbol '\\hat{S}' contained conceal cchar=??
  syn match texMathSymbol '\\hat{u}' contained conceal cchar=??
  syn match texMathSymbol '\\hat{U}' contained conceal cchar=??
  syn match texMathSymbol '\\hat{w}' contained conceal cchar=??
  syn match texMathSymbol '\\hat{W}' contained conceal cchar=??
  syn match texMathSymbol '\\hat{y}' contained conceal cchar=??
  syn match texMathSymbol '\\hat{Y}' contained conceal cchar=??
"  syn match texMathSymbol '\\bar{a}' contained conceal cchar=a??

  syn match texMathSymbol '\\dot{B}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{b}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{D}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{d}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{F}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{f}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{H}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{h}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{M}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{m}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{N}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{n}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{P}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{p}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{R}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{r}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{S}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{s}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{T}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{t}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{W}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{w}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{X}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{x}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{Y}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{y}' contained conceal cchar=???
  syn match texMathSymbol '\\dot{Z}' contained conceal cchar=??
  syn match texMathSymbol '\\dot{z}' contained conceal cchar=??

  syn match texMathSymbol '\\dot{C}' contained conceal cchar=??
  syn match texMathSymbol '\\dot{c}' contained conceal cchar=??
  syn match texMathSymbol '\\dot{E}' contained conceal cchar=??
  syn match texMathSymbol '\\dot{e}' contained conceal cchar=??
  syn match texMathSymbol '\\dot{G}' contained conceal cchar=??
  syn match texMathSymbol '\\dot{g}' contained conceal cchar=??
  syn match texMathSymbol '\\dot{I}' contained conceal cchar=??

  syn match texMathSymbol '\\dot{A}' contained conceal cchar=??
  syn match texMathSymbol '\\dot{a}' contained conceal cchar=??
  syn match texMathSymbol '\\dot{O}' contained conceal cchar=??
  syn match texMathSymbol '\\dot{o}' contained conceal cchar=??
 endif

 " Greek {{{2
 if s:tex_conceal =~# 'g'
  fun! s:Greek(group,pat,cchar)
    exe 'syn match '.a:group." '".a:pat."' contained conceal cchar=".a:cchar
  endfun
  call s:Greek('texGreek','\\alpha\>'		,'??')
  call s:Greek('texGreek','\\beta\>'		,'??')
  call s:Greek('texGreek','\\gamma\>'		,'??')
  call s:Greek('texGreek','\\delta\>'		,'??')
  call s:Greek('texGreek','\\epsilon\>'		,'??')
  call s:Greek('texGreek','\\varepsilon\>'	,'??')
  call s:Greek('texGreek','\\zeta\>'		,'??')
  call s:Greek('texGreek','\\eta\>'		,'??')
  call s:Greek('texGreek','\\theta\>'		,'??')
  call s:Greek('texGreek','\\vartheta\>'	,'??')
  call s:Greek('texGreek','\\iota\>'            ,'??')
  call s:Greek('texGreek','\\kappa\>'		,'??')
  call s:Greek('texGreek','\\lambda\>'		,'??')
  call s:Greek('texGreek','\\mu\>'		,'??')
  call s:Greek('texGreek','\\nu\>'		,'??')
  call s:Greek('texGreek','\\xi\>'		,'??')
  call s:Greek('texGreek','\\pi\>'		,'??')
  call s:Greek('texGreek','\\varpi\>'		,'??')
  call s:Greek('texGreek','\\rho\>'		,'??')
  call s:Greek('texGreek','\\varrho\>'		,'??')
  call s:Greek('texGreek','\\sigma\>'		,'??')
  call s:Greek('texGreek','\\varsigma\>'	,'??')
  call s:Greek('texGreek','\\tau\>'		,'??')
  call s:Greek('texGreek','\\upsilon\>'		,'??')
  call s:Greek('texGreek','\\phi\>'		,'??')
  call s:Greek('texGreek','\\varphi\>'		,'??')
  call s:Greek('texGreek','\\chi\>'		,'??')
  call s:Greek('texGreek','\\psi\>'		,'??')
  call s:Greek('texGreek','\\omega\>'		,'??')
  call s:Greek('texGreek','\\Gamma\>'		,'??')
  call s:Greek('texGreek','\\Delta\>'		,'??')
  call s:Greek('texGreek','\\Theta\>'		,'??')
  call s:Greek('texGreek','\\Lambda\>'		,'??')
  call s:Greek('texGreek','\\Xi\>'              ,'??')
  call s:Greek('texGreek','\\Pi\>'		,'??')
  call s:Greek('texGreek','\\Sigma\>'		,'??')
  call s:Greek('texGreek','\\Upsilon\>'		,'??')
  call s:Greek('texGreek','\\Phi\>'		,'??')
  call s:Greek('texGreek','\\Chi\>'		,'??')
  call s:Greek('texGreek','\\Psi\>'		,'??')
  call s:Greek('texGreek','\\Omega\>'		,'??')
  delfun s:Greek
 endif

 " Superscripts/Subscripts {{{2
 if s:tex_conceal =~# 's'
  if s:tex_fast =~# 's'
   syn region texSuperscript	matchgroup=texDelimiter start='\^{'	skip="\\\\\|\\[{}]" end='}'	contained concealends contains=texSpecialChar,texSuperscripts,texStatement,texSubscript,texSuperscript,texMathMatcher
   syn region texSubscript	matchgroup=texDelimiter start='_{'		skip="\\\\\|\\[{}]" end='}'	contained concealends contains=texSpecialChar,texSubscripts,texStatement,texSubscript,texSuperscript,texMathMatcher
  endif
  " s:SuperSub:
  fun! s:SuperSub(group,leader,pat,cchar)
    if a:pat =~# '^\\' || (a:leader == '\^' && a:pat =~# s:tex_superscripts) || (a:leader == '_' && a:pat =~# s:tex_subscripts)
"     call Decho("SuperSub: group<".a:group."> leader<".a:leader."> pat<".a:pat."> cchar<".a:cchar.">")
     exe 'syn match '.a:group." '".a:leader.a:pat."' contained conceal cchar=".a:cchar
     exe 'syn match '.a:group."s '".a:pat        ."' contained conceal cchar=".a:cchar.' nextgroup='.a:group.'s'
    endif
  endfun
  call s:SuperSub('texSuperscript','\^','0','???')
  call s:SuperSub('texSuperscript','\^','1','??')
  call s:SuperSub('texSuperscript','\^','2','??')
  call s:SuperSub('texSuperscript','\^','3','??')
  call s:SuperSub('texSuperscript','\^','4','???')
  call s:SuperSub('texSuperscript','\^','5','???')
  call s:SuperSub('texSuperscript','\^','6','???')
  call s:SuperSub('texSuperscript','\^','7','???')
  call s:SuperSub('texSuperscript','\^','8','???')
  call s:SuperSub('texSuperscript','\^','9','???')
  call s:SuperSub('texSuperscript','\^','a','???')
  call s:SuperSub('texSuperscript','\^','b','???')
  call s:SuperSub('texSuperscript','\^','c','???')
  call s:SuperSub('texSuperscript','\^','d','???')
  call s:SuperSub('texSuperscript','\^','e','???')
  call s:SuperSub('texSuperscript','\^','f','???')
  call s:SuperSub('texSuperscript','\^','g','???')
  call s:SuperSub('texSuperscript','\^','h','??')
  call s:SuperSub('texSuperscript','\^','i','???')
  call s:SuperSub('texSuperscript','\^','j','??')
  call s:SuperSub('texSuperscript','\^','k','???')
  call s:SuperSub('texSuperscript','\^','l','??')
  call s:SuperSub('texSuperscript','\^','m','???')
  call s:SuperSub('texSuperscript','\^','n','???')
  call s:SuperSub('texSuperscript','\^','o','???')
  call s:SuperSub('texSuperscript','\^','p','???')
  call s:SuperSub('texSuperscript','\^','r','??')
  call s:SuperSub('texSuperscript','\^','s','??')
  call s:SuperSub('texSuperscript','\^','t','???')
  call s:SuperSub('texSuperscript','\^','u','???')
  call s:SuperSub('texSuperscript','\^','v','???')
  call s:SuperSub('texSuperscript','\^','w','??')
  call s:SuperSub('texSuperscript','\^','x','??')
  call s:SuperSub('texSuperscript','\^','y','??')
  call s:SuperSub('texSuperscript','\^','z','???')
  call s:SuperSub('texSuperscript','\^','A','???')
  call s:SuperSub('texSuperscript','\^','B','???')
  call s:SuperSub('texSuperscript','\^','D','???')
  call s:SuperSub('texSuperscript','\^','E','???')
  call s:SuperSub('texSuperscript','\^','G','???')
  call s:SuperSub('texSuperscript','\^','H','???')
  call s:SuperSub('texSuperscript','\^','I','???')
  call s:SuperSub('texSuperscript','\^','J','???')
  call s:SuperSub('texSuperscript','\^','K','???')
  call s:SuperSub('texSuperscript','\^','L','???')
  call s:SuperSub('texSuperscript','\^','M','???')
  call s:SuperSub('texSuperscript','\^','N','???')
  call s:SuperSub('texSuperscript','\^','O','???')
  call s:SuperSub('texSuperscript','\^','P','???')
  call s:SuperSub('texSuperscript','\^','R','???')
  call s:SuperSub('texSuperscript','\^','T','???')
  call s:SuperSub('texSuperscript','\^','U','???')
  call s:SuperSub('texSuperscript','\^','V','???')
  call s:SuperSub('texSuperscript','\^','W','???')
  call s:SuperSub('texSuperscript','\^',',','???')
  call s:SuperSub('texSuperscript','\^',':','???')
  call s:SuperSub('texSuperscript','\^',';','???')
  call s:SuperSub('texSuperscript','\^','+','???')
  call s:SuperSub('texSuperscript','\^','-','???')
  call s:SuperSub('texSuperscript','\^','<','??')
  call s:SuperSub('texSuperscript','\^','>','??')
  call s:SuperSub('texSuperscript','\^','/','??')
  call s:SuperSub('texSuperscript','\^','(','???')
  call s:SuperSub('texSuperscript','\^',')','???')
  call s:SuperSub('texSuperscript','\^','\.','??')
  call s:SuperSub('texSuperscript','\^','=','??')
  call s:SuperSub('texSubscript','_','0','???')
  call s:SuperSub('texSubscript','_','1','???')
  call s:SuperSub('texSubscript','_','2','???')
  call s:SuperSub('texSubscript','_','3','???')
  call s:SuperSub('texSubscript','_','4','???')
  call s:SuperSub('texSubscript','_','5','???')
  call s:SuperSub('texSubscript','_','6','???')
  call s:SuperSub('texSubscript','_','7','???')
  call s:SuperSub('texSubscript','_','8','???')
  call s:SuperSub('texSubscript','_','9','???')
  call s:SuperSub('texSubscript','_','a','???')
  call s:SuperSub('texSubscript','_','e','???')
  call s:SuperSub('texSubscript','_','h','???')
  call s:SuperSub('texSubscript','_','i','???')
  call s:SuperSub('texSubscript','_','j','???')
  call s:SuperSub('texSubscript','_','k','???')
  call s:SuperSub('texSubscript','_','l','???')
  call s:SuperSub('texSubscript','_','m','???')
  call s:SuperSub('texSubscript','_','n','???')
  call s:SuperSub('texSubscript','_','o','???')
  call s:SuperSub('texSubscript','_','p','???')
  call s:SuperSub('texSubscript','_','r','???')
  call s:SuperSub('texSubscript','_','s','???')
  call s:SuperSub('texSubscript','_','t','???')
  call s:SuperSub('texSubscript','_','u','???')
  call s:SuperSub('texSubscript','_','v','???')
  call s:SuperSub('texSubscript','_','x','???')
  call s:SuperSub('texSubscript','_',',','???')
  call s:SuperSub('texSubscript','_','+','???')
  call s:SuperSub('texSubscript','_','-','???')
  call s:SuperSub('texSubscript','_','/','??')
  call s:SuperSub('texSubscript','_','(','???')
  call s:SuperSub('texSubscript','_',')','???')
  call s:SuperSub('texSubscript','_','\.','???')
  call s:SuperSub('texSubscript','_','r','???')
  call s:SuperSub('texSubscript','_','v','???')
  call s:SuperSub('texSubscript','_','x','???')
  call s:SuperSub('texSubscript','_','\\beta\>' ,'???')
  call s:SuperSub('texSubscript','_','\\delta\>','???')
  call s:SuperSub('texSubscript','_','\\phi\>'  ,'???')
  call s:SuperSub('texSubscript','_','\\gamma\>','???')
  call s:SuperSub('texSubscript','_','\\chi\>'  ,'???')

  delfun s:SuperSub
 endif

 " Accented characters and Ligatures: {{{2
 if s:tex_conceal =~# 'a'
  if b:tex_stylish
   syn match texAccent		"\\[bcdvuH][^a-zA-Z@]"me=e-1
   syn match texLigature	"\\\([ijolL]\|ae\|oe\|ss\|AA\|AE\|OE\)[^a-zA-Z@]"me=e-1
   syn match texLigature	'--'
   syn match texLigature	'---'
  else
   fun! s:Accents(chr,...)
     let i= 1
     for accent in ["`","\\'","^",'"','\~','\.','=',"c","H","k","r","u","v"]
      if i > a:0
       break
      endif
      if strlen(a:{i}) == 0 || a:{i} == ' ' || a:{i} == '?'
       let i= i + 1
       continue
      endif
      if accent =~# '\a'
       exe "syn match texAccent '".'\\'.accent.'\(\s*{'.a:chr.'}\|\s\+'.a:chr.'\)'."' conceal cchar=".a:{i}
      else
       exe "syn match texAccent '".'\\'.accent.'\s*\({'.a:chr.'}\|'.a:chr.'\)'."' conceal cchar=".a:{i}
      endif
      let i= i + 1
     endfor
   endfun
   "                  \`  \'  \^  \"  \~  \.  \=  \c  \H  \k  \r  \u  \v
   call s:Accents('a','??','??','??','??','??','??','??',' ',' ','??','??','??','??')
   call s:Accents('A','??','??','??','??','??','??','??',' ',' ','??','??','??','??')
   call s:Accents('c',' ','??','??',' ',' ','??',' ','??',' ',' ',' ',' ','??')
   call s:Accents('C',' ','??','??',' ',' ','??',' ','??',' ',' ',' ',' ','??')
   call s:Accents('d',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','??')
   call s:Accents('D',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','??')
   call s:Accents('e','??','??','??','??','???','??','??','??',' ','??',' ','??','??')
   call s:Accents('E','??','??','??','??','???','??','??','??',' ','??',' ','??','??')
   call s:Accents('g',' ','??','??',' ',' ','??',' ','??',' ',' ',' ','??','??')
   call s:Accents('G',' ','??','??',' ',' ','??',' ','??',' ',' ',' ','??','??')
   call s:Accents('h',' ',' ','??',' ',' ',' ',' ',' ',' ',' ',' ',' ','??')
   call s:Accents('H',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','??')
   call s:Accents('i','??','??','??','??','??','??','??',' ',' ','??',' ','??','??')
   call s:Accents('I','??','??','??','??','??','??','??',' ',' ','??',' ','??','??')
   call s:Accents('J',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ','??')
   call s:Accents('k',' ',' ',' ',' ',' ',' ',' ','??',' ',' ',' ',' ','??')
   call s:Accents('K',' ',' ',' ',' ',' ',' ',' ','??',' ',' ',' ',' ','??')
   call s:Accents('l',' ','??','??',' ',' ',' ',' ','??',' ',' ',' ',' ','??')
   call s:Accents('L',' ','??','??',' ',' ',' ',' ','??',' ',' ',' ',' ','??')
   call s:Accents('n',' ','??',' ',' ','??',' ',' ','??',' ',' ',' ',' ','??')
   call s:Accents('N',' ','??',' ',' ','??',' ',' ','??',' ',' ',' ',' ','??')
   call s:Accents('o','??','??','??','??','??','??','??',' ','??','??',' ','??','??')
   call s:Accents('O','??','??','??','??','??','??','??',' ','??','??',' ','??','??')
   call s:Accents('r',' ','??',' ',' ',' ',' ',' ','??',' ',' ',' ',' ','??')
   call s:Accents('R',' ','??',' ',' ',' ',' ',' ','??',' ',' ',' ',' ','??')
   call s:Accents('s',' ','??','??',' ',' ',' ',' ','??',' ','??',' ',' ','??')
   call s:Accents('S',' ','??','??',' ',' ',' ',' ','??',' ',' ',' ',' ','??')
   call s:Accents('t',' ',' ',' ',' ',' ',' ',' ','??',' ',' ',' ',' ','??')
   call s:Accents('T',' ',' ',' ',' ',' ',' ',' ','??',' ',' ',' ',' ','??')
   call s:Accents('u','??','??','??','??','??',' ','??',' ','??','??','??','??','??')
   call s:Accents('U','??','??','??','??','??',' ','??',' ','??','??','??','??','??')
   call s:Accents('w',' ',' ','??',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ')
   call s:Accents('W',' ',' ','??',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ')
   call s:Accents('y','???','??','??','??','???',' ',' ',' ',' ',' ',' ',' ',' ')
   call s:Accents('Y','???','??','??','??','???',' ',' ',' ',' ',' ',' ',' ',' ')
   call s:Accents('z',' ','??',' ',' ',' ','??',' ',' ',' ',' ',' ',' ','??')
   call s:Accents('Z',' ','??',' ',' ',' ','??',' ',' ',' ',' ',' ',' ','??')
   call s:Accents('\\i','??','??','??','??','??','??',' ',' ',' ',' ',' ','??',' ')
   "                    \`  \'  \^  \"  \~  \.  \=  \c  \H  \k  \r  \u  \v
   delfun s:Accents
   syn match texAccent		'\\aa\>'	conceal cchar=??
   syn match texAccent		'\\AA\>'	conceal cchar=??
   syn match texAccent		'\\o\>'		conceal cchar=??
   syn match texAccent		'\\O\>'		conceal cchar=??
   syn match texLigature	'\\AE\>'	conceal cchar=??
   syn match texLigature	'\\ae\>'	conceal cchar=??
   syn match texLigature	'\\oe\>'	conceal cchar=??
   syn match texLigature	'\\OE\>'	conceal cchar=??
   syn match texLigature	'\\ss\>'	conceal cchar=??
   syn match texLigature	'--'		conceal cchar=???
   syn match texLigature	'---'		conceal cchar=???
  endif
 endif
endif

" ---------------------------------------------------------------------
" LaTeX synchronization: {{{1
syn sync maxlines=200
syn sync minlines=50

syn  sync match texSyncStop			groupthere NONE		"%stopzone\>"

" Synchronization: {{{1
" The $..$ and $$..$$ make for impossible sync patterns
" (one can't tell if a "$$" starts or stops a math zone by itself)
" The following grouptheres coupled with minlines above
" help improve the odds of good syncing.
if !exists("g:tex_no_math")
 syn sync match texSyncMathZoneA		groupthere NONE		"\\end{abstract}"
 syn sync match texSyncMathZoneA		groupthere NONE		"\\end{center}"
 syn sync match texSyncMathZoneA		groupthere NONE		"\\end{description}"
 syn sync match texSyncMathZoneA		groupthere NONE		"\\end{enumerate}"
 syn sync match texSyncMathZoneA		groupthere NONE		"\\end{itemize}"
 syn sync match texSyncMathZoneA		groupthere NONE		"\\end{table}"
 syn sync match texSyncMathZoneA		groupthere NONE		"\\end{tabular}"
 syn sync match texSyncMathZoneA		groupthere NONE		"\\\(sub\)*section\>"
endif

" ---------------------------------------------------------------------
" Highlighting: {{{1

" Define the default highlighting. {{{1
if !exists("skip_tex_syntax_inits")

  " TeX highlighting groups which should share similar highlighting
  if !exists("g:tex_no_error")
   if !exists("g:tex_no_math")
    hi def link texBadMath		texError
    hi def link texBadPar		texBadMath
    hi def link texMathDelimBad		texError
    hi def link texMathError		texError
    if !b:tex_stylish
      hi def link texOnlyMath		texError
    endif
   endif
   hi def link texError			Error
  endif

  hi texBoldStyle		gui=bold	cterm=bold
  hi texItalStyle		gui=italic	cterm=italic
  hi texBoldItalStyle		gui=bold,italic cterm=bold,italic
  hi texItalBoldStyle		gui=bold,italic cterm=bold,italic
  hi def link texEmphStyle	texItalStyle
  hi def link texCite		texRefZone
  hi def link texDefCmd		texDef
  hi def link texDefName	texDef
  hi def link texDocType	texCmdName
  hi def link texDocTypeArgs	texCmdArgs
  hi def link texInputFileOpt	texCmdArgs
  hi def link texInputCurlies	texDelimiter
  hi def link texLigature	texSpecialChar
  if !exists("g:tex_no_math")
   hi def link texMathDelimSet1	texMathDelim
   hi def link texMathDelimSet2	texMathDelim
   hi def link texMathDelimKey	texMathDelim
   hi def link texMathMatcher	texMath
   hi def link texAccent	texStatement
   hi def link texGreek		texStatement
   hi def link texSuperscript	texStatement
   hi def link texSubscript	texStatement
   hi def link texSuperscripts 	texSuperscript
   hi def link texSubscripts 	texSubscript
   hi def link texMathSymbol	texStatement
   hi def link texMathZoneV	texMath
   hi def link texMathZoneW	texMath
   hi def link texMathZoneX	texMath
   hi def link texMathZoneY	texMath
   hi def link texMathZoneV	texMath
   hi def link texMathZoneZ	texMath
  endif
  hi def link texBeginEnd	texCmdName
  hi def link texBeginEndName	texSection
  hi def link texSpaceCode	texStatement
  hi def link texStyleStatement	texStatement
  hi def link texTypeSize	texType
  hi def link texTypeStyle	texType

   " Basic TeX highlighting groups
  hi def link texCmdArgs	Number
  hi def link texCmdName	Statement
  hi def link texComment	Comment
  hi def link texDef		Statement
  hi def link texDefParm	Special
  hi def link texDelimiter	Delimiter
  hi def link texInput		Special
  hi def link texInputFile	Special
  hi def link texLength		Number
  hi def link texMath		Special
  hi def link texMathDelim	Statement
  hi def link texMathOper	Operator
  hi def link texNewCmd		Statement
  hi def link texNewEnv		Statement
  hi def link texOption		Number
  hi def link texRefZone	Special
  hi def link texSection	PreCondit
  hi def link texSpaceCodeChar	Special
  hi def link texSpecialChar	SpecialChar
  hi def link texStatement	Statement
  hi def link texString		String
  hi def link texTodo		Todo
  hi def link texType		Type
  hi def link texZone		PreCondit

endif

" Cleanup: {{{1
delc TexFold
unlet s:extfname
let   b:current_syntax = "tex"
let &cpo               = s:keepcpo
unlet s:keepcpo
" vim: ts=8 fdm=marker

