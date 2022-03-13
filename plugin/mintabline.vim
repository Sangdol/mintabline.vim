"
" Minimal Tabline
"

function! s:bufname(bufnr, is_term)
    let bufname = bufname(a:bufnr)
    if a:is_term
      " For Neovim terminal
      " `b:term_title` has a path and a shell name e.g, '~/folder-name - fish'
      let term_title = getbufvar(a:bufnr, 'term_title')
      if stridx(term_title, ' - ') >= 0
        let bufname = split(term_title, ' - ')[0]
      endif
    endif

    return bufname
endfunction

function! s:icon(bufname, is_term) abort
    let icon = ''

    if has('nvim')
      let icon = luaeval("require('deviconutil').get_icon(_A)", a:bufname)
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

function! s:mergedlabel(bufname, icon) abort
    let bufname = fnamemodify(a:bufname, ':t')
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

function! s:tablabel(bufnr) abort
    let is_term = getbufvar(a:bufnr, '&buftype') == 'terminal'
    let bufname = s:bufname(a:bufnr, is_term)
    let icon = s:icon(bufname, is_term)

    return s:mergedlabel(bufname, icon)
endfunction

function! s:bufmodified(bufnr) abort
  return getbufvar(a:bufnr, "&mod") ? '+ ' : ''
endfunction

function! mintabline#main() abort
  let line = ''

  for i in range(tabpagenr('$'))
    let tabnr = i + 1
    let winnr = tabpagewinnr(tabnr)
    let buflist = tabpagebuflist(tabnr)
    let bufnr = buflist[winnr - 1]

    let line .= '%' .. tabnr .. 'T' " tab number for mouse click
    let line .= (tabnr == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#') " for highlighting
    let line .= ' ' .. tabnr ..' '
    let line .= s:tablabel(bufnr)
    let line .= s:bufmodified(bufnr)
  endfor

  let line .= '%#TabLineFill#'

  return line
endfunction

set tabline=%!mintabline#main()

