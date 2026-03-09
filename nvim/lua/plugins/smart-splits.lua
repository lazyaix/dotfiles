-- smart-splits.nvim: seamless navigation/resize across nvim splits ↔ tmux panes ↔ wezterm panes
-- tmux config: ~/.config/tmux/conf.d/navigation.conf
-- wezterm config: use smart-splits wezterm plugin (TODO)

---@type LazySpec
return {
  "mrjones2014/smart-splits.nvim",
  -- Load at startup to ensure @pane-is-vim is set early
  lazy = false,
  opts = {
    at_edge = "stop",
  },
  keys = {
    -- Ctrl+hjkl: navigation
    { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" },
    { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" },
    { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" },
    { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" },
    -- Alt+hjkl: resize
    { "<M-h>", function() require("smart-splits").resize_left() end, desc = "Resize split left" },
    { "<M-j>", function() require("smart-splits").resize_down() end, desc = "Resize split down" },
    { "<M-k>", function() require("smart-splits").resize_up() end, desc = "Resize split up" },
    { "<M-l>", function() require("smart-splits").resize_right() end, desc = "Resize split right" },
  },
}
