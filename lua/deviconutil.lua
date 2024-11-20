--
-- Devicons Util for nvim
--
local M = {}
local fn = vim.fn


function M.get_icon(bufname, is_selected)
  is_selected = is_selected ~= 0
  local loaded, webdev_icons = pcall(require, "nvim-web-devicons")
  if loaded then
    icon, hlgroup = webdev_icons.get_icon(fn.fnamemodify(bufname, ":r"), fn.fnamemodify(bufname, ":e"), { default = true })
    hlgroup = M.get_hlgroup(hlgroup, is_selected)
    return '%#' .. hlgroup .. '#' .. icon
  end
  local devicons_loaded = fn.exists("*WebDevIconsGetFileTypeSymbol") > 0
  return devicons_loaded and fn.WebDevIconsGetFileTypeSymbol(bufname) or ""
end


-- Construct/update a new icon-specific highlight group with the correct background for the tabline
function M.get_hlgroup(hlgroup, is_selected)
  local tab_hl, tab_attrs
  if is_selected then
    tab_hl = "TabLineSel" .. hlgroup
    tab_attrs = vim.api.nvim_get_hl(0, { name = "TabLineSel" })
  else
    tab_hl = "TabLine" .. hlgroup
    tab_attrs = vim.api.nvim_get_hl(0, { name = "TabLine" })
  end

  local custom_attrs = vim.api.nvim_get_hl(0, { name = hlgroup })
  vim.api.nvim_set_hl(0, tab_hl, vim.tbl_extend("force", tab_attrs, custom_attrs))

  return tab_hl
end

return M
