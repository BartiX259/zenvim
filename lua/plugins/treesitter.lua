return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  opts = {
    ensure_installed = {
      "lua",
      "rust",
      "svelte",
      "html",
      "css",
      "javascript",
      "typescript",
      "markdown",
      "markdown_inline",
    },
    auto_install = true,
    highlight = {
      enable = true,
    },
  },
}
