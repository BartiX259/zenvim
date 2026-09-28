vim.api.nvim_create_user_command("DiffClipboard", function()
  local filetype = vim.bo.filetype
  vim.cmd("rightbelow vnew")
  local scratch_buf = vim.api.nvim_get_current_buf()

  vim.bo[scratch_buf].buftype = "nofile"
  vim.bo[scratch_buf].bufhidden = "wipe"
  vim.bo[scratch_buf].swapfile = false
  vim.bo[scratch_buf].filetype = filetype

  local clipboard_content = vim.fn.getreg("+")
  if clipboard_content == "" then
    clipboard_content = vim.fn.getreg("*")
  end

  local lines = vim.split(clipboard_content, "\n")
  vim.api.nvim_buf_set_lines(scratch_buf, 0, -1, false, lines)
  vim.bo[scratch_buf].modifiable = false

  vim.cmd("diffthis")

  vim.cmd("wincmd p")
  vim.cmd("diffthis")
end, {})

local langs = require("languages")
local mr = require("mason-registry")

vim.api.nvim_create_user_command("LangInstall", function(opts)
  local name = opts.args
  local cfg = langs.get(name)
  if not cfg then
    vim.notify("Unknown toolchain: " .. name, vim.log.levels.ERROR, { title = "LangInstall" })
    return
  end

  local label = langs.label(cfg)
  local id = "toolchain_" .. name

  vim.notify("Installing " .. label .. "...", vim.log.levels.INFO, { id = id, title = "LangInstall", timeout = false })

  if cfg.ts then vim.cmd.TSInstall(cfg.ts) end
  if cfg.lsp and not mr.is_installed(cfg.lsp) then
    local pkg = mr.get_package(cfg.lsp)
    pkg:once("install:success", vim.schedule_wrap(function()
      vim.notify(label .. " ready", vim.log.levels.INFO, { id = id, title = "LangInstall", icon = "", timeout = 2500 })
      local lsp_name = vim.tbl_get(pkg.spec, "neovim", "lspconfig") or cfg.lsp
      vim.lsp.enable(lsp_name)
    end))
    pkg:once("install:failed", vim.schedule_wrap(function()
      vim.notify("Failed to install " .. cfg.lsp, vim.log.levels.ERROR,
        { id = id, title = "LangInstall", icon = "✗", timeout = 4000 })
    end))
    pkg:install()
  else
    vim.notify(label .. " ready", vim.log.levels.INFO, { id = id, title = "LangInstall", icon = "", timeout = 2500 })
  end
end, {
  nargs = 1,
  complete = function()
    return vim.list_extend(vim.tbl_keys(langs.languages), vim.tbl_keys(langs.frameworks))
  end,
})

vim.api.nvim_create_user_command("LangUninstall", function(opts)
  local name = opts.args
  local cfg = langs.get(name)
  if not cfg then
    vim.notify("Unknown toolchain: " .. name, vim.log.levels.ERROR, { title = "LangUninstall" })
    return
  end

  local label = langs.label(cfg)

  if cfg.lsp and mr.is_installed(cfg.lsp) then
    local pkg = mr.get_package(cfg.lsp)
    local lsp_name = vim.tbl_get(pkg.spec, "neovim", "lspconfig") or cfg.lsp
    for _, c in ipairs(vim.lsp.get_clients({ name = lsp_name })) do c:stop() end
    pkg:uninstall()
  end
  if cfg.ts then vim.cmd("TSUninstall " .. cfg.ts) end

  vim.notify(label .. " uninstalled", vim.log.levels.INFO, { title = "LangUninstall", icon = "" })
end, {
  nargs = 1,
  complete = function()
    return vim.list_extend(vim.tbl_keys(langs.languages), vim.tbl_keys(langs.frameworks))
  end,
})
