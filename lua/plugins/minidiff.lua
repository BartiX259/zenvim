return {
  "nvim-mini/mini.diff",
  event = "VeryLazy",
  opts = {
    view = {
      style = "sign",
      signs = {
        add = "▎",
        change = "▎",
        delete = "",
      },
    },
    mappings = {
      -- Disable default apply/reset so they don't hijack your gh / gH navigation:
      apply = "",
      reset = "",
      textobject = "gh", -- Keep "gh" textobject so <leader>hr can target the hunk
      goto_first = "",
      goto_prev = "",
      goto_next = "",
      goto_last = "",
    },
  },
}
