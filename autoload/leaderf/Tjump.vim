" ============================================================================
" File:        Tjump.vim
" Description:
" Note:
" License:     Apache License, Version 2.0
" ============================================================================

if leaderf#versionCheck() == 0  " this check is necessary
    finish
endif

exec g:Lf_py "import vim, sys, os.path"
exec g:Lf_py "cwd = vim.eval('expand(\"<sfile>:p:h\")')"
exec g:Lf_py "sys.path.insert(0, os.path.join(cwd, 'python'))"
exec g:Lf_py "from tjumpExpl import *"

function! leaderf#Tjump#Maps()
    nmapclear <buffer>
    nnoremap <buffer> <silent> <CR>          :exec g:Lf_py "tjumpExplManager.accept()"<CR>
    nnoremap <buffer> <silent> o             :exec g:Lf_py "tjumpExplManager.accept()"<CR>
    nnoremap <buffer> <silent> <2-LeftMouse> :exec g:Lf_py "tjumpExplManager.accept()"<CR>
    nnoremap <buffer> <silent> x             :exec g:Lf_py "tjumpExplManager.accept('h')"<CR>
    nnoremap <buffer> <silent> v             :exec g:Lf_py "tjumpExplManager.accept('v')"<CR>
    nnoremap <buffer> <silent> t             :exec g:Lf_py "tjumpExplManager.accept('t')"<CR>
    nnoremap <buffer> <silent> q             :exec g:Lf_py "tjumpExplManager.quit()"<CR>
    nnoremap <buffer> <silent> i             :exec g:Lf_py "tjumpExplManager.input()"<CR>
    nnoremap <buffer> <silent> <F1>          :exec g:Lf_py "tjumpExplManager.toggleHelp()"<CR>
    if has_key(g:Lf_NormalMap, "Tjump")
        for i in g:Lf_NormalMap["Tjump"]
            exec 'nnoremap <buffer> <silent> '.i[0].' '.i[1]
        endfor
    endif
endfunction

function! leaderf#Tjump#startExpl(win_pos, ...)
    call leaderf#LfPy("tjumpExplManager.startExplorer('".a:win_pos."','".a:1."')")
endfunction
