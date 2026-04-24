-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

if vim.fn.has "nvim-0.12" == 1 then
  local codelens = vim.lsp and vim.lsp.codelens
  if codelens and codelens.enable and not codelens._dotfiles_refresh_compat then
    codelens.refresh = function(opts) codelens.enable(true, { bufnr = opts and opts.bufnr }) end
    codelens._dotfiles_refresh_compat = true
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    desc = "Add deprecated LSP client method shims for plugins",
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if not client then return end
      local client_methods = getmetatable(client)
      client.request = function(...)
        if select(1, ...) == client then
          return client_methods.request(...)
        end
        return client_methods.request(client, ...)
      end
      client.notify = function(...)
        if select(1, ...) == client then
          return client_methods.notify(...)
        end
        return client_methods.notify(client, ...)
      end
    end,
  })
end

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
