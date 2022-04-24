require('plugin')
require('lsp')

-- global options

vim.opt.hidden = false
vim.opt.shell = '/opt/homebrew/bin/fish'
vim.opt.mouse = 'a'
vim.opt.confirm = true
vim.opt.termencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.inccommand = 'nosplit'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.textwidth = 0
vim.opt.wrap = true
vim.opt.list = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.pumheight = 5

-- default indentation

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth= 2
vim.opt.wrapmargin = 0
vim.opt.autoindent = true

-- colorscheme

vim.cmd('colorscheme onedark')
vim.opt.background = 'dark'
vim.opt.termguicolors = true

-- plugin setup

require('colorizer').setup()

require('nvim-autopairs').setup{
  check_ts = true,
}

require('nvim-treesitter.configs').setup{
  ensure_installed = {
    "css",
    "fish",
    "go",
    "gomod",
    "hcl",
    "html",
    "java",
    "javascript",
    "lua",
    "scss",
    "svelte",
    "tsx",
    "typescript",
    "yaml",
  },
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
}

vim.highlight.create('DiagnosticErrorSign', {guifg = '#262626', guibg = '#be5046' }, false)
vim.highlight.create('DiagnosticWarnSign', {guifg = '#262626', guibg = '#e5c07b' }, false)
vim.highlight.create('DiagnosticInfoSign', {guifg = '#262626', guibg = '#abb2bf' }, false)

require('lualine').setup{
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = { left = ' ', right = ' ' },
    section_separators = { left = ' ', right = ' ' },
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'filename'},
    lualine_c = {
      {
        'diagnostics',
        sources = { 'nvim_lsp' },
        sections = { 'error', 'warn', 'info' },
        symbols = {
          error = '● ',
          warn = '● ',
          info = '● ',
        },
        diagnostics_color = {
          error = 'DiagnosticErrorSign',
          warn = 'DiagnosticWarnSign',
          info = 'DiagnosticInfoSign',
        },
        colored = true,
        update_in_insert = false,
        always_visible = false
      }
    },
    lualine_x = {},
    lualine_y = {'progress'},
    lualine_z = {'location'},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {'filename'},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {'progress'},
    lualine_z = {'location'},
  },
}

require('nnn').setup{
  layout = {
    window = { width = 0.9, height = 0.6, highlight = 'Debug' },
  },
  action = {
    ['<C-t>'] = 'tab split',
    ['<C-x>'] = 'split',
    ['<C-v>'] = 'vsplit',
  },
}

-- basic keybindings

-- system c&p
vim.keymap.set('v', 'sy', '"+y')
vim.keymap.set('n', 'sy', '"+y')
vim.keymap.set('n', 'sY', '"+yg_')
vim.keymap.set('n', 'sp', '"+p')
vim.keymap.set('n', 'sP', '"+P')

-- undo

vim.keymap.set('n', 'U', '<C-r>')

-- align text after jumping

vim.keymap.set('n', 'g;', 'g;zz')
vim.keymap.set('n', 'g,', 'g,zz')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

-- gp to select what was last pasted

vim.keymap.set('n', 'gp', '`v`')

-- simpler window navigation

local win_keys = {'<C-h>', '<C-j>', '<C-k>', '<C-l>'}

for _, key in ipairs(win_keys) do
  vim.keymap.set('n', key, '<C-w>' .. key)
  vim.keymap.set('t', key, [[<C-\><C-n><C-w>]] .. key)
end

vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])
vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]])

-- linewise navigation on wrapped lines

vim.keymap.set('n', 'j', function()
  return vim.v.count == 0 and 'gj' or 'j'
end, { expr = true })
vim.keymap.set('n', 'g', function()
  return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true })

-- capitalize current letter

vim.keymap.set('n', 'M', 'gUl')

-- replace current word in line

vim.keymap.set('n', 'X', '<cmd>s/<C-r><C-w>//g<Left><Left>')

-- plugin keybindings

vim.keymap.set('n', '<Tab>', function ()
  require('telescope.builtin').find_files({
    find_command = {
      'fd',
      '--hidden',
      '--type', 'f',
      '--exclude', '.git/',
      '--strip-cwd-prefix'
    }
  })
end)
vim.keymap.set('n', '<S-Tab>', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>dg', require('telescope.builtin').diagnostics)

vim.keymap.set('n', '~', '<cmd>Git<Cr>')

vim.keymap.set('n', 'gn', '<cmd>NnnPicker<Cr>')
vim.keymap.set('n', 'gm', '<cmd>NnnPicker %:p:h<Cr>')
