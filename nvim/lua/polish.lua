-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Mode icons: runs before heirline loads (BufEnter), so config is picked up
local config = require("astroui").config.status
if config then
  -- enable mode_text provider (must be {} not true, or build_provider crashes)
  config.components.mode.mode_text = {}

  local m = config.modes
  m["n"]    = { "󰆧 ", "normal" }   -- cube-outline
  m["no"]   = { "󰆧 ", "normal" }
  m["nov"]  = { "󰆧 ", "normal" }
  m["noV"]  = { "󰆧 ", "normal" }
  m["niI"]  = { "󰆧 ", "normal" }
  m["niR"]  = { "󰆧 ", "normal" }
  m["niV"]  = { "󰆧 ", "normal" }
  m["i"]    = { "󰏫 ", "insert" }   -- pencil
  m["ic"]   = { "󰏫 ", "insert" }
  m["ix"]   = { "󰏫 ", "insert" }
  m["v"]    = { "󰈈 ", "visual" }   -- eye
  m["vs"]   = { "󰈈 ", "visual" }
  m["V"]    = { "󰈈 ", "visual" }
  m["Vs"]   = { "󰈈 ", "visual" }
  m["\22"]  = { "󰈈 ", "visual" }
  m["\22s"] = { "󰈈 ", "visual" }
  m["R"]    = { "󰛔 ", "replace" }  -- find-replace
  m["Rc"]   = { "󰛔 ", "replace" }
  m["Rx"]   = { "󰛔 ", "replace" }
  m["Rv"]   = { "󰛔 ", "replace" }
  m["s"]    = { "󰈈 ", "visual" }
  m["S"]    = { "󰈈 ", "visual" }
  m["\19"]  = { "󰈈 ", "visual" }
  m["c"]    = { "󰘳 ", "command" }  -- command key
  m["cv"]   = { "󰘳 ", "command" }
  m["ce"]   = { "󰘳 ", "command" }
  m["t"]    = { "󰆍 ", "terminal" } -- console
  m["nt"]   = { "󰆍 ", "terminal" }
  m["r"]    = { "󰏤 ", "inactive" } -- pause
  m["rm"]   = { "󰏤 ", "inactive" }
  m["r?"]   = { "󰏤 ", "inactive" }
  m["!"]    = { "󰏤 ", "inactive" }
  m["null"] = { "󰏤 ", "inactive" }
end
