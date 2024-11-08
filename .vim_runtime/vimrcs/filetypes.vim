""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python map <buffer> F :set foldmethod=indent<cr>

au FileType python inoremap <buffer> $r return 
au FileType python inoremap <buffer> $i import 
au FileType python inoremap <buffer> $p print 
au FileType python inoremap <buffer> $f # --- <esc>a
au FileType python map <buffer> <leader>1 /class 
au FileType python map <buffer> <leader>2 /def 
au FileType python map <buffer> <leader>C ?class 
au FileType python map <buffer> <leader>D ?def 


""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
" au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

function! JavaScriptFold() 
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction


""""""""""""""""""""""""""""""
" => Shell section
""""""""""""""""""""""""""""""
if exists('$TMUX') 
    if has('nvim')
        set termguicolors
    else
        set term=screen-256color 
    endif
endif


""""""""""""""""""""""""""""""
" => Markdown
""""""""""""""""""""""""""""""
let vim_markdown_folding_disabled = 1

""""""""""""""""""""""""""""""
" => switch from .(ts|tsx) to _test.(ts|tsx) and vice-versa
""""""""""""""""""""""""""""""
au FileType typescript nnoremap <buffer> <leader>tt :call <SID>ToggleTestFile()<cr>
au FileType typescriptreact nnoremap <buffer> <leader>tt :call <SID>ToggleTestFile()<cr>

function! s:ToggleTestFile()
  let l:file = expand('%')
  let l:dir = expand('%:p:h')
  let l:base = fnamemodify(l:file, ':t:r')
  let l:ext = fnamemodify(l:file, ':e')
  if l:base =~ '_test$'
    let l:new_file = l:dir . '/' . substitute(l:base, '_test$', '', '') . '.' . l:ext
  else
    let l:new_file = l:dir . '/' . l:base . '_test.' . l:ext
  endif
  execute 'e ' . l:new_file
endfunction
