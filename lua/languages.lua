local M = {}

M.languages = {
  -- Systems & Low-level
  c               = { lsp = "clangd", ts = "c" },
  cpp             = { lsp = "clangd", ts = "cpp" },
  rust            = { lsp = "rust-analyzer", ts = "rust" },
  zig             = { lsp = "zls", ts = "zig" },
  go              = { lsp = "gopls", ts = "go" },
  cuda            = { lsp = "clangd", ts = "cuda" },

  -- Web & Frontend
  javascript      = { lsp = "typescript-language-server", ts = "javascript" },
  javascriptreact = { lsp = "typescript-language-server", ts = "javascript" },
  typescript      = { lsp = "typescript-language-server", ts = "typescript" },
  typescriptreact = { lsp = "typescript-language-server", ts = "tsx" },
  html            = { lsp = "html-lsp", ts = "html" },
  css             = { lsp = "css-lsp", ts = "css" },
  scss            = { lsp = "css-lsp", ts = "scss" },
  less            = { lsp = "css-lsp", ts = "css" },
  svelte          = { lsp = "svelte-language-server", ts = "svelte" },
  vue             = { lsp = "vue-language-server", ts = "vue" },
  astro           = { lsp = "astro-language-server", ts = "astro" },

  -- General & Scripting
  python          = { lsp = "pyright", ts = "python" },
  lua             = { lsp = "lua-language-server", ts = "lua" },
  sh              = { lsp = "bash-language-server", ts = "bash" },
  bash            = { lsp = "bash-language-server", ts = "bash" },
  ruby            = { lsp = "ruby-lsp", ts = "ruby" },
  php             = { lsp = "intelephense", ts = "php" },
  java            = { lsp = "jdtls", ts = "java" },
  cs              = { lsp = "csharp-language-server", ts = "c_sharp" },
  kotlin          = { lsp = "kotlin-language-server", ts = "kotlin" },
  elixir          = { lsp = "elixir-ls", ts = "elixir" },
  heex            = { lsp = "elixir-ls", ts = "heex" },
  clojure         = { lsp = "clojure-lsp", ts = "clojure" },

  -- Configs, Markup & Docs
  json            = { lsp = "json-lsp", ts = "json" },
  jsonc           = { lsp = "json-lsp", ts = "jsonc" },
  yaml            = { lsp = "yaml-language-server", ts = "yaml" },
  toml            = { lsp = "taplo", ts = "toml" },
  markdown        = { lsp = "marksman", ts = "markdown" },
  dockerfile      = { lsp = "dockerfile-language-server", ts = "dockerfile" },
  terraform       = { lsp = "terraform-ls", ts = "terraform" },
  nix             = { lsp = "nixd", ts = "nix" },
  sql             = { lsp = "sqls", ts = "sql" },
  proto           = { lsp = "protols", ts = "proto" },
  tex             = { lsp = "texlab", ts = "latex" },
  typst           = { lsp = "tinymist", ts = "typst" },

  -- Syntax-Only
  gitcommit       = { ts = "gitcommit" },
  gitignore       = { ts = "gitignore" },
  diff            = { ts = "diff" },
}

M.frameworks = {
  tailwindcss = {
    lsp = "tailwindcss-language-server",
    ft = { "html", "css", "scss", "javascriptreact", "typescriptreact", "vue", "svelte", "astro", "heex" },
    root = { "tailwind.config.js", "tailwind.config.ts", "tailwind.config.cjs", "tailwind.config.mjs", "postcss.config.js" },
  },
  biome = {
    lsp = "biome",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "json", "jsonc" },
    root = { "biome.json", "biome.jsonc" },
  },
  eslint = {
    lsp = "vscode-eslint-language-server",
    ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "svelte", "astro" },
    root = { ".eslintrc", ".eslintrc.js", ".eslintrc.json", "eslint.config.js", "eslint.config.mjs", "eslint.config.ts" },
  },
  prisma = {
    lsp = "prisma-language-server",
    ft = { "prisma" },
    root = { "prisma/schema.prisma" },
    ts = "prisma",
  },
  docker_compose = {
    lsp = "docker-compose-language-service",
    ft = { "yaml" },
    root = { "docker-compose.yml", "docker-compose.yaml", "compose.yml", "compose.yaml" },
  },
}

function M.get(name)
  return M.languages[name] or M.frameworks[name]
end

function M.label(cfg)
  local items = {}
  if cfg.lsp then table.insert(items, cfg.lsp .. " [LSP]") end
  if cfg.ts then table.insert(items, cfg.ts .. " [Treesitter]") end
  return table.concat(items, " + ")
end

function M.missing(cfg)
  local mr = require("mason-registry")
  local need_ts = cfg.ts and #vim.api.nvim_get_runtime_file("parser/" .. cfg.ts .. ".so", false) == 0
  local need_lsp = cfg.lsp and not mr.is_installed(cfg.lsp)
  return need_ts or need_lsp
end

return M
