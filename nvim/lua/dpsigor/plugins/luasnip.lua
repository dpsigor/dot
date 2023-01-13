local setup, ls = pcall(require, "luasnip")
if not setup then
  return
end

local setup, vsloader = pcall(require, "luasnip.loaders.from_vscode")
if not setup then
  return
end

ls.snippets = {
  all = {
    ls.snippet("mn", {
      ls.text_node("Márcio Neto")
    })
  }
}

local x = vsloader.lazy_load({ paths = { "~/.config/nvim/my-snippets" } })
