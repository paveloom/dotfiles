-- Partial implementation of LSP inlay hint
return {
  "lvimuser/lsp-inlayhints.nvim",
  lazy = true,
  config = function()
    local name = "lsp-inlayhints"
    local lsp_inlayhints = require(name)
    -- Setup the plugin
    lsp_inlayhints.setup()
    -- Setup autocommands
    local group = vim.api.nvim_create_augroup(name, { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
      group = group,
      callback = function(args)
        -- If the following fields are defined
        if args.data and args.data.client_id then
          -- Attach the plugin to the buffer
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require(name).on_attach(client, bufnr)
        end
      end,
    })
  end,
}
