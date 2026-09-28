return {
  "kylechui/nvim-surround",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    aliases = {
      ["b"] = { ")", "}", "]", ">" },
    },
    surrounds = {
      ["b"] = {
        add = { "(", ")" },
      },
    },
  },
}
