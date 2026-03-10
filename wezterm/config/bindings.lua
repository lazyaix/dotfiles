local wezterm = require('wezterm')
local platform = require('utils.platform')
local backdrops = require('utils.backdrops')
local act = wezterm.action

local mod = {}

if platform.is_mac then
  mod.SUPER = 'SUPER'
  mod.SUPER_REV = 'SUPER|CTRL'
elseif platform.is_win or platform.is_linux then
  mod.SUPER = 'ALT' -- to not conflict with Windows key shortcuts
  mod.SUPER_REV = 'ALT|CTRL'
end

-- ============================================================
-- smart-splits.nvim integration
-- Seamless navigation between WezTerm panes and Neovim splits
-- ============================================================

local direction_keys = {
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}

---Check if the active pane is running Neovim
---@param pane any WezTerm pane object
---@return boolean
local function is_nvim(pane)
  return pane:get_user_vars().IS_NVIM == 'true'
end

---Create a smart-split navigation or resize binding
---@param resize_or_move 'resize' | 'move'
---@param key string
---@return table
local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == 'resize' and 'ALT' or 'CTRL',
    action = wezterm.action_callback(function(win, pane)
      if is_nvim(pane) then
        -- Pass keys through to Neovim
        win:perform_action({
          SendKey = {
            key = key,
            mods = resize_or_move == 'resize' and 'ALT' or 'CTRL',
          },
        }, pane)
      elseif resize_or_move == 'resize' then
        win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
      else
        win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
      end
    end),
  }
end

-- stylua: ignore
local keys = {
  -- smart-splits: move between panes/splits (Ctrl+hjkl)
  split_nav('move', 'h'),
  split_nav('move', 'j'),
  split_nav('move', 'k'),
  split_nav('move', 'l'),

  -- smart-splits: resize panes/splits (Alt+hjkl)
  split_nav('resize', 'h'),
  split_nav('resize', 'j'),
  split_nav('resize', 'k'),
  split_nav('resize', 'l'),

  -- misc/useful --
  { key = 'F1',  mods = 'NONE', action = 'ActivateCopyMode' },
  { key = 'F2',  mods = 'NONE', action = act.ActivateCommandPalette },
  { key = 'F3',  mods = 'NONE', action = act.ShowLauncher },
  { key = 'F4',  mods = 'NONE', action = act.ShowLauncherArgs({ flags = 'FUZZY|TABS' }) },
  { key = 'F5',  mods = 'NONE', action = act.ShowLauncherArgs({ flags = 'FUZZY|WORKSPACES' }) },
  { key = 'F11', mods = 'NONE', action = act.ToggleFullScreen },
  { key = 'F12', mods = 'NONE', action = act.ShowDebugOverlay },
  { key = 'f',   mods = mod.SUPER, action = act.Search({ CaseInSensitiveString = '' }) },
  {
    key = 'u',
    mods = mod.SUPER_REV,
    action = wezterm.action.QuickSelectArgs({
      label = 'open url',
      patterns = {
        '\\((https?://\\S+)\\)',
        '\\[(https?://\\S+)\\]',
        '\\{(https?://\\S+)\\}',
        '<(https?://\\S+)>',
        '\\bhttps?://\\S+[)/a-zA-Z0-9-]+'
      },
      action = wezterm.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        wezterm.log_info('opening: ' .. url)
        wezterm.open_with(url)
      end),
    }),
  },

  -- cursor movement --
  { key = 'LeftArrow',  mods = mod.SUPER,     action = act.SendString '\u{1b}OH' },
  { key = 'RightArrow', mods = mod.SUPER,     action = act.SendString '\u{1b}OF' },
  { key = 'Backspace',  mods = mod.SUPER,     action = act.SendString '\u{15}' },

  -- copy/paste --
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo('Clipboard') },
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom('Clipboard') },
  { key = 'c', mods = mod.SUPER,    action = act.CopyTo('Clipboard') },
  { key = 'v', mods = mod.SUPER,    action = act.PasteFrom('Clipboard') },

  -- tabs: spawn+close --
  { key = 't', mods = 'CTRL|SHIFT',  action = act.SpawnTab('DefaultDomain') },
  { key = 'w', mods = mod.SUPER_REV, action = act.CloseCurrentTab({ confirm = false }) },

  -- tabs: navigation --
  { key = '[', mods = mod.SUPER,     action = act.ActivateTabRelative(-1) },
  { key = ']', mods = mod.SUPER,     action = act.ActivateTabRelative(1) },
  { key = '[', mods = mod.SUPER_REV, action = act.MoveTabRelative(-1) },
  { key = ']', mods = mod.SUPER_REV, action = act.MoveTabRelative(1) },

  -- tabs: switch by number --
  { key = '1', mods = mod.SUPER, action = act.ActivateTab(0) },
  { key = '2', mods = mod.SUPER, action = act.ActivateTab(1) },
  { key = '3', mods = mod.SUPER, action = act.ActivateTab(2) },
  { key = '4', mods = mod.SUPER, action = act.ActivateTab(3) },
  { key = '5', mods = mod.SUPER, action = act.ActivateTab(4) },
  { key = '6', mods = mod.SUPER, action = act.ActivateTab(5) },
  { key = '7', mods = mod.SUPER, action = act.ActivateTab(6) },
  { key = '8', mods = mod.SUPER, action = act.ActivateTab(7) },

  -- tab: title --
  { key = '0', mods = mod.SUPER,     action = act.EmitEvent('tabs.manual-update-tab-title') },
  { key = '0', mods = mod.SUPER_REV, action = act.EmitEvent('tabs.reset-tab-title') },

  -- tab: hide tab-bar --
  { key = '9', mods = mod.SUPER, action = act.EmitEvent('tabs.toggle-tab-bar') },

  -- window: spawn --
  { key = 'n', mods = mod.SUPER, action = act.SpawnWindow },

  -- window: zoom --
  {
    key = '-',
    mods = mod.SUPER,
    action = wezterm.action_callback(function(window, _pane)
      local dimensions = window:get_dimensions()
      if dimensions.is_full_screen then
        return
      end
      window:set_inner_size(dimensions.pixel_width - 50, dimensions.pixel_height - 50)
    end),
  },
  {
    key = '=',
    mods = mod.SUPER,
    action = wezterm.action_callback(function(window, _pane)
      local dimensions = window:get_dimensions()
      if dimensions.is_full_screen then
        return
      end
      window:set_inner_size(dimensions.pixel_width + 50, dimensions.pixel_height + 50)
    end),
  },
  {
    key = 'Enter',
    mods = mod.SUPER_REV,
    action = wezterm.action_callback(function(window, _pane)
      window:maximize()
    end),
  },

  -- background controls --
  {
    key = [[/]],
    mods = mod.SUPER,
    action = wezterm.action_callback(function(window, _pane)
      backdrops:random(window)
    end),
  },
  {
    key = [[,]],
    mods = mod.SUPER,
    action = wezterm.action_callback(function(window, _pane)
      backdrops:cycle_back(window)
    end),
  },
  {
    key = [[.]],
    mods = mod.SUPER,
    action = wezterm.action_callback(function(window, _pane)
      backdrops:cycle_forward(window)
    end),
  },
  {
    key = [[/]],
    mods = mod.SUPER_REV,
    action = act.InputSelector({
      title = 'InputSelector: Select Background',
      choices = backdrops:choices(),
      fuzzy = true,
      fuzzy_description = 'Select Background: ',
      action = wezterm.action_callback(function(window, _pane, idx)
        if not idx then
          return
        end
        ---@diagnostic disable-next-line: param-type-mismatch
        backdrops:set_img(window, tonumber(idx))
      end),
    }),
  },
  {
    key = 'b',
    mods = mod.SUPER,
    action = wezterm.action_callback(function(window, _pane)
      backdrops:toggle_focus(window)
    end),
  },

  -- panes: split --
  {
    key = [[\]],
    mods = mod.SUPER,
    action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
  },
  {
    key = [[\]],
    mods = mod.SUPER_REV,
    action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
  },

  -- panes: zoom+close --
  { key = 'Enter', mods = mod.SUPER, action = act.TogglePaneZoomState },
  { key = 'w',     mods = mod.SUPER, action = act.CloseCurrentPane({ confirm = false }) },

  -- panes: swap --
  {
    key = 'p',
    mods = mod.SUPER_REV,
    action = act.PaneSelect({ alphabet = '1234567890', mode = 'SwapWithActiveKeepFocus' }),
  },

  -- panes: scroll --
  { key = 'u',        mods = mod.SUPER, action = act.ScrollByLine(-5) },
  { key = 'd',        mods = mod.SUPER, action = act.ScrollByLine(5) },
  { key = 'PageUp',   mods = 'NONE',    action = act.ScrollByPage(-0.75) },
  { key = 'PageDown', mods = 'NONE',    action = act.ScrollByPage(0.75) },

  -- key-tables: resize fonts --
  {
    key = 'f',
    mods = 'LEADER',
    action = act.ActivateKeyTable({
      name = 'resize_font',
      one_shot = false,
      timemout_milliseconds = 1000,
    }),
  },
  -- key-tables: resize panes --
  {
    key = 'p',
    mods = 'LEADER',
    action = act.ActivateKeyTable({
      name = 'resize_pane',
      one_shot = false,
      timemout_milliseconds = 1000,
    }),
  },
}

-- stylua: ignore
local key_tables = {
  resize_font = {
    { key = 'k',      action = act.IncreaseFontSize },
    { key = 'j',      action = act.DecreaseFontSize },
    { key = 'r',      action = act.ResetFontSize },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'q',      action = 'PopKeyTable' },
  },
  resize_pane = {
    { key = 'k',      action = act.AdjustPaneSize({ 'Up', 1 }) },
    { key = 'j',      action = act.AdjustPaneSize({ 'Down', 1 }) },
    { key = 'h',      action = act.AdjustPaneSize({ 'Left', 1 }) },
    { key = 'l',      action = act.AdjustPaneSize({ 'Right', 1 }) },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'q',      action = 'PopKeyTable' },
  },
}

local mouse_bindings = {
  -- Ctrl-click will open the link under the mouse cursor
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = act.OpenLinkAtMouseCursor,
  },
}

return {
  disable_default_key_bindings = true,
  leader = { key = 'Space', mods = mod.SUPER_REV },
  keys = keys,
  key_tables = key_tables,
  mouse_bindings = mouse_bindings,
}
