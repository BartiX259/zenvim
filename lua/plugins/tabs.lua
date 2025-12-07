local icon_opts = {
  separator = { left = "", right = "" },
  separator_at_end = false,
  button = "",
}

return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  opts = {
    animation = false,
    icons = {
      alternate = icon_opts,
      current = icon_opts,
      visible = icon_opts,
      inactive = icon_opts,
    },
  },
  config = function(_, opts)
    require("barbar").setup(opts)

    -- Transparent tabs setup
    local function set_barbar_highlights()
      local comment_hl = vim.api.nvim_get_hl(0, { name = "Comment" })
      if not comment_hl or not comment_hl.fg then
        return
      end
      local dim = string.format("#%06x", comment_hl.fg)
      local barbar_suffixes = {
        "",
        "Sign",
        "SignRight",
        "Index",
        "Icon",
        "Mod",
        "Target",
        "Pin",
        "ADDED",
        "CHANGED",
        "DELETED",
        "ERROR",
        "WARN",
        "INFO",
        "HINT",
      }
      local states = {
        Current = { fg = nil },
        Visible = { fg = nil },
        Inactive = { fg = dim },
      }
      for state, style in pairs(states) do
        for _, suffix in ipairs(barbar_suffixes) do
          local group_name = "Buffer" .. state .. suffix
          local default_group_name = "BufferDefault" .. state .. suffix

          local hl_def = { bg = "none" }
          if style.fg then
            hl_def.fg = style.fg
          end

          vim.api.nvim_set_hl(0, group_name, hl_def)
          vim.api.nvim_set_hl(0, default_group_name, hl_def)
        end
      end
      local fills = {
        "TabLineFill",
        "BufferDefaultTabpageFill",
        "BufferDefaultTabpagesSep",
        "BufferDefaultOffset",
        "DevIconDefaultCurrent",
        "DevIconDefaultVisible",
        "DevIconDefaultInactive",
      }
      for _, group in ipairs(fills) do
        vim.api.nvim_set_hl(0, group, { bg = "none" })
      end
    end
    set_barbar_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = set_barbar_highlights,
    })
  end,
  version = "^1.0.0",
}
