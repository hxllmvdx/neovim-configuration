-- ~/.config/nvim/lua/plugins/dap-ui.lua

return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio", -- для асинхронного UI
    },
    opts = {
      -- Конфигурация панелей
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.33 },
            { id = "breakpoints", size = 0.17 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            "console",
            "repl",
          },
          size = 15,
          position = "bottom",
        },
      },
      floating = {
        max_height = nil, -- 0.9
        max_width = nil, -- 0.5
      },
      expanded = true, -- начинать в развёрнутом виде
      controls = {
        enabled = true,
        element = "repl",
        icons = {
          pause = "",
          play = "",
          step_into = "",
          step_over = "",
          step_out = "",
          step_back = "",
          run_last = "↻",
          terminate = "⏹",
        },
      },
      icons = { expanded = "", collapsed = "" },
      render = {
        max_type_length = nil, -- ограничение длины типа
      },
    },
    keys = {
      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Debug: Start/Continue",
      },
      {
        "<F6>",
        function()
          require("dap").close()
        end,
        desc = "Debug: Stop",
      },
      {
        "<F9>",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Debug: Toggle Breakpoint",
      },
      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Debug: Step Over",
      },
      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Debug: Step Into",
      },
      {
        "<F12>",
        function()
          require("dap").step_out()
        end,
        desc = "Debug: Step Out",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle({})
        end,
        desc = "Debug: Toggle UI",
      },
      {
        "<leader>de",
        function()
          require("dapui").eval()
        end,
        desc = "Debug: Evaluate",
      },
    },
  },
}
