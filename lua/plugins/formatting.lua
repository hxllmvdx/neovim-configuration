-- ~/.config/nvim/lua/plugins/formatting.lua

return {
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format", "ruff", "isort" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        cs = { "omnisharp" },
        rust = { "rustfmt" },
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
      },
    },
  },
}
