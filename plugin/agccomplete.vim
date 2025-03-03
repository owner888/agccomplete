"=============================================================================
" FILE: agccomplete.vim
" AUTHOR:  Seatle <seatle888@gmail.com>
" Last Modified: 3 Mar 2025
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
" Version: 1.0.0, for Vim 8.x
"=============================================================================

if exists('g:loaded_agccomplete')
  finish
endif

let g:loaded_agccomplete = 1

let s:disable_agccomplete = 1

let s:AgcComplete = {}

command! -nargs=0 AgcCompleteEnable call s:AgcComplete.Enable()
command! -nargs=0 AgcCompleteDisable call s:AgcComplete.Disable()
command! -nargs=0 AgcCompleteToggle call s:AgcComplete.Toggle()

" Complete 开关
function! s:AgcComplete.Toggle()"{{{
    echomsg "AgcComplete.Toggle()"
    if s:disable_agccomplete
        let s:disable_agccomplete = 0
        call s:AgcComplete.Enable()
    else
        let s:disable_agccomplete = 1
        call s:AgcComplete.Disable()
    endif
endfunction"}}}

" Complete 打开
function! s:AgcComplete.Enable()"{{{
    echomsg "AgcComplete.Enable()"
endfunction"}}}

" Complete 关闭
function! s:AgcComplete.Disable()"{{{
    echomsg "AgcComplete.Disable()"
endfunction"}}}

" vim: foldmethod=marker
