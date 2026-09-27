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
  vim.cmd("cclose")
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
vim.keymap.set("n", "<leader>q", function()
  close_pickers()
  vim.cmd("copen")
end, { desc = "Quick fix list" })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function(event)
    vim.keymap.set("n", "<Esc>", "<cmd>cclose<cr>", {
      buffer = event.buf,
      silent = true,
      desc = "Close Quickfix",
    })
    vim.keymap.set("n", "<leader>q", "<cmd>cclose<cr>", {
      buffer = event.buf,
      silent = true,
      desc = "Close Quickfix",
    })
  end,
})
vim.keymap.set("n", "<leader>n", function()
  close_pickers()
  vim.cmd("enew")
end, { desc = "New File" })

--- Navigation
local sev = vim.diagnostic.severity
local function diag_jump(count, severity)
  return function()
    local opts = { count = count, float = false }
    if severity then
      opts.severity = severity
    end
    vim.diagnostic.jump(opts)
  end
end
vim.keymap.set("n", "gh", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next git hunk" })
vim.keymap.set("n", "gph", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Prev git hunk" })
vim.keymap.set("n", "gH", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Prev git hunk" })

vim.keymap.set("n", "ge", diag_jump(1, sev.ERROR), { desc = "Next error" })
vim.keymap.set("n", "gpe", diag_jump(-1, sev.ERROR), { desc = "Prev error" })
vim.keymap.set("n", "gE", diag_jump(-1, sev.ERROR), { desc = "Prev error" })

vim.keymap.set("n", "gw", diag_jump(1, sev.WARN), { desc = "Next warning" })
vim.keymap.set("n", "gpw", diag_jump(-1, sev.WARN), { desc = "Prev warning" })
vim.keymap.set("n", "gW", diag_jump(-1, sev.WARN), { desc = "Prev warning" })

vim.keymap.set("n", "gl", diag_jump(1), { desc = "Next diagnostic" }) -- L for lint
vim.keymap.set("n", "gpl", diag_jump(-1), { desc = "Prev diagnostic" })
vim.keymap.set("n", "gL", diag_jump(-1), { desc = "Prev diagnostic" })

vim.keymap.set("n", "gq", "<cmd>cnext<cr>", { desc = "Next quickfix item" })
vim.keymap.set("n", "gpq", "<cmd>cprev<cr>", { desc = "Prev quickfix item" })
vim.keymap.set("n", "gQ", "<cmd>cprev<cr>", { desc = "Prev quickfix item" })

--- Lsp
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })
vim.keymap.set("n", "gi", function()
  close_pickers()
  Snacks.picker.lsp_implementations()
end, { desc = "Goto implementations" })

pcall(vim.keymap.del, "n", "gra")
pcall(vim.keymap.del, "n", "grr")
pcall(vim.keymap.del, "n", "gri")
pcall(vim.keymap.del, "n", "grt")
pcall(vim.keymap.del, "n", "grx")
vim.keymap.set("n", "gr", function()
  close_pickers()
  Snacks.picker.lsp_references()
end, { desc = "Goto references" })

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })

-- Git
vim.keymap.set("n", "<leader>hh", "<cmd>Gitsigns preview_hunk_inline<cr>", { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", { desc = "Reset hunk" })

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

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Escape" })

vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end, { desc = "Source File" })
