local eslint = require("efmls-configs.linters.eslint")
local shellcheck = require("efmls-configs.linters.shellcheck")
local prettier = require("efmls-configs.formatters.prettier")
local shfmt = require("efmls-configs.formatters.shfmt")
local rustfmt = require("efmls-configs.formatters.rustfmt")
local lspconfig = require("lspconfig")

local local_shfmt = {
  formatCommand = string.format("%s -i 2 -ci -filename %s -", shfmt.formatCommand:match("^([^%s]+)%s"),
    vim.api.nvim_buf_get_name(0)),
  formatStdin = shfmt.formatStdin,
}

local languages = {
  typescript = { eslint, prettier },
  sh = { shellcheck, local_shfmt },
  rust = { rustfmt },
}

lspconfig.efm.setup {
  filetypes = vim.tbl_keys(languages),
  init_options = { documentFormatting = true },
  settings = {
    rootMarkers = { ".git/" },
    languages = languages,
  }
}

-- Format on save for efm
local lsp_fmt_group = vim.api.nvim_create_augroup('LspFormattingGroup', {})
vim.api.nvim_create_autocmd('BufWritePost', {
  group = lsp_fmt_group,
  callback = function()
    local efm = vim.lsp.get_active_clients({ name = 'efm' })

    if vim.tbl_isempty(efm) then
      return
    end

    vim.lsp.buf.format({ name = 'efm' })
  end,
})
