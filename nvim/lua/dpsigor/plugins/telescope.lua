local setup, telescope = pcall(require, "telescope")
if not setup then
  return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
  return
end

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<ESC>"] = actions.close,
      }
    },
    layout_config = {
      horizontal = { height = 0.99, width = 0.99, preview_width = 100 },
    },
  },
})

telescope.load_extension("fzf")
