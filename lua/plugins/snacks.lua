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
            preset = function()
              return vim.o.columns >= 120 and "default" or "vertical"
            end,
            preview = "file",
            layout = { height = 0.75, width = 0.5 },
            backdrop = false,
          },
          win = {
            list = {
              keys = {
                ["<leader>/"] = false,
              },
            },
          },
        },
      },
    },
    dashboard = {
      enabled = true,
      sections = {
        { section = "header", padding = 0 },
        { section = "keys",   gap = 1,    padding = 1 },
        {
          padding = { 1, 0 },
          align = "center",
          text = {
            {
              "Neovim v"
              .. vim.version().major
              .. "."
              .. vim.version().minor
              .. "."
              .. vim.version().patch,
              hl = "Comment",
            },
          },
        },
      },
      formats = {
        key = function(item)
          return { item.key, hl = "key" }
        end,
        desc = function(item)
          return { item.desc, hl = "header" }
        end,
        icon = function(item)
          return { item.icon, hl = "key" }
        end,
      },
      preset = {
        keys = {
          { icon = " ", key = "s", desc = "Search Files", action = ":lua Snacks.dashboard.pick('files')" },
          {
            icon = " ",
            key = "g",
            desc = "Find Text",
            action = ":lua Snacks.dashboard.pick('live_grep')",
          },
          {
            icon = " ",
            key = "r",
            desc = "Recent Files",
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          {
            icon = "󰉋 ",
            key = "e",
            desc = "File Explorer",
            action = ":lua Snacks.explorer()",
          },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          {
            icon = "󰒲 ",
            key = "l",
            desc = "Lazy",
            action = ":Lazy",
            enabled = package.loaded.lazy ~= nil,
          },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = [[
 ____  ____ __  __ __ __ __ ___  ___
   // ||    ||\ || || || || ||\\//||
  //  ||==  ||\\|| \\ // || || \/ ||
 //__ ||___ || \||  \V/  || ||    ||]],
      },
    },
  },
}
