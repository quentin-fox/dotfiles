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
-- vim.opt.shell = '/opt/homebrew/bin/fish'
vim.opt.mouse = 'a'
vim.opt.mousemodel = 'extend'
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

-- saves files in $XDG_STATE_HOME/nvim/undo//
-- so doesn't clog up the project directory with undo files
vim.opt.undofile = true

-- default indentation

vim.opt.list = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.wrapmargin = 0
vim.opt.autoindent = true

-- use filetype.lua

vim.g.do_filetype_lua = 1

-- netrw disabled for nvim-tree

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
  vim.api.nvim_set_hl(0, 'Folded', { fg = 'Gray', bg = '#1c1c1c' })
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
local group = vim.api.nvim_create_augroup('DiagnosticCursorHold', { clear = true })
vim.api.nvim_create_autocmd('CursorHold', { callback = vim.diagnostic.open_float, group = group })

vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = colors.error, default = false })
vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = colors.warn, default = false })
vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = colors.info, default = false })
vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = colors.hint, default = false })

-- no underlines desired
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { fg = colors.error, underline = false, default = false })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { fg = colors.warn, underline = false, default = false })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { fg = colors.info, underline = false, default = false })
vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { fg = colors.hint, underline = false, default = false })

vim.api.nvim_set_hl(0, 'DiagnosticStatusError', { fg = '#262626', bg = colors.error, default = false })
vim.api.nvim_set_hl(0, 'DiagnosticStatusWarn', { fg = '#262626', bg = colors.warn, default = false })
vim.api.nvim_set_hl(0, 'DiagnosticStatusInfo', { fg = '#262626', bg = colors.info, default = false })
vim.api.nvim_set_hl(0, 'DiagnosticStatusHint', { fg = '#262626', bg = colors.hint, default = false })

vim.cmd([[sign define DiagnosticSignError text=> texthl=DiagnosticSignError linehl= numhl=]])
vim.cmd([[sign define DiagnosticSignWarn text=? texthl=DiagnosticSignWarn linehl= numhl=]])
vim.cmd([[sign define DiagnosticSignInfo text=? texthl=DiagnosticSignInfo linehl= numhl=]])
vim.cmd([[sign define DiagnosticSignInfo text=? texthl=DiagnosticSignHint linehl= numhl=]])

vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = 'Gray', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'VertSplit', { link = 'Normal', default = false })

-- due to treesitter change, that highlights it as an Identifier
-- vim.api.nvim_set_hl(0, '@variable', { link = 'Normal' })
-- vim.api.nvim_set_hl(0, 'Tag', { link = 'Identifier' })

vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

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
    "gleam",
    "go",
    "gomod",
    "haskell",
    "hcl",
    "html",
    "java",
    "javascript",
    "lua",
    "markdown",
    "ruby",
    "scss",
    "sql",
    "svelte",
    "terraform",
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

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'g<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
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

require('telescope').setup {
  defaults = {
    layout_strategy = 'vertical',
    layout_config = { height = 0.8 },
    color_devicons = false
  }
}

require('nvim-tree').setup {
  modified = {
    enable = true,
  },
  renderer = {
    icons = {
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
        git = false,
        modified = true,
      },
      modified_placement = 'before',
      glyphs = {
        modified = 'M'
      }
    },
    indent_markers = {
      enable = true
    },
    special_files = {}
  },
}

require("lsp-file-operations").setup()

require('dressing').setup {
  input = {
    enabled = true,
    border = 'rounded',
    insert_only = false,
    win_options = {
      winblend = 0,
      winhighlight = 'NormalFloat:Normal'
    },
  },
  select = {
    enabled = true,
    backend = { 'telescope' },
    builtin = {
      border = 'rounded',
      relative = 'cursor',
      win_options = {
        winblend = 0,
        winhighlight = 'NormalFloat:Normal'
      },
    },
  },
}

-- require('octo').setup {
--   file_panel = {
--     use_icons = false
--   }
-- }

--  basic keybindings

-- system c&p

vim.keymap.set('v', 'sy', '"+y')
vim.keymap.set('n', 'sy', '"+y')
vim.keymap.set('n', 'sY', '"+yg_')

vim.keymap.set('v', 'sp', '"+p')
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

vim.keymap.set('n', 'gp', '`[v`]')

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

vim.keymap.set('n', 'gm', function()
  require('nvim-tree.api').tree.open({
    path = vim.fn.expand('%:p:h'),
    find_file = true,
    update_root = true
  })
end)

vim.keymap.set('n', 'gn', require('nvim-tree.api').tree.open)

-- telescope fuzzy search operator

local function fuzzy_search_operator(motion)
  if motion == nil then
    vim.opt.operatorfunc = 'v:lua.fuzzy_search_operator'
    return 'g@'
  end

  if motion == 'char' then
    local row = 1
    local col = 2


    local text_start = vim.api.nvim_buf_get_mark(0, '[')
    local text_end = vim.api.nvim_buf_get_mark(0, ']')

    local lines = vim.api.nvim_buf_get_text(0, text_start[row] - 1, text_start[col], text_end[row] - 1, text_end[col] + 1, {})

    require('telescope.builtin').grep_string({
      search = lines[1],
    })
  else
    print("must use char motion")
  end
end

_G.fuzzy_search_operator = fuzzy_search_operator

-- gt = go telescope
vim.keymap.set('n', 'gt', fuzzy_search_operator, { expr = true })
