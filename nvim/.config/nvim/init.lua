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
  gray2 = "#625e5a",

  -- colors
  blue = "#7eafd9",
  blue_light = "#abc6de",
  blue_dark = "#3b6487",

  red = "#be5046",
  red_light = "#d66c63",
  red_dark = "#91342c",

  green = "#96c475",
  green_light = "#a7c98f",
  green_dark = "#52703d",

  yellow = "#e5c07b",
  yellow_light = "#e8c980",
  yellow_dark = "#e39d4d",

  aqua = "#7aa89f",
  aqua_light = "#93cfc7",
  aqua_dark = "#5d8c86",

  violet = "#957fb8",
  violet_light = "#b6a3d4",
  violet_dark = "#665182",

  -- one-off colors, no shades required
  mint = "#aedbb3",
  beige = "#ede8d0"
}

local theme = {
  ui = {
    fg         = palette.white1,
    fg_dim     = palette.white2,
    fg_reverse = palette.gray2,

    bg_dim     = palette.black3,
    bg_gutter  = palette.black3,

    bg_m3      = palette.black0,
    bg_m2      = palette.black1,
    bg_m1      = palette.black2,
    bg         = palette.black3,
    bg_p1      = palette.black4,
    bg_p2      = palette.black5,

    special    = palette.red_dark,
    whitespace = palette.black5,
    nontext    = palette.black5,

    bg_visual  = palette.yellow,
    bg_search  = palette.yellow,

    pmenu      = {
      fg       = palette.white2,
      fg_sel   = palette.white1,
      bg       = palette.black4,
      bg_sel   = palette.gray1,
      bg_thumb = palette.black4,
      bg_sbar  = palette.black4,
    },

    float      = {
      fg        = palette.white1,
      bg        = palette.black3,
      fg_border = palette.white1,
      bg_border = palette.black3,
    },
  },

  syn = {
    string     = palette.green,
    variable   = palette.blue_light,
    number     = palette.mint,
    constant   = palette.violet_light,
    identifier = palette.blue,
    parameter  = palette.blue,
    fun        = palette.red,
    statement  = palette.blue_dark,
    keyword    = palette.yellow_light,
    operator   = palette.white2,
    preproc    = palette.violet_light,
    type       = palette.blue_light,
    regex      = palette.violet,
    deprecated = palette.gray1,
    punct      = palette.white2,
    comment    = palette.white4,
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
    add    = palette.green_dark,
    delete = palette.red_dark,
    change = palette.yellow_dark,
    text   = palette.blue_dark,
  },
  vcs = {
    added   = palette.green_dark,
    removed = palette.red_dark,
    changed = palette.yellow_dark,
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
    palettee = {
      sumiInk0 = "#16161D",
      sumiInk1 = "#181820",
      sumiInk2 = "#1a1a22",
      sumiInk3 = "#1F1F28",
      sumiInk4 = "#2A2A37",
      sumiInk5 = "#363646",
      sumiInk6 = "#54546D", --fg

      -- Popup and Floats
      waveBlue1 = "#223249",
      waveBlue2 = "#2D4F67",

      -- Diff and Git
      winterGreen = "#2B3328",
      winterYellow = "#49443C",
      winterRed = "#43242B",
      winterBlue = "#252535",
      autumnGreen = "#76946A",
      autumnRed = "#C34043",
      autumnYellow = "#DCA561",

      -- Diag
      samuraiRed = "#E82424",
      roninYellow = "#FF9E3B",
      waveAqua1 = "#6A9589",
      dragonBlue = "#658594",

      -- Fg and Comments
      oldWhite = "#C8C093",
      fujiWhite = "#DCD7BA",
      fujiGray = "#727169",

      oniViolet = "#957FB8",
      oniViolet2 = "#b8b4d0",
      crystalBlue = "#7E9CD8",
      springViolet1 = "#938AA9",
      springViolet2 = "#9CABCA",
      springBlue = "#7FB4CA",
      lightBlue = "#A3D4D5", -- unused yet
      waveAqua2 = "#7AA89F", -- improve lightness: desaturated greenish Aqua

      -- waveAqua2  = "#68AD99",
      -- waveAqua4  = "#7AA880",
      -- waveAqua5  = "#6CAF95",
      -- waveAqua3  = "#68AD99",

      springGreen = "#98BB6C",
      boatYellow1 = "#938056",
      boatYellow2 = "#C0A36E",
      carpYellow = "#E6C384",

      sakuraPink = "#D27E99",
      waveRed = "#E46876",
      peachRed = "#FF5D62",
      surimiOrange = "#FFA066",
      katanaGray = "#717C7C",

      dragonBlack0 = "#121212",
      dragonBlack1 = "#161616",
      dragonBlack2 = "#202020",
      dragonBlack3 = "#262626",
      dragonBlack4 = "#323232",
      dragonBlack5 = "#393836",
      dragonBlack6 = "#625e5a",

      dragonWhite = "#e2e2e2",
      dragonGreen = "#96c475",
      dragonGreen2 = "#93a680",
      dragonPink = "#b294b3",
      dragonOrange = "#c79580",
      dragonOrange2 = "#ca9780",
      dragonGray = "#b3b3a8",
      dragonGray2 = "#aba89e",
      dragonGray3 = "#83908f",
      dragonBlue2 = "#8fb2c1",
      dragonViolet = "#be5046",
      dragonRed = "#be5046",
      dragonAqua = "#95b3b0",
      dragonAsh = "#7b867b",
      dragonTeal = "#be5046",
      dragonYellow = "#7eafd9",
      -- "#8a9aa3",

      lotusInk1 = "#545464",
      lotusInk2 = "#43436c",
      lotusGray = "#dcd7ba",
      lotusGray2 = "#716e61",
      lotusGray3 = "#8a8980",
      lotusWhite0 = "#d5cea3",
      lotusWhite1 = "#dcd5ac",
      lotusWhite2 = "#e5ddb0",
      lotusWhite3 = "#f2ecbc",
      lotusWhite4 = "#e7dba0",
      lotusWhite5 = "#e4d794",
      lotusViolet1 = "#a09cac",
      lotusViolet2 = "#766b90",
      lotusViolet3 = "#c9cbd1",
      lotusViolet4 = "#624c83",
      lotusBlue1 = "#c7d7e0",
      lotusBlue2 = "#b5cbd2",
      lotusBlue3 = "#9fb5c9",
      lotusBlue4 = "#4d699b",
      lotusBlue5 = "#5d57a3",
      lotusGreen = "#6f894e",
      lotusGreen2 = "#6e915f",
      lotusGreen3 = "#b7d0ae",
      lotusPink = "#b35b79",
      lotusOrange = "#cc6d00",
      lotusOrange2 = "#e98a00",
      lotusYellow ="#77713f",
      lotusYellow2 = "#836f4a",
      lotusYellow3 = "#de9800",
      lotusYellow4 = "#f9d791",
      lotusRed = "#c84053",
      lotusRed2 = "#d7474b",
      lotusRed3 = "#e82424",
      lotusRed4 = "#d9a594",
      lotusAqua = "#597b75",
      lotusAqua2 = "#5e857a",
      lotusTeal1 = "#4e8ca2",
      lotusTeal2 = "#6693bf",
      lotusTeal3 = "#5a7785",
      lotusCyan = "#d7e3d8",
    },
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
      NormalFloat = { bg = "none" },
      FloatBorder = { bg = "none" },
      FloatTitle = { bg = "none" },

      LineNr = { fg = theme.ui.fg_reverse, bg = "none" },
      CursorLineNr = { fg = theme.ui.fg, bg = "none", bold = true  },

      Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },  -- add `blend = vim.o.pumblend` to enable transparency
      PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuThumb = { bg = theme.ui.bg_p2 },

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

require('avante_lib').load()
require('avante').setup(
{
  provider = "claude",
  claude = {
    endpoint = "https://api.anthropic.com",
    model = "claude-3-5-sonnet-20240620",
    temperature = 0,
    max_tokens = 4096,
  },
  behaviour = {
    auto_suggestions = false, -- Experimental stage
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = false,
  },
  mappings = {
    diff = {
      ours = "co",
      theirs = "ct",
      all_theirs = "ca",
      both = "cb",
      cursor = "cc",
      next = "]x",
      prev = "[x",
    },
    suggestion = {
      accept = "<M-l>",
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
    jump = {
      next = "]]",
      prev = "[[",
    },
    submit = {
      normal = "<CR>",
      insert = "<C-s>",
    },
  },
  hints = { enabled = false },
  windows = {
    ---@type "right" | "left" | "top" | "bottom"
    position = "right", -- the position of the sidebar
    wrap = true, -- similar to vim.o.wrap
    width = 30, -- default % based on available width
  },
  highlights = {
    diff = {
      current = "DiffChange",
      incoming = "DiffAdd",
    },
  },
  diff = {
    autojump = true,
    list_opener = "copen",
  },
})
