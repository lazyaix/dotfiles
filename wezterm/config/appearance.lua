local backdrops = require('utils.backdrops')
local astrodark = require('colors.astrodark')
local colors = astrodark.scheme
local palette = astrodark.palette

return {
  max_fps = 120,
  front_end = 'WebGpu', ---@type 'WebGpu' | 'OpenGL' | 'Software'
  underline_thickness = '1.5pt',

  -- cursor
  animation_fps = 120,
  cursor_blink_ease_in = 'EaseOut',
  cursor_blink_ease_out = 'EaseOut',
  default_cursor_style = 'BlinkingBlock',
  cursor_blink_rate = 650,

  -- color scheme
  colors = colors,

  -- background
  background = backdrops:initial_options(),

  -- scrollbar
  enable_scroll_bar = true,

  -- tab bar (retro style for tmux-like look)
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = false,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  tab_max_width = 25,
  show_tab_index_in_tab_bar = true,
  switch_to_last_active_tab_when_closing_tab = true,

  -- command palette (AstroDark)
  command_palette_fg_color = palette.text,
  command_palette_bg_color = palette.base,
  command_palette_font_size = 12,
  command_palette_rows = 25,

  -- window
  window_padding = {
    left = 0,
    right = 0,
    top = 10,
    bottom = 7.5,
  },
  adjust_window_size_when_changing_font_size = false,
  window_close_confirmation = 'NeverPrompt',
  window_frame = {
    active_titlebar_bg = palette.base,
  },
  inactive_pane_hsb = {
    saturation = 1,
    brightness = 1,
  },

  visual_bell = {
    fade_in_function = 'EaseIn',
    fade_in_duration_ms = 250,
    fade_out_function = 'EaseOut',
    fade_out_duration_ms = 250,
    target = 'CursorColor',
  },
}
