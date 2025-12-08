-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- Create a dedicated group to manage our autocommands

-- Automatically toggle highlight search
local ns = vim.api.nvim_create_augroup("AutoSearchHighlight", { clear = true })
vim.api.nvim_create_autocmd("CmdlineLeave", {
  group = ns,
  callback = function()
    local cmd_type = vim.fn.getcmdtype()
    if cmd_type == "/" or cmd_type == "?" then
      vim.opt.hlsearch = true
    end
  end,
})
vim.api.nvim_create_autocmd("CursorMoved", {
  group = ns,
  callback = function()
    if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
      vim.opt.hlsearch = false
      pcall(function()
        require("noice").cmd("dismiss")
      end)
    end
  end,
})

-- Highlight when copying text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Format on save
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(args)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format({ async = false, id = args.data.client_id })
      end,
    })
  end,
})

-- Automatically make colorscheme transparent
vim.api.nvim_create_autocmd("Colorscheme", {
  group = vim.api.nvim_create_augroup("AutoTransparent", { clear = true }),
  callback = function()
    local dim = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "LineNr" }).fg)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none", fg = dim })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "SnacksWinSeparator", { fg = dim })
  end,
})

-- CHEZMOI AUTOCMDS

-- When opening a file managed by chezmoi, open the source file instead.
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("ChezmoiEditHook", { clear = true }),
  pattern = "*",
  callback = function(ev)
    local filepath = vim.fn.expand("%:p")

    -- Prevent infinite loop
    if filepath:find("/.local/share/chezmoi/") then
      return
    end
    local cmd = { "chezmoi", "source-path", filepath }
    local output = vim.fn.system(cmd)

    if vim.v.shell_error == 0 then
      local source_path = vim.trim(output)
      local original_ft = vim.bo[ev.buf].filetype
      local original_buf = ev.buf

      if source_path ~= filepath then
        vim.schedule(function()
          vim.cmd("edit " .. vim.fn.fnameescape(source_path))
          if original_ft ~= "" then
            vim.bo.filetype = original_ft
          end
          if vim.api.nvim_buf_is_valid(original_buf) then
            vim.api.nvim_buf_delete(original_buf, { force = true })
          end
          vim.notify("Redirected to chezmoi source file", vim.log.levels.INFO)
        end)
      end
    end
  end,
})

-- Automatically apply chezmoi config
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("ChezmoiConfigHook", { clear = true }),
  pattern = { "*/chezmoi/chezmoi.toml", "*/.local/share/chezmoi/*" },
  callback = function(ev)
    local args = { "chezmoi", "apply" }

    -- Optimization: If you are editing a specific source file (not the main config),
    -- only apply that specific file. This is faster.
    local file = ev.match
    if not file:match("chezmoi.toml") then
      local target_path = vim.trim(vim.fn.system({ "chezmoi", "target-path", file }))
      if vim.v.shell_error ~= 0 then
        return
      end
      vim.fn.system({ "chezmoi", "source-path", target_path })
      if vim.v.shell_error ~= 0 then
        return
      end
      table.insert(args, "--source-path")
      table.insert(args, file)
    end

    -- Run the command
    vim.fn.jobstart(args, {
      on_exit = function(_, code)
        if code == 0 then
          vim.notify("Chezmoi applied successfully!", vim.log.levels.INFO)
        else
          vim.notify("Chezmoi failed to apply. Check :messages", vim.log.levels.ERROR)
        end
      end,
    })
  end,
})
