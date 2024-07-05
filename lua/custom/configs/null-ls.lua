local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Setting up autoformat on save with null-ls
local opts = {
  sources = {
    -- Allow clangd to look at .clang-format
    null_ls.builtins.formatting.clang_format.with({
      extra_args = { "--style", "file" }
    }),
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function ()
          vim.lsp.buf.format({bufnr = bufnr})
        end,
      })
    end
  end
}

return opts

