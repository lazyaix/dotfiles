-- AstroDark color scheme for WezTerm
-- Palette synced with tmux/conf.d/theme.conf and nvim/lua/plugins/astroui.lua

-- stylua: ignore
local palette = {
  -- Background hierarchy
  base    = '#1A1D23',
  surface = '#1E222A',
  overlay = '#23272F',
  border  = '#3A3E47',

  -- Text hierarchy
  muted   = '#696C76',
  text    = '#ADB0BB',

  -- Accent colors
  blue    = '#50A4E9',
  green   = '#75AD47',
  yellow  = '#D09214',
  red     = '#F8747E',
  purple  = '#CC83E3',
  cyan    = '#00B298',
  orange  = '#EB8332',
}

-- stylua: ignore
local colorscheme = {
  foreground = palette.text,
  background = palette.base,
  cursor_bg = palette.blue,
  cursor_border = palette.blue,
  cursor_fg = palette.base,
  selection_bg = palette.border,
  selection_fg = palette.text,

  ansi = {
    palette.base,     -- black
    palette.red,      -- red
    palette.green,    -- green
    palette.yellow,   -- yellow
    palette.blue,     -- blue
    palette.purple,   -- magenta
    palette.cyan,     -- cyan
    palette.text,     -- white
  },
  brights = {
    palette.border,   -- bright black
    '#FF8A93',        -- bright red
    '#8BC35D',        -- bright green
    '#E6A82A',        -- bright yellow
    '#6AB8FF',        -- bright blue
    '#DCA0F0',        -- bright magenta
    '#1CC8AE',        -- bright cyan
    '#CDD0DA',        -- bright white
  },

  tab_bar = {
    background = 'rgba(0, 0, 0, 0.4)',
    active_tab = {
      bg_color = palette.border,
      fg_color = palette.text,
    },
    inactive_tab = {
      bg_color = palette.surface,
      fg_color = palette.muted,
    },
    inactive_tab_hover = {
      bg_color = palette.overlay,
      fg_color = palette.text,
    },
    new_tab = {
      bg_color = palette.base,
      fg_color = palette.text,
    },
    new_tab_hover = {
      bg_color = palette.surface,
      fg_color = palette.text,
      italic = true,
    },
  },

  visual_bell = palette.red,
  scrollbar_thumb = palette.border,
  split = palette.muted,
  compose_cursor = palette.orange,

  indexed = {
    [16] = palette.orange,
    [17] = palette.cyan,
  },
}

return {
  scheme = colorscheme,
  palette = palette,
}
