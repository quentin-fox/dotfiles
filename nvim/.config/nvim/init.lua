-- vim:foldmethod=marker

--    _         _  _       _
--   (_)       (_)| |     | |
--    _  _ __   _ | |_    | | _   _   __ _
--   | || '_ \ | || __|   | || | | | / _` |
--   | || | | || || |_  _ | || |_| || (_| |
--   |_||_| |_||_| \__|(_)|_| \__,_| \__,_|

--  modules

require('plugin')
require('lsp')

--
--  global options

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
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.pumheight = 5

vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'

-- default indentation

vim.opt.list = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.wrapmargin = 0
vim.opt.autoindent = true

-- override $VIMRUNTIME/ftplugin/*.vim adding cro to the formatoptions opt

vim.api.nvim_create_autocmd('Filetype', {
  pattern = '*',
  callback = function()
    vim.opt.formatoptions:remove('r')
    vim.opt.formatoptions:remove('o')
    vim.opt.formatoptions:remove('c')
  end
})

-- neovide

vim.g.neovide_cursor_animation_length = 0

-- diagnostic

local min_severity = {
  min = vim.diagnostic.severity.INFO
}

vim.diagnostic.config {
  severity_sort = true,
  underline = {
    severity = min_severity,
  },
  virtual_text = {
    severity = min_severity,
  },
  signs = {
    severity = min_severity,
  },
  float = {
    severity = min_severity,
  },
}

--
--  colorscheme

local colorscheme = 'onedark'
local background = 'dark'

if vim.env.THEME == 'light' then
  colorscheme = 'one'
  background = 'light'
else
  vim.highlight.create('Folded', { guifg = 'Gray', guibg = '#1c1c1c' })
end


vim.cmd('colorscheme ' .. colorscheme)
vim.opt.background = background
vim.opt.termguicolors = true

local colors = {
  error = '#be5046',
  warn = '#e5c07b',
  info = '#abb2bf',
  hint = '#abc2af',
}

-- open hover window after updatetime without cursor moving
vim.opt.updatetime = 1500
local group = vim.api.nvim_create_augroup('DiagnosticCursorHold', { clear = true })
vim.api.nvim_create_autocmd('CursorHold', { callback = vim.diagnostic.open_float, group = group })

vim.highlight.create('DiagnosticError', { guifg = colors.error }, false)
vim.highlight.create('DiagnosticWarn', { guifg = colors.warn }, false)
vim.highlight.create('DiagnosticInfo', { guifg = colors.info }, false)
vim.highlight.create('DiagnosticHint', { guifg = colors.hint }, false)

-- no underlines desired
vim.highlight.create('DiagnosticUnderlineError', { guifg = colors.error, gui = 'NONE' }, false)
vim.highlight.create('DiagnosticUnderlineWarn', { guifg = colors.warn, gui = 'NONE' }, false)
vim.highlight.create('DiagnosticUnderlineInfo', { guifg = colors.info, gui = 'NONE' }, false)
vim.highlight.create('DiagnosticUnderlineHint', { guifg = colors.hint, gui = 'NONE' }, false)

vim.highlight.create('DiagnosticStatusError', { guifg = '#262626', guibg = colors.error }, false)
vim.highlight.create('DiagnosticStatusWarn', { guifg = '#262626', guibg = colors.warn }, false)
vim.highlight.create('DiagnosticStatusInfo', { guifg = '#262626', guibg = colors.info }, false)
vim.highlight.create('DiagnosticStatusHint', { guifg = '#262626', guibg = colors.hint }, false)

vim.cmd([[sign define DiagnosticSignError text=> texthl=DiagnosticSignError linehl= numhl=]])
vim.cmd([[sign define DiagnosticSignWarn text=? texthl=DiagnosticSignWarn linehl= numhl=]])
vim.cmd([[sign define DiagnosticSignInfo text=? texthl=DiagnosticSignInfo linehl= numhl=]])
vim.cmd([[sign define DiagnosticSignInfo text=? texthl=DiagnosticSignHint linehl= numhl=]])

vim.highlight.create('CursorLineNr', { guifg = 'Gray', guibg = 'NONE' })

vim.highlight.link('VertSplit', 'Normal', true)

--
--  plugin setup

require('colorizer').setup()

require('nvim-autopairs').setup {
  check_ts = true,
}

require('nvim-treesitter.configs').setup {
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
    "markdown",
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

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filename' },
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
          error = 'DiagnosticStatusError',
          warn = 'DiagnosticStatusWarn',
          info = 'DiagnosticStatusInfo',
        },
        colored = true,
        update_in_insert = false,
        always_visible = false
      }
    },
    lualine_x = {},
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { 'filename' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
}

require('nnn').setup {
  layout = {
    window = { width = 0.9, height = 0.6, highlight = 'Debug' },
  },
  action = {
    ['<C-t>'] = 'tab split',
    ['<C-x>'] = 'split',
    ['<C-v>'] = 'vsplit',
  },
}

require('telescope').setup {
  defaults = {
    layout_strategy = 'vertical',
    layout_config = { height = 0.8 },
  }
}

require('dressing').setup {
  input = {
    enabled = true,
    winblend = 0,
    border = 'rounded',
    winhighlight = 'NormalFloat:Normal',
    insert_only = false
  },
  select = {
    enabled = true,
    backend = { 'telescope' },
    builtin = {
      winblend = 0,
      border = 'rounded',
      winhighlight = 'NormalFloat:Normal',
      relative = 'cursor',
    },
  },
}

require('octo').setup {
  file_panel = {
    use_icons = false
  }
}

--
--  basic keybindings

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

local win_keys = { '<C-h>', '<C-j>', '<C-k>', '<C-l>' }

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
vim.keymap.set('n', 'k', function()
  return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true })

-- capitalize current letter

vim.keymap.set('n', 'M', 'gUl')

-- replace current word in line

vim.keymap.set('n', 'X', ':s/<C-r><C-w>//g<Left><Left>')

-- clear highlight

vim.keymap.set('n', '-', '<cmd>nohlsearch<Cr>', { silent = true })

-- jump forward that doesn't conflict with tab (<C-i> = <Tab>)

vim.keymap.set('n', '<C-p>', '<C-i>')

--
--  plugin keybindings

vim.keymap.set('n', '<Tab>', function()
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

vim.keymap.set('n', '<leader>dg', function()
  require('telescope.builtin').diagnostics({
    severity_limit = vim.diagnostic.severity.INFO
  })
end)

vim.keymap.set('n', '<S-Tab>', function()
  require('telescope.builtin').live_grep({
    additional_args = function() return { '--hidden', '--glob', '!.git/' } end
  })
end)

vim.keymap.set('n', '~', '<cmd>Git<Cr>')

vim.keymap.set('n', 'gn', '<cmd>NnnPicker<Cr>')
vim.keymap.set('n', 'gm', '<cmd>NnnPicker %:p:h<Cr>')

--
