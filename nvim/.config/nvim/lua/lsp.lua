vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

local function with_split(cmd, fn)
  return function()
    vim.cmd(cmd)
    fn()
  end
end

local on_attach = function(client, bufnr)
  local maps = {
    { 'gdd', vim.lsp.buf.definition },
    { 'gdv', with_split('vs', vim.lsp.buf.definition) },
    { 'gdx', with_split('sp', vim.lsp.buf.definition) },
    { 'gi', vim.lsp.buf.implementation },
    { 'K', vim.lsp.buf.hover },
    { '<C-s>', vim.lsp.buf.signature_help },
    { '<C-d>', vim.diagnostic.open_float },
    { 'grr', vim.lsp.buf.references },
    { 'grn', vim.lsp.buf.rename },
    { 'ga', vim.lsp.buf.code_action }
  }

  for _, map in ipairs(maps) do
    vim.keymap.set('n', map[1], map[2], { silent = true, buffer = bufnr })
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

local function formatting_keymap(client, bufnr)
  vim.keymap.set('n', '<leader>pr', function()
    local params = vim.lsp.util.make_formatting_params({})
    client.request('textDocument/formatting', params, nil, bufnr)
  end, { buffer = bufnr })
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

local servers = {
  { 'gopls', extra_on_attach = { format_on_save } },
  { 'golangci_lint_ls' },
  { 'tsserver' },
  { 'eslint', extra_on_attach = { formatting_keymap } },
  { 'svelte' },
}

for _, lsp in ipairs(servers) do
  local name = lsp[1]
  lspconfig[name].setup {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)

      if lsp.extra_on_attach == nil then
        return
      end

      for _, cb in ipairs(lsp.extra_on_attach) do
        cb(client, bufnr)
      end
    end,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

local luadev = require('lua-dev').setup {
  lspconfig = {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      format_on_save(client, bufnr)
    end,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
}

lspconfig.sumneko_lua.setup(luadev)

local luasnip = require('luasnip')
local cmp = require('cmp')

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
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
    { name = 'nvim_lsp' },
  },
}
