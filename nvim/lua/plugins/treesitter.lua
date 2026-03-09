-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "vimdoc",
      "bash",
      "json",
      "jsonc",
      "yaml",
      "toml",
      "markdown",
      "markdown_inline",
      "regex",
      -- language packs handle c, cpp, python, rust, go
    },
  },
}
