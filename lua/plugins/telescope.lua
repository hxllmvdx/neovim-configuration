-- ~/.config/nvim/lua/plugins/telescope.lua

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- обязательно
      "BurntSushi/ripgrep", -- для быстрого поиска (установите через brew)
    },
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find files",
      },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Live grep",
      },
      {
        "<leader>fb",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Switch buffers",
      },
      {
        "<leader>fh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "Help tags",
      },
      {
        "<leader>fw",
        function()
          require("telescope.builtin").grep_string({ search = vim.fn.input("Grep for: ") })
        end,
        desc = "Grep word under cursor",
      },
      {
        "<leader>fr",
        function()
          require("telescope.builtin").lsp_references()
        end,
        desc = "LSP references",
      },
      {
        "<leader>fd",
        function()
          require("telescope.builtin").lsp_definitions()
        end,
        desc = "LSP definitions",
      },
    },
    opts = {
      defaults = {
        -- Использовать ripgrep для поиска (если установлен)
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        -- Лучше видно результаты
        prompt_prefix = "🔍 ",
        selection_caret = "▶ ",
        path_display = { "smart" },
      },
    },
  },
}
