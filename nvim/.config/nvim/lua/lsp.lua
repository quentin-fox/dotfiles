local util = require('vim.lsp.util')

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

local function with_split(cmd, fn)
  return function()
    vim.cmd(cmd)
    fn()
  end
end

local function get_client_definition(client, bufnr)
  return function()
    client.request('textDocument/definition', util.make_position_params(), nil, bufnr)
  end
end

local on_attach = function(client, bufnr)
  local maps = {
    { '<C-s>', vim.lsp.buf.signature_help },
    { '<C-d>', vim.diagnostic.open_float },
    { 'ga', vim.lsp.buf.code_action }
  }

  for _, map in ipairs(maps) do
    vim.keymap.set('n', map[1], map[2], { silent = true, buffer = bufnr })
  end
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason').setup {}
require('mason-lspconfig').setup {
  automatic_installation = true
}

require('neodev').setup {}

local lspconfig = require('lspconfig')

local function formatting_keymap(client, bufnr)
  local function formatting()
    local params = vim.lsp.util.make_formatting_params({})
    client.request('textDocument/formatting', params, nil, bufnr)
  end
  vim.keymap.set('n', '<leader>pr', formatting, { buffer = bufnr })
end

local function format_on_save(client, bufnr)
  local group = vim.api.nvim_create_augroup(client.name .. 'FormatOnSave', { clear = true })
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = group,
    buffer = bufnr,
    callback = function()
      -- largely copied from vim.lsp.buf.formatting_sync
      -- but applied to one single lsp client
      -- has to be synchronous so that the changes are made to the buffer before saving to disk
      local formatting_params = vim.lsp.util.make_formatting_params({})
      local result, err = client.request_sync('textDocument/formatting', formatting_params, 500, bufnr)

      if result and result.result then
        vim.lsp.util.apply_text_edits(result.result, bufnr, client.offset_encoding)
      elseif err then
        vim.notify('vim.lsp.buf.formatting_sync: ' .. err, vim.log.levels.WARN)
      end
    end,
  })
end

local function with_definition(prefix)
  return function(client, bufnr)

    local function definition()
      client.request('textDocument/definition', util.make_position_params(), nil, bufnr)
    end

    local maps = {
      { prefix .. 'd', definition },
      { prefix .. 'v', with_split('vs', definition) },
      { prefix .. 'x', with_split('sp', definition) },
    }

    for _, map in ipairs(maps) do
      vim.keymap.set('n', map[1], map[2], { silent = true, buffer = bufnr })
    end
  end
end

local function with_references(prefix)
  return function(client, bufnr)
    local function references()
      local params = util.make_position_params()
      params.context = {
        includeDeclaration = true
      }

      client.request('textDocument/references', params, nil, bufnr)
    end

    vim.keymap.set('n', prefix .. 'r', references, { silent = true, buffer = bufnr })
  end
end

local function with_rename(map)
  return function(client, bufnr)
    vim.keymap.set('n', 'grn', vim.lsp.buf.rename, { silent = true, buffer = bufnr })
  end
end

local function with_hover(map)
  return function(client, bufnr)
    local function hover()
      local params = util.make_position_params()
      client.request('textDocument/hover', params, nil, bufnr)
    end

    vim.keymap.set('n', map, hover, { silent = true, buffer = bufnr })
  end
end

local function with_default()
  return {
    with_definition('gd'),
    with_references('gr'),
    with_rename('grn'),
    with_hover('K')
  }
end

local yamlls_settings = {
  yaml = {
    schemas = {
      ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
      ['Kubernetes'] = '*.k8s.yaml',
    },
    format = {
      singleQuote = true
    }
  }
}

local svelte_settings = {
  svelte = {
    plugin = {
      css = {
        globals = "src/styles/app.css"
      }
    }
  }
}

local servers = {
  -- add root_dir override so that we don't enable deno ls on non-deno projects
  { name = 'cssls' },
  { name = 'cssmodules_ls', extra_on_attach = { with_definition('gs'), with_references('gs'), with_hover('gsK') }},
  { name = 'denols', root_dir = lspconfig.util.root_pattern({ 'deno.json' }) },
  { name = 'gopls', extra_on_attach = vim.list_extend({ format_on_save }, with_default()) },
  { name = 'golangci_lint_ls', extra_on_attach = {} },
  { name = 'jsonls', extra_on_attach = { formatting_keymap } },
  { name = 'lua_ls', },
  { name = 'tsserver', single_file_support = false, root_dir = lspconfig.util.root_pattern({ 'package.json' }) },
  { name = 'eslint', extra_on_attach = { formatting_keymap }, filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte' } },
  { name = 'svelte', extra_on_attach = vim.list_extend({ formatting_keymap }, with_default()) },
  { name = 'solargraph' },
  { name = 'terraformls' },
  { name = 'yamlls', extra_on_attach = { format_on_save }, settings = yamlls_settings },
}

for _, lsp in ipairs(servers) do
  local settings = {
    on_attach = function(client, bufnr)
      local extra_on_attach = lsp.extra_on_attach or with_default()

      for _, cb in ipairs(extra_on_attach) do
        cb(client, bufnr)
      end

      on_attach(client, bufnr)
    end,
    flags = {
      debounce_text_changes = 150,
    },
  }

  settings['capabilities'] = capabilities

  -- allow passing in any other config for a given ls
  for key, value in pairs(lsp) do
    if key ~= 'name' and key ~= 'extra_on_attach' then
      settings[key] = value
    end
  end

  lspconfig[lsp.name].setup(settings)
end

local luasnip = require('luasnip')
local cmp = require('cmp')

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(nil),
    ['<C-x>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' }
  },
}
