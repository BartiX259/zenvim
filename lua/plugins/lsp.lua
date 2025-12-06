return {
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			-- list of servers for mason to install
			ensure_installed = {
				"lua_ls",
			},
		},
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
			"neovim/nvim-lspconfig",
		},
	},
	{
		{
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
				-- snippet plugin
				{
					"L3MON4D3/LuaSnip",
					dependencies = "rafamadriz/friendly-snippets",
				},
				-- autopairs
				{
					"windwp/nvim-autopairs",
					config = function(_, opts)
						require("nvim-autopairs").setup(opts)
						-- setup cmp for autopairs
						local cmp_autopairs = require("nvim-autopairs.completion.cmp")
						require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
					end,
				},
				-- sources
				{
					"saadparwaiz1/cmp_luasnip",
					"hrsh7th/cmp-nvim-lua",
					"hrsh7th/cmp-nvim-lsp",
					"hrsh7th/cmp-buffer",
					"hrsh7th/cmp-path",
				},
			},
			config = function()
				local cmp = require("cmp")

				require("luasnip.loaders.from_vscode").lazy_load()
				cmp.setup({
					snippet = {
						expand = function(args)
							require("luasnip").lsp_expand(args.body)
						end,
					},
					mapping = cmp.mapping.preset.insert({
						["<TAB>"] = cmp.mapping.confirm({ select = true }),
						["<CR>"] = cmp.mapping.confirm({ select = true }),
						--['<Esc>'] = cmp.mapping.abort(),
					}),
					sources = cmp.config.sources({
						{ name = "nvim_lsp" },
						{ name = "luasnip" },
						{ name = "buffer" },
						{ name = "nvim_lua" },
						{ name = "path" },
					}),
				})
			end,
		},
	},
}
