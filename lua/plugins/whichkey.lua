return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    win = {
      row = 100,
    },
    spec = {
      { "<leader>c", group = "Code/LSP", icon = " " },
      { "<leader>h", group = "Git Hunks" },
      { "<leader>s", icon = " " }, -- Find files
      { "<leader>e", icon = "󰉋 " }, -- Explorer
      { "<leader>r", icon = " " }, -- Recent files
      { "<leader>g", icon = " " }, -- Grep
      { "<leader>*", icon = " " }, -- Grep under cursor
      { "<leader>x", icon = "󰅖 " }, -- Close buffer
      { "<leader>d", icon = " " }, -- Delete (no yank)
      { "<leader>p", icon = "󰆒 ", desc = "Paste without copying" }, -- Paste (keep register)
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
