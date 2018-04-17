" ============================================================================
" File:        leaderf.vim
" Description:
" Author:      xltan <lidmuse@gmail.com>
" Website:     https://github.com/xltan
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

command! -bar -nargs=? LeaderfTjump call leaderf#Tjump#startExpl(g:Lf_WindowPosition, <f-args>)

hi link Lf_hl_match Statement
hi link Lf_hl_matchRefine Statement

hi link Lf_hl_Tag_StlName Normal
hi link Lf_hl_Tag_StlCategory Normal
hi link Lf_hl_Tag_StlNameOnlyMode Normal
hi link Lf_hl_Tag_StlFullPathMode Normal
hi link Lf_hl_Tag_StlFuzzyMode Normal
hi link Lf_hl_Tag_StlRegexMode Normal
hi link Lf_hl_Tag_StlCwd Normal
hi link Lf_hl_Tag_StlBlank Normal
hi link Lf_hl_Tag_StlLineInfo Normal
hi link Lf_hl_Tag_StlTotal Normal
hi link Lf_hl_Tag_StlSeparator3 Normal

hi link Lf_hl_BufTag_StlName Normal
hi link Lf_hl_BufTag_StlCategory Normal
hi link Lf_hl_BufTag_StlNameOnlyMode Normal
hi link Lf_hl_BufTag_StlFullPathMode Normal
hi link Lf_hl_BufTag_StlFuzzyMode Normal
hi link Lf_hl_BufTag_StlRegexMode Normal
hi link Lf_hl_BufTag_StlCwd Normal
hi link Lf_hl_BufTag_StlBlank Normal
hi link Lf_hl_BufTag_StlLineInfo Normal
hi link Lf_hl_BufTag_StlTotal Normal
hi link Lf_hl_BufTag_StlSeparator3 Normal

hi link Lf_hl_Mru_StlName Normal
hi link Lf_hl_Mru_StlCategory Normal
hi link Lf_hl_Mru_StlNameOnlyMode Normal
hi link Lf_hl_Mru_StlFullPathMode Normal
hi link Lf_hl_Mru_StlFuzzyMode Normal
hi link Lf_hl_Mru_StlRegexMode Normal
hi link Lf_hl_Mru_StlCwd Normal
hi link Lf_hl_Mru_StlBlank Normal
hi link Lf_hl_Mru_StlLineInfo Normal
hi link Lf_hl_Mru_StlTotal Normal
hi link Lf_hl_Mru_StlSeparator3 Normal

hi link Lf_hl_File_StlName Normal
hi link Lf_hl_File_StlCategory Normal
hi link Lf_hl_File_StlNameOnlyMode Normal
hi link Lf_hl_File_StlFullPathMode Normal
hi link Lf_hl_File_StlFuzzyMode Normal
hi link Lf_hl_File_StlRegexMode Normal
hi link Lf_hl_File_StlCwd Normal
hi link Lf_hl_File_StlBlank Normal
hi link Lf_hl_File_StlLineInfo Normal
hi link Lf_hl_File_StlTotal Normal
hi link Lf_hl_File_StlSeparator3 Normal
