-- vim:foldmethod=marker

--    _         _  _       _
--   (_)       (_)| |     | |
--    _  _ __   _ | |_    | | _   _   __ _
--   | || '_ \ | || __|   | || | | | / _` |
--   | || | | || || |_  _ | || |_| || (_| |
--   |_||_| |_||_| \__|(_)|_| \__,_| \__,_|


--

vim.g.codeium_disable_bindings = 1

--  modules

require('plugin')
require('lsp')

--
--  global options

vim.opt.hidden = false
-- vim.opt.shell = '/opt/homebrew/bin/fish'
vim.opt.mouse = 'a'
vim.opt.mousemodel = 'popup_setpos'
vim.opt.confirm = true
vim.opt.inccommand = 'nosplit'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.textwidth = 0
vim.opt.wrap = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.pumheight = 5
vim.opt.scrolloff = 10

vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = false
vim.opt.foldlevel = 0

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

local diag_colors = {
  error = '#be5046',
  warn = '#e5c07b',
  info = '#abb2bf',
  hint = '#abc2af',
}

local palette = {
  -- whites, lightest to darkest, slightly beige-y
  white1 = "#faf4de",
  white2 = "#d2d4ca",
  white3 = "#a5a59f",
  white4 = "#878783",

  -- blacks, darkest to lightest
  black0 = "#121212",
  black1 = "#161616",
  black2 = "#202020",
  black3 = "#262626",
  black4 = "#323232",
  black5 = "#353535",

  -- 
  gray1 = "#393836",
  gray2 = "#6a6a6a",

  -- colors
  blue = "#7eafd9",
  blue_light = "#69b8ff",
  blue_dark = "#3b6487",
  blue_darkest = "#254c6e",

  red = "#cc4b4b",
  red_light = "#d66c63",
  red_dark = "#91342c",
  red_darkest = "#661912",

  green = "#96c475",
  green_light = "#a7c98f",
  green_dark = "#52703d",
  green_darkest = "#2f4520",

  yellow = "#e5c07b",
  yellow_light = "#e8c980",
  yellow_dark = "#b58222",

  aqua = "#7aa89f",
  aqua_light = "#93cfc7",
  aqua_dark = "#5d8c86",

  violet = "#957fb8",
  violet_light = "#b6a3d4",
  violet_dark = "#665182",
  violet_darkest = "#3b2a52",
}

local theme = {
  ui = {
    fg         = palette.white2,
    fg_dim     = palette.white3,
    fg_reverse = palette.gray2,

    bg_dim     = palette.black3,
    bg_gutter  = palette.black3,

    bg_m3      = palette.black3,
    bg_m2      = palette.black1,
    bg_m1      = palette.black2,
    bg         = palette.black3,
    bg_p1      = palette.black4,
    bg_p2      = palette.black5,

    special    = palette.white4,
    whitespace = palette.black5,
    nontext    = palette.black5,

    bg_visual  = palette.gray1,
    bg_search  = palette.gray2,

    pmenu      = {
      fg       = palette.white2,
      fg_sel   = palette.white1,
      bg       = palette.black4,
      bg_sel   = palette.white3,
      bg_thumb = palette.black4,
      bg_sbar  = palette.black4,
    },

    float      = {
      fg        = palette.white3,
      bg        = palette.black3,
      fg_border = palette.white3,
      bg_border = palette.black3,
    },
  },

  syn = {
    string     = palette.green,
    variable   = palette.blue_light,
    number     = palette.aqua_dark,
    constant   = palette.blue_light,
    identifier = palette.blue,
    parameter  = palette.blue,
    fun        = palette.red,
    statement  = palette.yellow_light,
    keyword    = palette.yellow_light,
    operator   = palette.white3,
    preproc    = palette.yellow_light,
    type       = palette.yellow,
    regex      = palette.violet,
    deprecated = palette.gray1,
    punct      = palette.white3,
    comment    = palette.gray2,
    special1   = palette.red,
    special2   = palette.red,
    special3   = palette.violet_light,
  },
  diag = {
    error   = palette.red,
    ok      = palette.green,
    warning = palette.yellow,
    info    = palette.white1,
    hint    = palette.blue_light,
  },
  diff = {
    add    = palette.green_darkest,
    delete = palette.red_darkest,
    change = palette.blue_darkest,
    text   = palette.violet_darkest,
  },
  vcs = {
    added   = palette.green_darkest,
    removed = palette.red_darkest,
    changed = palette.blue_darkest,
  },
}

require('kanagawa').setup({
  compile = true,             -- enable compiling the colorscheme
  undercurl = false,            -- enable undercurls
  commentStyle = { italic = false },
  functionStyle = {},
  keywordStyle = { italic = false },
  statementStyle = { bold = false },
  typeStyle = {},
  transparent = false,         -- do not set background color
  dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
  terminalColors = true,       -- define vim.g.terminal_color_{0,17}
  colors = {                   -- add/modify theme and palette colors
    theme = {
      wave = {},
      lotus = {},
      dragon = theme,
      all = {
        ui = {
          bg_gutter = "none"
        }
      },
    },
  },
  overrides = function(colors)
    local theme = colors.theme

    return {
      Directory = { fg = palette.blue },

      NormalFloat = { bg = "none" },
      FloatBorder = { bg = "none" },
      FloatTitle = { bg = "none" },

      LineNr = { fg = theme.ui.fg_reverse, bg = "none" },
      CursorLineNr = { fg = theme.ui.fg, bg = "none" },

      WinSeparator = { fg = palette.white4 },

      ["@variable"] = { fg = theme.syn.variable },

      DiagnosticError = { fg = theme.diag.error, default = false },
      DiagnosticWarn = { fg = theme.diag.warning, default = false },
      DiagnosticInfo = { fg = theme.diag.info, default = false },
      DiagnosticHint = { fg = theme.diag.hint, default = false },

      DiagnosticUnderlineError = { fg = theme.diag.error, default = false, underline = false },
      DiagnosticUnderlineWarn = { fg = theme.diag.warning, default = false, underline = false },
      DiagnosticUnderlineInfo = { fg = theme.diag.info, default = false, underline = false },
      DiagnosticUnderlineHint = { fg = theme.diag.hint, default = false, underline = false },

      DiagnosticStatusError = { fg = theme.ui.bg_m1, bg = theme.diag.error, default = false },
      DiagnosticStatusWarn = { fg = theme.ui.bg_m1, bg = theme.diag.warning, default = false },
      DiagnosticStatusInfo = { fg = theme.ui.bg_m1, bg = theme.diag.info, default = false },
      DiagnosticStatusHint = { fg = theme.ui.bg_m1, bg = theme.diag.hint, default = false },
    }
  end,
  theme = "dragon",              -- Load "wave" theme when 'background' option is not set
  background = {               -- map the value of 'background' option to a theme
    dark = "dragon",           -- try "dragon" !
    light = "lotus"
  },
})

vim.cmd('colorscheme kanagawa-dragon')

vim.opt.background = 'dark'
vim.opt.termguicolors = true

-- open hover window after updatetime without cursor moving
local group = vim.api.nvim_create_augroup('DiagnosticCursorHold', { clear = true })
vim.api.nvim_create_autocmd('CursorHold', { callback = vim.diagnostic.open_float, group = group })

vim.cmd([[sign define DiagnosticSignError text=> texthl=DiagnosticSignError linehl= numhl=]])
vim.cmd([[sign define DiagnosticSignWarn text=? texthl=DiagnosticSignWarn linehl= numhl=]])
vim.cmd([[sign define DiagnosticSignInfo text=? texthl=DiagnosticSignInfo linehl= numhl=]])
vim.cmd([[sign define DiagnosticSignInfo text=? texthl=DiagnosticSignHint linehl= numhl=]])

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
    "json",
    "lua",
    "markdown",
    "ruby",
    "scss",
    "svelte",
    "templ",
    "terraform",
    "tsx",
    "typescript",
    "vimdoc",
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
    theme = 'material',
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
--  basic keybindings

-- use mousemodel for system pasting
-- instead of keybindings
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
end

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
  require('nvim-tree.api').tree.toggle({
    path = vim.fn.expand('%:p:h'),
    find_file = true,
    update_root = true
  })
end)

vim.keymap.set('n', 'gn', function()
  require('nvim-tree.api').tree.toggle({
    path = vim.fn.getcwd(),
    update_root = true
  })
end)

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

-- gs = go search
-- by default is used for "go sleep" which is entirely useless
-- whereas gt is useful for going to different tabs
vim.keymap.set('n', 'gz', fuzzy_search_operator, { expr = true })

-- codeium

vim.keymap.set('i', '<S-Cr>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
vim.keymap.set('i', '<M-]>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
vim.keymap.set('i', '<M-[>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
vim.keymap.set('i', '<M-BSlash>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })

-- avante

--require('avante_lib').load()
--require('avante').setup(
--{
--  provider = "claude",
--  claude = {
--    endpoint = "https://api.anthropic.com",
--    model = "claude-3-5-sonnet-20240620",
--    temperature = 0,
--    max_tokens = 4096,
--  },
--  behaviour = {
--    auto_suggestions = true, -- Experimental stage
--    auto_set_highlight_group = true,
--    auto_set_keymaps = true,
--    auto_apply_diff_after_generation = false,
--    support_paste_from_clipboard = false,
--  },
--  mappings = {
--    diff = {
--      ours = "co",
--      theirs = "ct",
--      all_theirs = "ca",
--      both = "cb",
--      cursor = "cc",
--      next = "]x",
--      prev = "[x",
--    },
--    suggestion = {
--      accept = "<M-l>",
--      next = "<M-]>",
--      prev = "<M-[>",
--      dismiss = "<C-]>",
--    },
--    jump = {
--      next = "]]",
--      prev = "[[",
--    },
--    submit = {
--      normal = "<CR>",
--      insert = "<C-s>",
--    },
--  },
--  hints = { enabled = false },
--  windows = {
--    ---@type "right" | "left" | "top" | "bottom"
--    position = "right", -- the position of the sidebar
--    wrap = true, -- similar to vim.o.wrap
--    width = 30, -- default % based on available width
--  },
--  highlights = {
--    diff = {
--      current = "DiffChange",
--      incoming = "DiffAdd",
--    },
--  },
--  diff = {
--    autojump = true,
--    list_opener = "copen",
--  },
--})
