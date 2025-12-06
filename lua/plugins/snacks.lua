return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		explorer = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = false },
		scroll = { enabled = false },
		picker = {
			win = {
				input = {
					keys = {
						-- Close the picker on Esc in both normal (n) and insert (i) mode
						["<Esc>"] = { "close", mode = { "n", "i" } },
					},
				},
			},
			sources = {
				explorer = {
					-- Close the explorer after opening a file
					jump = { close = true },
					layout = {
						backdrop = false,
						preview = "main",
					},
				},
			},
		},
	},
}
