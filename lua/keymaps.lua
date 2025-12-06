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
end)
vim.keymap.set("n", "N", function()
	vim.cmd("normal! N")
	vim.opt.hlsearch = true
end)

--- Lsp
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>cn", vim.diagnostic.goto_next, {})
vim.keymap.set("n", "<leader>cp", vim.diagnostic.goto_prev, {})
vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

-- Buffers
vim.keymap.set("n", "<TAB>", function()
	vim.cmd("BufferNext")
end, {})
vim.keymap.set("n", "<S-TAB>", function()
	vim.cmd("BufferPrevious")
end, {})
vim.keymap.set("n", "<leader>x", function()
	vim.cmd("BufferClose")
end, {})
vim.keymap.set("n", "<leader>1", function()
	vim.cmd("BufferGoto 1")
end)
vim.keymap.set("n", "<leader>2", function()
	vim.cmd("BufferGoto 2")
end)
vim.keymap.set("n", "<leader>3", function()
	vim.cmd("BufferGoto 3")
end)
vim.keymap.set("n", "<leader>4", function()
	vim.cmd("BufferGoto 4")
end)
vim.keymap.set("n", "<leader>5", function()
	vim.cmd("BufferGoto 5")
end)
vim.keymap.set("n", "<leader>6", function()
	vim.cmd("BufferGoto 6")
end)
vim.keymap.set("n", "<leader>7", function()
	vim.cmd("BufferGoto 7")
end)
vim.keymap.set("n", "<leader>8", function()
	vim.cmd("BufferGoto 8")
end)
vim.keymap.set("n", "<leader>9", function()
	vim.cmd("BufferGoto 9")
end)
vim.keymap.set("n", "<leader>0", function()
	vim.cmd("BufferLast")
end)

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
	Snacks.explorer({ cwd = get_cwd_if_dir() })
end)

vim.keymap.set("n", "<leader>s", function()
	Snacks.picker.files({ cwd = get_cwd_if_dir() })
end)

vim.keymap.set("n", "<leader>r", function()
	Snacks.picker.recent()
end)

vim.keymap.set("n", "<leader>g", function()
	Snacks.picker.grep({ cwd = get_cwd_if_dir() })
end)

--- Insert mode
vim.g.better_escape_shortcut = { "jk", "kj" }
vim.keymap.set("i", "<C-Backspace>", lazy_comb("db"))
vim.keymap.set("i", "<C-Delete>", lazy_comb("de"))
vim.keymap.set("i", "<C-v>", lazy_comb("[pl"))

--- Better indenting
vim.keymap.set("v", ">", lazy_comb(">gv"))
vim.keymap.set("v", "<", lazy_comb("<gv"))

--- Remaps from theprimeagen
vim.keymap.set("n", "<A-o>", "o<Esc>")
vim.keymap.set("n", "<A-O>", "O<Esc>")

vim.keymap.set("n", "J", lazy_comb("mzJ`z"))
vim.keymap.set("n", "<C-d>", lazy_comb("<C-d>zz"))
vim.keymap.set("n", "<C-u>", lazy_comb("<C-u>zz"))

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)
