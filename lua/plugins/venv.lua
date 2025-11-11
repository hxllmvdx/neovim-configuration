return {
  "linux-cultist/venv-selector.nvim",
  opts = {
    name = { ".venv" }, -- Папки с виртуальным окружением
  },
  keys = {
    { "<leader>lv", "<cmd>VenvSelect<cr>", desc = "Select Venv" },
  },
}
