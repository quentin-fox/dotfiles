-- vim:foldmethod=marker
--- {{{ options


vim.opt.hidden = false
vim.opt.mouse = "a"
vim.opt.mousemodel = "popup_setpos"
vim.opt.confirm = true
vim.opt.inccommand = "nosplit"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.textwidth = 0
vim.opt.wrap = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.pumheight = 5
vim.opt.scrolloff = 10

vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldenable = false
vim.opt.foldlevel = 0

vim.opt.undofile = true

vim.opt.list = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.wrapmargin = 0
vim.opt.autoindent = true
vim.opt.termguicolors = true

vim.g.do_filetype_lua = 1

--- }}}
--- {{{ plugins

vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/rebelot/kanagawa.nvim" },
  { src = "https://github.com/f-person/auto-dark-mode.nvim" },
  { src = "https://github.com/tpope/vim-surround" },
  { src = "https://github.com/tpope/vim-commentary" },
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/tpope/vim-rhubarb" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/norcalli/nvim-colorizer.lua" },
  { src = "https://github.com/Saghen/blink.cmp" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/Exafunction/windsurf.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" }
})

--- }}}
--- {{{ theming

-- diagnostic

local all_levels = {
  vim.diagnostic.severity.ERROR,
  vim.diagnostic.severity.WARN,
  vim.diagnostic.severity.HINT,
  vim.diagnostic.severity.INFO,
}

vim.diagnostic.config({
  severity_sort = true,
  signs = {
    severity = all_levels,
  },
  underline = {
    severity = all_levels,
  },
  virtual_text = {
    severity = all_levels,
  },
  virtual_lines = false,
  signs = {
    severity = all_levels,
  },
  float = {
    severity = all_levels,
  },
})

--
--  colorscheme

local diag_colors = {
  error = "#be5046",
  warn = "#e5c07b",
  info = "#abb2bf",
  hint = "#abc2af",
}

local palette = {
  -- whites, lightest to darkest
  white0 = "#fdfdfd",
  white1 = "#eeeeee",
  white2 = "#d4d4d4",
  white3 = "#a5a5a5",
  white4 = "#878787",

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
  blue_dark = "#3782b2",
  blue_darkest = "#254c6e",

  red = "#cc4b4b",
  red_light = "#d66c63",
  red_dark = "#91342c",
  red_darkest = "#661912",

  green = "#96c475",
  green_light = "#a7c98f",
  green_dark = "#52703d",
  green_darkest = "#2f4520",
  green_bright = "#3aac2c",

  yellow = "#e5c07b",
  yellow_light = "#e8c980",
  yellow_dark = "#d4b219",
  yellow_bright = "#c7aa00",

  aqua = "#7aa89f",
  aqua_light = "#93cfc7",
  aqua_dark = "#5d8c86",

  mint = "#06d29e",

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
      bg        = palette.black4,
      fg_border = palette.white3,
      bg_border = palette.black4,
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
    added   = palette.green,
    removed = palette.red,
    changed = palette.blue,
  },
}

local theme_light = {
  ui = {
    fg         = palette.black2,
    fg_dim     = palette.black3,
    fg_reverse = palette.white4,

    bg_dim     = palette.white3,
    bg_gutter  = palette.white0,

    bg_m3      = palette.white0,
    bg_m2      = palette.white3,
    bg_m1      = palette.white2,
    bg         = palette.white0,
    bg_p1      = palette.white1,
    bg_p2      = palette.white2,

    special    = palette.black2,
    whitespace = palette.white3,
    nontext    = palette.white3,

    bg_visual  = palette.white2,
    bg_search  = palette.white3,

    pmenu      = {
      fg       = palette.white2,
      fg_sel   = palette.black1,
      bg       = palette.black4,
      bg_sel   = palette.white0,
      bg_thumb = palette.black4,
      bg_sbar  = palette.black4,
    },

    float      = {
      fg        = palette.black4,
      bg        = palette.white1,
      fg_border = palette.black4,
      bg_border = palette.white1,
    },
  },

  syn = {
    string     = palette.green_bright,
    variable   = palette.blue_dark,
    number     = palette.aqua_dark,
    constant   = palette.blue_dark,
    identifier = palette.blue_dark,
    parameter  = palette.blue_dark,
    fun        = palette.red,
    statement  = palette.yellow_bright,
    keyword    = palette.yellow_bright,
    operator   = palette.black3,
    preproc    = palette.yellow_bright,
    type       = palette.yellow_bright,
    regex      = palette.violet,
    deprecated = palette.black5,
    punct      = palette.gray1,
    comment    = palette.white3,
    special1   = palette.red,
    special2   = palette.red,
    special3   = palette.violet_dark,
  },
  diag = {
    error   = palette.red,
    ok      = palette.green,
    warning = palette.yellow,
    info    = palette.white0,
    hint    = palette.blue_light,
  },
  diff = {
    add    = palette.green_light,
    delete = palette.red_light,
    change = palette.blue_light,
    text   = palette.violet_light,
  },
  vcs = {
    added   = palette.green,
    removed = palette.red,
    changed = palette.blue,
  },
}

require("kanagawa").setup({
  compile = false,             -- enable compiling the colorscheme
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
      lotus = theme_light,
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

      NormalFloat = { bg = theme.ui.float.bg },
      FloatBorder = { bg = theme.ui.float.bg },
      FloatTitle = { bg = theme.ui.float.bg },

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
  theme = "dragon",
  background = {
    dark = "dragon",
    light = "lotus"
  },
})

vim.cmd("colorscheme kanagawa")

require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = "material",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "filename" },
    lualine_c = { 
      { 
        "diagnostics",

        sections = { "error", "warn", "info", "hint" },

        diagnostics_color = {
          error = "DiagnosticStatusError", -- Changes diagnostics" error color.
          warn  = "DiagnosticStatusWarn",  -- Changes diagnostics" warn color.
          info  = "DiagnosticStatusInfo",  -- Changes diagnostics" info color.
          hint  = "DiagnosticStatusHint",  -- Changes diagnostics" hint color.
        },
        symbols = {
          error = "● ",
          warn = "● ",
          info = "● ",
          hint = "● ",
        },
        colored = true,           -- Displays diagnostics status in color if set to true.
        update_in_insert = false, -- Update diagnostics in insert mode.
        always_visible = false,   -- Show diagnostics even if there are none.
      },
    },
    lualine_x = {},
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { "filename" },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})

require("auto-dark-mode").setup({
    set_dark_mode = function()
      vim.opt.background = "dark"
      require("lualine").setup({ options = { theme = "material" }})
    end,
    set_light_mode = function()
      vim.opt.background = "light"
      require("lualine").setup({ options = { theme = "onelight" }})
    end,
    update_interval = 3000,
    fallback = "dark"
})


--- }}}
--- {{{ treesitter

require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "bash",
    "bash",
    "css",
    "fish",
    "gitignore",
    "git_config",
    "gleam",
    "go",
    "gomod",
    "haskell",
    "hcl",
    "html",
    "ini",
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
    "toml",
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
      init_selection = "g<CR>",
      scope_incremental = "<CR>",
      node_incremental = "<TAB>",
      node_decremental = "<S-TAB>",
    },
  },
}

--- }}}
--- {{{ plugin setup

require("colorizer").setup()

require("nvim-autopairs").setup {
  check_ts = true,
}

require("fzf-lua").setup({
  { "default" }
})

require("conform").setup({
    notify_on_error = true,
    formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        html = { "prettier" },
    },
})

require("oil").setup({
  view_options = {
    show_hidden = true
  }
})

--- }}}
--- {{{ core keybinds

vim.keymap.set("n", "U", "<C-r>")

-- align text after jumping

vim.keymap.set("n", "g;", "g;zz")
vim.keymap.set("n", "g,", "g,zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- gp to select what was last pasted

vim.keymap.set("n", "gp", "`[v`]")

-- simpler window navigation

-- local win_keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>" }

-- for _, key in ipairs(win_keys) do
  -- vim.keymap.set("n", key, "<C-w>" .. key)
-- end

-- linewise navigation on wrapped lines

vim.keymap.set("n", "j", function()
  return vim.v.count == 0 and "gj" or "j"
end, { expr = true })
vim.keymap.set("n", "k", function()
  return vim.v.count == 0 and "gk" or "k"
end, { expr = true })

-- replace current word in line

vim.keymap.set("n", "X", ":s/<C-r><C-w>//g<Left><Left>")

-- clear highlight

vim.keymap.set("n", "-", "<cmd>nohlsearch<Cr>", { silent = true })

vim.keymap.set('n', 'gK', function()
  local config = vim.diagnostic.config()
  local virtual_text = { severity = all_levels }
  local virtual_lines = false

  if not config.virtual_lines then
    virtual_text = false
    virtual_lines = { severity = all_levels }
  end

  vim.diagnostic.config({ virtual_lines = virtual_lines, virtual_text = virtual_text })
end)

--- }}}
--- {{{ plugin keybinds

vim.keymap.set("n", "<leader>pr", function() require("conform").format({ async = true, lsp_fallback = true }) end)

vim.keymap.set("n", "~", "<cmd>Git<Cr>")

vim.keymap.set("n", "gn", "<cmd>edit .<Cr>")
vim.keymap.set("n", "gm", "<cmd>edit %:p:h<Cr>")

local fzf = require("fzf-lua")

vim.keymap.set("n", "<C-k>", fzf.builtin)
vim.keymap.set("n", "<C-p>", fzf.files)
vim.keymap.set("n", "<C-l>", fzf.live_grep)
vim.keymap.set("n", "<C-g>", fzf.grep_project)

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

    require('fzf-lua').live_grep({
      query = lines[1]
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

--- }}}
--- {{{ lsp

vim.lsp.enable("ts_ls")
vim.lsp.enable("eslint")
vim.lsp.enable("prettier")
vim.lsp.enable("jsonls")
vim.lsp.enable("yamlls")
vim.lsp.enable("terraformls")

--- }}}
--- {{{ codeium

require("codeium").setup({
  enable_cmp_source = false,
  virtual_text = {
    enabled = true,
    map_keys = true,
    key_bindings = {
      accept = "<S-CR>",
      accept_word = false,
      accept_line = false,
      clear = false,
      prev = false,
      next = false,
    }
  }
})

--- }}}
--- {{{ blink

require("blink-cmp").setup({
  fuzzy = { implementation = "lua" },
  sources = {
    default = { "lsp", "path" },
  }
})

--- }}}
