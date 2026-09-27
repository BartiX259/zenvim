return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    -- layout = {
    --   -- Default is 20, which is why 6 columns were fitting on your screen.
    --   -- Bumping this to 36-40 forces Which-Key into exactly 3 to 4 columns:
    --   width = { min = 36 },
    --   spacing = 5, -- Pleasant spacing between columns
    -- },
    spec = {
      { "gp", group = "Previous..." },
      { "gx", group = "Open path under cursor with system handler." },
      { "<leader>c", group = "Code/LSP", icon = " " },
      { "<leader>d", icon = " " }, -- Diff
      { "<leader>v", icon = "󰕌 " }, -- Revert hunk
      { "<leader>n", icon = "󰈤 " }, -- New file
      { "<leader>q", icon = "󰣪 " }, -- Quickfix
      { "<leader>s", icon = " " }, -- Find files
      { "<leader>e", icon = "󰉖 " }, -- Explorer
      { "<leader>r", icon = " " }, -- Recent files
      { "<leader>g", icon = "󰱽 " }, -- Grep
      { "<leader>*", icon = "󰱽 " }, -- Grep under cursor
      { "<leader>x", icon = "󰅖 " }, -- Close buffer
      { "<leader><leader>", icon = " " }, -- Source file
    },
  },
}
