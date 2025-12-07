local lazy_comb = function(comb)
  return function()
    vim.o.lazyredraw = true
    vim.cmd("normal! " .. vim.api.nvim_replace_termcodes(comb, true, false, true))
    vim.o.lazyredraw = false
  end
end

-- Hightlight search
vim.keymap.set("n", "n", function()
  vim.cmd("normal! n")
  vim.opt.hlsearch = true
end, { desc = "Next search result" })

vim.keymap.set("n", "N", function()
  vim.cmd("normal! N")
  vim.opt.hlsearch = true
end, { desc = "Prev search result" })

--- Lsp
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set("n", "<leader>cn", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })

vim.keymap.set("n", "<leader>cp", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev diagnostic" })

vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true, desc = "Goto declaration" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Goto definition" })

-- Buffers
vim.keymap.set("n", "<TAB>", function()
  vim.cmd("BufferNext")
end, { desc = "Next buffer" })

vim.keymap.set("n", "<S-TAB>", function()
  vim.cmd("BufferPrevious")
end, { desc = "Prev buffer" })

vim.keymap.set("n", "<leader>x", function()
  vim.cmd("BufferClose")
end, { desc = "Close buffer" })

-- File finding
local function get_cwd_if_dir()
  local first_arg = vim.fn.argv(0)
  if first_arg and first_arg ~= "" and vim.fn.isdirectory(first_arg) == 1 then
    return first_arg
  end
  return nil
end

-- Keymaps
vim.keymap.set("n", "<leader>e", function()
  -- Dashboard bugfix
  if vim.bo.filetype == "snacks_dashboard" and #vim.api.nvim_list_bufs() <= 1 then
    vim.cmd("enew")
    vim.bo.bufhidden = "wipe"
    vim.bo.buftype = "nofile"
  end
  Snacks.explorer({ cwd = get_cwd_if_dir() })
end, { desc = "File Explorer" })

vim.keymap.set("n", "<leader>s", function()
  Snacks.picker.files({ cwd = get_cwd_if_dir() })
end, { desc = "Search files" })

vim.keymap.set("n", "<leader>r", function()
  Snacks.picker.recent()
end, { desc = "Recent files" })

vim.keymap.set("n", "<leader>g", function()
  Snacks.picker.grep({ cwd = get_cwd_if_dir() })
end, { desc = "Find text" })

--- Insert mode
vim.g.better_escape_shortcut = { "jk", "kj" }
vim.keymap.set("i", "<C-Backspace>", lazy_comb("db"), { desc = "Delete word backward" })
vim.keymap.set("i", "<C-Delete>", lazy_comb("de"), { desc = "Delete word forward" })
vim.keymap.set("i", "<C-v>", lazy_comb("[pl"), { desc = "Paste from clipboard" })

--- Better indenting
vim.keymap.set("v", ">", lazy_comb(">gv"), { desc = "Indent right" })
vim.keymap.set("v", "<", lazy_comb("<gv"), { desc = "Indent left" })

--- Remaps from theprimeagen
vim.keymap.set("n", "<A-o>", "o<Esc>", { desc = "Insert newline below" })
vim.keymap.set("n", "<A-O>", "O<Esc>", { desc = "Insert newline above" })

vim.keymap.set("n", "J", lazy_comb("mzJ`z"), { desc = "Join lines" })
vim.keymap.set("n", "<C-d>", lazy_comb("<C-d>zz"), { desc = "Scroll down" })
vim.keymap.set("n", "<C-u>", lazy_comb("<C-u>zz"), { desc = "Scroll up" })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without copying" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without copying" })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Escape" })

vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end, { desc = "Source file" })
