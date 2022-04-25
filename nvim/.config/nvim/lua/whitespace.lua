local M = {}

function M.use_tabs(width)
  vim.opt.expandtab = false
  vim.opt.tabstop = width
  vim.opt.softtabstop = width
  vim.opt.shiftwidth = width
  vim.opt.list = false
end

function M.use_spaces(width)
  vim.opt.expandtab = true
  vim.opt.tabstop = width
  vim.opt.softtabstop = width
  vim.opt.shiftwidth = width
  vim.opt.list = true
end

return M
