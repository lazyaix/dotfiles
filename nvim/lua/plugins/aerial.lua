---@type LazySpec
return {
  "stevearc/aerial.nvim",
  opts = function(_, opts)
    if vim.fn.has "nvim-0.12" == 1 then opts.backends = { "lsp", "markdown", "man" } end
  end,
}
