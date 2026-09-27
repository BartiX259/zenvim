return {
  {
    "kevinhwang91/nvim-bqf",
    -- enabled = false,
    ft = "qf",
    opts = {
      auto_enable = true,
      magic_window = true,
      preview = {
        win_height = 14,
        win_vheight = 14,
        winblend = 0,
        border = "rounded",
      },
      func_map = {
        open = "",
        openc = "<CR>"
      }
    },
  },
  {
    "stevearc/quicker.nvim",
    ft = "qf",
    opts = {
      highlight = {
        treesitter = true,
        lsp = true,
        load_buffers = true,
      },
    }
  },
}
