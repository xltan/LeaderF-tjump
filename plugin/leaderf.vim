" ============================================================================
" File:        leaderf.vim
" Description:
" Author:      xltan <lidmuse@gmail.com>
" Website:     https://github.com/xltan
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

command! -bar -nargs=? LeaderfTjump call leaderf#Tjump#startExpl(g:Lf_WindowPosition, <f-args>)

