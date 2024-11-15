--
-- Devicons Util for nvim
--
local M = {}
local fn = vim.fn

function M.get_icon(bufname)
  local loaded, webdev_icons = pcall(require, "nvim-web-devicons")
  if loaded then
    icon, hlgroup = webdev_icons.get_icon(fn.fnamemodify(bufname, ":r"), fn.fnamemodify(bufname, ":e"), { default = true })
    return '%#' .. hlgroup .. '#' .. icon
  end
  local devicons_loaded = fn.exists("*WebDevIconsGetFileTypeSymbol") > 0
  return devicons_loaded and fn.WebDevIconsGetFileTypeSymbol(bufname) or ""
end

return M
