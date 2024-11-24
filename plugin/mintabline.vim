"
" Minimal Tabline
"

let g:ellipsis = '…'

" Returns the buffer name
function! s:bufname(tabnr, bufnr, is_term, is_active_tab) abort
    let bufname = bufname(a:bufnr)
    if a:is_term
      " For Neovim terminal
      " `b:term_title` has a path and a shell name e.g, '~/folder-name - fish'
      let term_title = getbufvar(a:bufnr, 'term_title')
      if stridx(term_title, ' - ') >= 0
        let bufname = split(term_title, ' - ')[0]
      endif
    endif

    let bufname = fnamemodify(bufname, ':t')
    let label = gettabvar(a:tabnr, "tab_label", "")
    let bufname = (label == "" ? "" : (label . ":")) . bufname

    if !a:is_active_tab
          \ && exists('g:mintabline_tab_max_chars')
          \ && len(bufname) > g:mintabline_tab_max_chars
      let bufname = strpart(bufname, 0, g:mintabline_tab_max_chars) . g:ellipsis
    endif

    return bufname
endfunction

" Returns the icon for the buffer
function! s:icon(bufname, is_term, is_active_tab) abort
    let icon = ''

    if has('nvim')
      let icon = luaeval("require('deviconutil').get_icon(_A[1],_A[2])", [a:bufname, a:is_active_tab])
    else
      if exists('*WebDevIconsGetFileTypeSymbol')
        let icon = WebDevIconsGetFileTypeSymbol(a:bufname)
      endif
    endif

    if icon != '' && a:is_term
      let icon = ''
    endif

    return icon
endfunction

" Merges the buffer name and icon
function! s:mergedlabel(bufname, icon) abort
  let bufname = a:bufname
    let icon = a:icon

    if bufname != '' && icon != ''
      let label = bufname .. ' ' .. icon
    elseif bufname != '' && icon == ''
      let label = bufname
    elseif bufname == '' && icon != ''
      let label = icon
    else
      let label = 'No Name'
    endif

    return label .. ' '
endfunction

" Returns the tab label
function! s:tablabel(tabnr, bufnr, is_active_tab) abort
    let is_term = getbufvar(a:bufnr, '&buftype') == 'terminal'
    let original_bufname = bufname(a:bufnr)
    let icon = s:icon(original_bufname, is_term, a:is_active_tab)
    let bufname = s:bufname(a:tabnr, a:bufnr, is_term, a:is_active_tab)

    return s:mergedlabel(bufname, icon)
endfunction

function! s:bufmodified(bufnr) abort
  return getbufvar(a:bufnr, "&mod") ? '+ ' : ''
endfunction

function! mintabline#main() abort
  let tabs = []
  let raw_tabs = [] " To calculate tabline length without highlighting

  " Populate the tabs array with each tab's formatted string
  for i in range(tabpagenr('$'))
    let tabnr = i + 1
    let winnr = tabpagewinnr(tabnr)
    let buflist = tabpagebuflist(tabnr)
    let bufnr = buflist[winnr - 1]

    let is_active_tab = tabnr == tabpagenr()
    let tab = '%' .. tabnr .. 'T'  " Tab number for mouse click
    let tab .= (is_active_tab ? '%#TabLineSel#' : '%#TabLine#')  " Highlighting
    let tab .= ' ' .. tabnr .. ' '
    let tab .= s:tablabel(tabnr, bufnr, is_active_tab)
    let tab .= s:bufmodified(bufnr)

    let raw_tab = ' ' .. tabnr .. ' ' . s:tablabel(tabnr, bufnr, is_active_tab) . s:bufmodified(bufnr)
    let raw_tab = substitute(raw_tab, "%#[a-zA-Z]\\+#", "", "g")
    call add(tabs, tab)
    call add(raw_tabs, raw_tab)
  endfor

  " Safety counter to prevent infinite loop
  let max_iterations = len(tabs) - 1
  let iteration_count = 0

  let is_left_truncated = v:false
  let is_right_truncated = v:false
  let window_width = &columns
  let active_tab_index = tabpagenr() - 1

  " Truncate tabs to fit window width
  while window_width < strchars(join(raw_tabs, ''))
    if iteration_count >= max_iterations
      break
    endif
    let should_remove_left = active_tab_index > len(tabs) / 2
    if should_remove_left
      call remove(tabs, 0)
      call remove(raw_tabs, 0)
      let active_tab_index -= 1
      let is_left_truncated = v:true
    else
      call remove(tabs, -1)
      call remove(raw_tabs, -1)
      let is_right_truncated = v:true
    endif
    let iteration_count += 1
  endwhile

  " Concatenate tabs with ellipsis if truncated
  let line = join(tabs, '')
  if is_left_truncated
    let line = g:ellipsis .. line
  endif
  if is_right_truncated
    let line = line .. g:ellipsis
  endif

  let line .= '%#TabLineFill#'

  return line
endfunction

set tabline=%!mintabline#main()
