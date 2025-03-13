" 防止重复加载并检查版本
if exists('g:loaded_popup_demo') || v:version < 801
    finish
endif
let g:loaded_popup_demo = 1

" 定义菜单选项
let s:menu_items = ['Open File', 'Save File', 'Quit']
let s:current_idx = 1
let s:winid = -1

function! UpdateMenuDisplay()
    if s:winid == -1 || !popup_getpos(s:winid).visible
        return
    endif
    let l:display = []
    for i in range(len(s:menu_items))
        let l:prefix = (i + 1 == s:current_idx) ? '> ' : '  '
        call add(l:display, l:prefix . s:menu_items[i] . '  ')
    endfor
    call popup_settext(s:winid, l:display)
    " 应该是 vim 问题，popup_setoptions 第二次是无效的
    " call popup_setoptions(a:id, {'curidx': s:current_idx})
    " redraw!
endfunction

" 主函数：创建并显示菜单
function! ShowMenu()
    " 获取窗口尺寸
    let l:win_width = winwidth(0)
    let l:win_height = winheight(0)
    
    " 计算菜单尺寸
    let l:menu_width = 0
    for l:item in s:menu_items
        let l:menu_width = max([l:menu_width, len(l:item) + 4])  " +4 for prefix and spaces
    endfor
    
    let l:menu_height = len(s:menu_items)
    
    " 计算居中位置
    let l:line = (l:win_height - l:menu_height) / 2
    let l:col = (l:win_width - l:menu_width) / 2

    " 关闭已有窗口
    if s:winid != -1 && popup_getpos(s:winid).visible
        call popup_close(s:winid)
    endif

    " 创建浮动窗口，居中显示
    let s:winid = popup_create(s:menu_items, {
        \ 'line': l:line,
        \ 'col': l:col,
        \ 'border': [1, 1, 1, 1],
        \ 'filter': 'MenuFilter',
        \ 'callback': 'MenuCallback',
        \ })
    let s:current_idx = 1
    call UpdateMenuDisplay()
    echom "Menu created at line: " . l:line . ", col: " . l:col
endfunction

function! MenuFilter(id, key)
    echom "Key: " . a:key . ", Current idx: " . s:current_idx
    if a:key == "\<Down>" || a:key == "j"
        let s:current_idx = s:current_idx >= len(s:menu_items) ? 1 : s:current_idx + 1
        call UpdateMenuDisplay()
        return 1
    elseif a:key == "\<Up>" || a:key == "k"
        let s:current_idx = s:current_idx <= 1 ? len(s:menu_items) : s:current_idx - 1
        call UpdateMenuDisplay()
        return 1
    elseif a:key == "\<CR>" || a:key == "\<Enter>"
        call popup_close(a:id, s:current_idx)
        return 1
    elseif a:key == "\<Esc>" || a:key == "q"
        call popup_close(a:id, -1)
        return 1
    endif
    return 0
endfunction

" 回调函数：处理选择结果
function! MenuCallback(id, result)
    if a:result > 0
        let l:selected = s:menu_items[a:result - 1]
        echo "Selected: " . l:selected
    else
        echo "Menu cancelled"
    endif
    let s:winid = -1  " 重置窗口 ID
endfunction

" 设置命令
command! ShowMenu call ShowMenu()

function! s:AutoShowMenu()
    let l:line = getline('.')
    let l:col = col('.') - 1
    if l:col < 1 || l:line[l:col] !~ '\w'
        return
    endif
    let l:start = l:col
    while l:start > 0 && l:line[l:start-1] =~ '\w'
        let l:start -= 1
    endwhile
    let l:word = l:line[l:start:l:col]
    if strlen(l:word) == 2  " 输入第2个字符时触发
        call ShowMenuAtCursor()
    endif
endfunction
