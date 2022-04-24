vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

local function with_split(cmd, fn)
  return function()
    vim.cmd(cmd)
    fn()
  end
end

local on_attach = function(_, bufnr)
  local maps = {
    { 'gdd',   vim.lsp.buf.definition },
    { 'gdv',   with_split('vs', vim.lsp.buf.definition) },
    { 'gdx',   with_split('sp', vim.lsp.buf.definition) },
    { 'gi',    vim.lsp.buf.implementation },
    { 'K',     vim.lsp.buf.hover },
    { '<C-k>', vim.lsp.buf.signature_help },
    { 'grr',   vim.lsp.buf.references },
    { 'grn',   vim.lsp.buf.rename },
    { 'ga',    vim.lsp.buf.code_action }
  }

  for _, map in ipairs(maps) do
    vim.keymap.set('n', map[1], map[2], { silent = true, buffer = bufnr })
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')
local servers = { 'gopls', 'golangci_lint_ls', 'tsserver', 'sumneko_lua', 'svelte' }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

local luadev = require('lua-dev').setup{
  lspconfig = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
}

lspconfig.sumneko_lua.setup(luadev)

local luasnip = require('luasnip')
local cmp = require('cmp')

cmp.setup{
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
