-- Inline image rendering via snacks.nvim
-- Requires: terminal with kitty graphics protocol (WezTerm), ImageMagick

---@type LazySpec
return {
  "folke/snacks.nvim",
  opts = {
    image = {
      enabled = true,
      doc = {
        -- inline images in markdown, html, etc.
        inline = true,
        float = true,
      },
    },
  },
}
