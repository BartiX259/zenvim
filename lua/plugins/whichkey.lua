return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    spec = {
      { "gp", group = "Previous..." },
      { "gx", group = "Open path under cursor with system handler." },
      { "<leader>c", group = "Code/LSP", icon = " " },
      { "<leader>d", icon = " " }, -- Diff
      { "<leader>v", icon = "󰕌 " }, -- Revert hunk
      { "<leader>n", icon = "󰈤 " }, -- New file
      { "<leader>q", icon = "󰣪 " }, -- Quickfix
      { "<leader>s", icon = " " }, -- Search
      { "<leader>e", icon = "󰉖 " }, -- Explorer
      { "<leader>r", icon = " " }, -- Recent files
      { "<leader>f", icon = " " }, -- Changed files
      { "<leader>g", icon = "󰱽 " }, -- Grep
      { "<leader>w", icon = "󰱽 " }, -- Grep under cursor
      { "<leader>x", icon = "󰅖 " }, -- Close buffer
      { "<leader><leader>", icon = " " }, -- Source file
    },
  },
}
