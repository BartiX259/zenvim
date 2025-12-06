return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			{ "<leader>c", group = "Code/LSP", icon = " " },
			{ "<leader>d", icon = "󰆴 " }, -- Delete (no yank)
			{ "<leader>e", icon = " " }, -- Explorer
			{ "<leader>g", icon = " " }, -- Grep
			{ "<leader>p", icon = "󰅇 " }, -- Paste (keep register)
			{ "<leader>r", icon = " " }, -- Recent files
			{ "<leader>s", icon = " " }, -- Find files
			{ "<leader>x", icon = "󰅖 " }, -- Close buffer
			{ "<leader><leader>", icon = " " }, -- Source file
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
