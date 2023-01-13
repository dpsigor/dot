local setup, treesitter = pcall(require, "nvim-treesitter.configs")
if not setup then
  return
end

treesitter.setup({
  highlight = {
    enable = true
  },
  indent = { enable = true },
  -- autotag = { enable = true }, -- need autotag plugin installed
  ensure_installed = {
    "json",
    "yaml",
    "javascript",
    "typescript",
    "go",
    "html",
    "css",
    "dockerfile",
    -- "gitignore",
  },
  auto_install = true,
})
