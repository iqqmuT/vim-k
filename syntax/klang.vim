" Vim syntax file
" Language: Kymdata K Language
" Maintainer: Tuomas Jaakola <tuomas.jaakola@iki.fi>
" Latest Revision: 06 November 2016

" http://vim.wikia.com/wiki/Creating_your_own_syntax_files#Install_the_syntax_file

if exists("b:current_syntax")
  finish
end

" Use C syntax as base
runtime! syntax/c.vim

" Keywords
syn keyword kLangType INT REAL STRING
syn keyword kLangKeywords PROGRAM STOP AND OR GOTO FUNCTION PROCEDURE ON_ERR ON_ESC NOT
syn keyword kLangFunctions Abs22cc Acos Angle360 Asin Atan Cc2abs Ceil Cos Cosh Exp Floor Hypot Iabs Ln Log Mod Pol Pow Rabs Rand Rec Rotate2d Round Sin Sinh Sqr Sqrt Tan Tanh Distline Lineip Mapcoord Normalip Pfromline Asc Chr Chartooem Oemtochar Strcat Strcmp Strdate Strdel Strfill Stricmp Strins Strlen Strlwr Strmid Strrev Strset Strstr Strtime Strupr Strval Valstr Chdir Close Copy Delete Eof Exists Findfirst Findnext Findrec Iostat Mkdir Open Read Readbuf Readln Rename Rmdir Seek Setkey Tell Write Writeln Cads Cls Getfilename Getkey Getpoint Input Keyhit Print Setcursor Using Atexit Invoke Invokeres Getvar Setvar Degree Radian Grad Arc Box Circle Lineto Linerel Moveto Moverel Setcolor Setfmode Setwmode Text Chain Date Graphmode Pause Textmode Time Typein Searchelem Searcharea Select Sdel Sput Sset Searchlayer Tablenext Sget Ename NextObject PrevObject Ename Getobject Getobjecttype Eget Hget Modobject Emod Edel Hmod Update Aname Aget Amod
syn keyword kLangStatements BEGIN IF THEN ELSE END REPEAT WHILE UNTIL FOR TO STEP DO
syn keyword kLangConstants TRUE FALSE

" Constants from ddb.h
syn keyword kLangConstants E_LINE E_POINT E_CIRCLE E_ARC E_TEXT E_SOLID E_PLINE E_VERTEX E_SYMBOL E_DIM E_ATTDEF E_ATTRIB E_ELLIPSE E_SYMDEF E_SYMEND E_SEQEND E_VIEWPORT E_SPLINE E_HATCH E_LEADER E_TOLERANCE E_MTEXT E_FACE3D T_LTYPE T_LAYER T_STYLE T_DIMSTYLE T_LAYOUT T_SYMBOL T_VPORT T_APPID T_UCS T_VIEW T_GROUP FIRST LAST NEXT NO_ATTRS NO_MORE_ATTRS SS_SAVE SS_DELETE OD_TYPE OD_COLOR OD_DBI OD_HSTYLE OD_HDIMSTYLE OD_HLAYER OD_HSYMDEF OD_HFIRST OD_HSYMBOL OD_HMAIN OD_FLAGS OD_ALIGN OD_GENFLAGS OD_DIMTYPE OD_ROWCOL OD_CTYPE OD_STAT OD_LINEW OD_NORMAL OD_HLAST OD_THICKNESS OD_ANGLE OD_OBANGLE OD_R OD_SIZE OD_SCALE OD_SPACING OD_LEADER OD_WIDTH OD_BULGE OD_TANGDIR OD_RATIO OD_PARAM OD_HEIGHT OD_ID OD_STATE OD_SNAPSTYLE OD_SNAPISOPAIR OD_SNAPMODE OD_GRIDMODE OD_P OD_IP OD_RP OD_ORIGO OD_NAME OD_TEXT OD_TAG OD_PROMPT OD_FONT ATTRFOLLOW VERTFOLLOW PAPERSPACE SELECTED DELETED OFF LOCKED BACKWARDS UPSIDEDOWN HLEFT HCENTER HRIGHT HALIGNED MIDDLE HFIT VBASELINE VBOTTOM VMIDDLE VTOP DIMLINEAR DIMANGULAR DIMDIAMETER DIMRADIUS DIMARC DIMTEXTUSERPOS DIMALIGNED DIMBASEPOINT LWBYLAYER LWBYLOCK LWDEFAULT

" Constants from wapi.h
syn keyword kLangConstants MB_OK MB_OKCANCEL MB_ABORTRETRYIGNORE MB_YESNOCANCEL MB_YESNO MB_RETRYCANCEL MB_ICONHAND MB_ICONQUESTION MB_ICONEXCLAMATION MB_ICONASTERISK MB_ICONWARNING MB_ICONERROR MB_ICONINFORMATION MB_ICONSTOP MB_DEFBUTTON1 MB_DEFBUTTON2 MB_DEFBUTTON3 MB_DEFBUTTON4 MB_SETFOREGROUND MB_DEFAULT_DESKTOP_ONLY MB_TOPMOST MB_RIGHT MB_RTLREADING IDOK IDCANCEL IDABORT IDRETRY IDIGNORE IDYES IDNO IDCLOSE
 
" Setup syntax highlighting
let b:current_syntax = "klang"

hi def link kLangType Type
hi def link kLangKeywords Keyword
hi def link kLangFunctions Function
hi def link kLangStatements Statement
hi def link kLangConstants Constant
