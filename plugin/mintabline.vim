"
" Minimal Tabline
"
function! s:tablabel(bufnr) abort
    let bufname = bufname(a:bufnr)

    " For Neovim terminal
    " `b:term_title` has a path and a shell name e.g, '~/folder-name - fish'
    let term_title = getbufvar(a:bufnr, 'term_title')
    let is_term = stridx(term_title, ' - ') >= 0
    let icon = ''
    if is_term
      let icon = ''
      let bufname = split(term_title, ' - ')[0]
    else
      if has('nvim') 
        let icon = luaeval("require('deviconutil').get_icon(_A)", bufname)
      else
        if exists('*WebDevIconsGetFileTypeSymbol')
          let icon = WebDevIconsGetFileTypeSymbol(bufname)
        endif
      endif
    endif

    " vim-devicons
    if icon != ''
      let bufname .= ' ' .. icon
    endif

    " 'No Name' won't be used if vim-devicons is installed.
    return (bufname != '' ? '' .. fnamemodify(bufname, ':t') .. ' ' : 'No Name ')
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

