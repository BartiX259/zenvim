local lazy_comb = function(comb)
  return function()
    vim.o.lazyredraw = true
    vim.cmd("normal! " .. vim.api.nvim_replace_termcodes(comb, true, false, true))
    vim.o.lazyredraw = false
  end
end

-- Highlight search
vim.keymap.set("n", "n", function()
  pcall(function()
    vim.cmd("normal! n")
  end)
  vim.opt.hlsearch = true
end, { desc = "Next search result" })

vim.keymap.set("n", "N", function()
  pcall(function()
    vim.cmd("normal! N")
  end)
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

-- Git
vim.keymap.set("n", "<leader>hh", function()
  vim.cmd("Gitsigns preview_hunk_inline")
end, { desc = "Preview git hunk" })
vim.keymap.set("n", "<leader>hr", function()
  vim.cmd("Gitsigns reset_hunk")
end, { desc = "Reset git hunk" })
vim.keymap.set("n", "<leader>hn", function()
  vim.cmd("Gitsigns next_hunk")
end, { desc = "Next git hunk" })
vim.keymap.set("n", "<leader>hp", function()
  vim.cmd("Gitsigns prev_hunk")
end, { desc = "Previous git hunk" })

-- Buffers
vim.keymap.set("n", "<TAB>", function()
  vim.cmd("BufferNext")
end, { desc = "Next Buffer" })

vim.keymap.set("n", "<S-TAB>", function()
  vim.cmd("BufferPrevious")
end, { desc = "Prev Buffer" })

vim.keymap.set("n", "<leader>x", function()
  vim.cmd("BufferClose")
end, { desc = "Close Buffer" })

-- File finding
local function get_cwd_if_dir()
  local first_arg = vim.fn.argv(0)
  if first_arg and first_arg ~= "" and vim.fn.isdirectory(first_arg) == 1 then
    return first_arg
  end
  return nil
end
local function close_pickers()
  local ok, pickers = pcall(Snacks.picker.get, {})
  if ok and pickers then
    for _, picker in ipairs(pickers) do
      picker:close()
    end
  end
end

vim.keymap.set("n", "<leader>e", function()
  close_pickers()
  Snacks.explorer({ cwd = get_cwd_if_dir() })
end, { desc = "File Explorer" })
vim.keymap.set("n", "<leader>s", function()
  close_pickers()
  Snacks.picker.files({ cwd = get_cwd_if_dir() })
end, { desc = "Search Files" })
vim.keymap.set("n", "<leader>r", function()
  close_pickers()
  Snacks.picker.recent()
end, { desc = "Recent Files" })
vim.keymap.set("n", "<leader>g", function()
  close_pickers()
  Snacks.picker.grep({ cwd = get_cwd_if_dir() })
end, { desc = "Find Text" })
vim.keymap.set("n", "<leader>*", function()
  close_pickers()
  Snacks.picker.grep_word({ cwd = get_cwd_if_dir() })
end, { desc = "Grep Word Under Cursor" })
vim.keymap.set("n", "<leader>n", function()
  close_pickers()
  vim.cmd("enew")
end, { desc = "New File" })

--- Insert mode
vim.g.better_escape_shortcut = { "jk", "kj" }
vim.keymap.set("i", "<C-Backspace>", lazy_comb("db"), { desc = "Delete word backward" })
vim.keymap.set("i", "<C-Delete>", lazy_comb("de"), { desc = "Delete word forward" })
vim.keymap.set("i", "<C-v>", lazy_comb("[pl"), { desc = "Paste from clipboard" })

--- Ctrl+s to save
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "Save" })

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
end, { desc = "Source File" })
