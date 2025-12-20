return {
	"nvim-lualine/lualine.nvim",
	enabled = false,
	dependencies = {
		-- display macro recording
		{ "yavorski/lualine-macro-recording.nvim" },
	},
	config = function()
		local get_active_lsp = function()
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			if next(clients) == nil then
				return "no lsp"
			else
				for _, c in ipairs(clients) do
					if c.name ~= "" then
						return c.name
					end
				end
				return "no lsp"
			end
		end
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "nightfly",
				component_separators = "",
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					{ "mode", separator = { right = "" }, right_padding = 2 },
				},
				lualine_b = { "filename", "branch" },
				lualine_c = { "macro_recording", "%S" },
				lualine_x = {},
				lualine_y = { get_active_lsp },
				lualine_z = {
					{ "location", separator = { left = "" } },
				},
			},
			inactive_sections = {
				lualine_a = { "filename" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
			tabline = {},
			extensions = {},
		})
	end,
}
