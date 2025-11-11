-- ~/.config/nvim/lua/plugins/terminal.lua

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {
      size = 15,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      persist_size = true,
      -- ИСПРАВЛЕНО: direction теперь объект, а не строка
      direction = "float", -- или "horizontal", "vertical" — но лучше использовать так:
      -- Альтернатива: явно задать функцию
      -- float_opts = {
      --   border = "curved",
      --   winblend = 0,
      --   highlights = {
      --     border = "Normal",
      --     background = "Normal",
      --   },
      -- },
    },
  },
}
