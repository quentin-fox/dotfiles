local M = {}

function M.use_tabs(width)
  vim.bo.expandtab = false
  vim.bo.tabstop = width
  vim.bo.softtabstop = width
  vim.bo.shiftwidth = width
  vim.wo.list = false
end

function M.use_spaces(width)
  vim.bo.expandtab = true
  vim.bo.tabstop = width
  vim.bo.softtabstop = width
  vim.bo.shiftwidth = width
  vim.wo.list = true
end

return M
