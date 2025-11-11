return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  build = "make",
  opts = {
    provider = "ollama",
    model = "phi3:mini",

    providers = {
      ollama = {
        endpoint = "http://localhost:11434",
        model = "phi3:mini",
        keep_alive = "30m", -- Дольше держим модель в памяти для кода
        temperature = 0.2, -- Снижаем для более предсказуемого кода [[4]]
        top_p = 0.9, -- Контролируем разнообразие
        num_ctx = 4096, -- Максимальный контекст для phi3-mini
        -- Системный промпт специально для кода
        system_prompt = [[
You are an expert software developer assistant. Your task is to help the user write, debug, and improve code. Follow these guidelines:
1. Write clean, efficient, and well-documented code
2. Prefer modern best practices and patterns
3. Include error handling where appropriate
4. Explain your reasoning briefly but clearly
5. Match the coding style of the existing code
6. Focus on practical, working solutions
7. Be concise but thorough
8. Always consider edge cases and performance implications
        ]],
      },
    },

    -- Включаем RAG для получения контекста из кодовой базы [[10]]
    rag = {
      enabled = true,
      max_chunks = 5,
      chunk_size = 512,
      overlap = 64,
    },

    mappings = {
      diff = {
        ours = "co",
        theirs = "ct",
        all_theirs = "ca",
        both = "cb",
        cursor = "cc",
        next = "]x",
        prev = "[x",
      },
      suggestion = {
        accept = "<M-l>",
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
      jump = {
        next = "]]",
        prev = "[[",
      },
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      cancel = {
        normal = { "<C-c>", "<Esc>", "q" },
        insert = { "<C-c>" },
      },
      sidebar = {
        apply_all = "A",
        apply_cursor = "a",
        retry_user_request = "r",
        edit_user_request = "e",
        switch_windows = "<Tab>",
        reverse_switch_windows = "<S-Tab>",
        remove_file = "d",
        add_file = "@",
        close = { "<Esc>", "q" },
        close_from_input = nil,
      },
      scroll_up = "<C-u>",
      scroll_down = "<C-d>",
    },

    windows = {
      layout = "vertical",
      width = 0.7,
      height = 0.8, -- Больше высоты для просмотра кода
    },

    features = {
      auto_suggestions = true,
      code_actions = true,
      diff = true,
      jump = true,
      -- Важно для работы с кодом: захватываем контекст из окружающего кода [[14]]
      context_window = true,
    },

    -- Автоматические действия для работы с кодом
    actions = {
      -- При генерации кода автоматически добавляем контекст из открытых файлов
      generate = {
        include_context = true,
        include_file_context = true,
      },
      explain = {
        include_code_context = true,
      },
    },
  },

  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
  },

  keys = {
    {
      "<leader>aa",
      function()
        require("avante").show()
      end,
      desc = "Avante: Show",
    },
    {
      "<leader>ac",
      function()
        require("avante").close()
      end,
      desc = "Avante: Close",
    },
    {
      "<leader>aq",
      function()
        require("avante").explain()
      end,
      desc = "Avante: Explain",
    },
    {
      "<leader>as",
      function()
        require("avante").suggest()
      end,
      desc = "Avante: Suggest",
    },
    {
      "<leader>ag",
      function()
        require("avante").generate()
      end,
      desc = "Avante: Generate",
    },
    {
      "<leader>at",
      function()
        require("avante").terminal()
      end,
      desc = "Avante: Terminal (chat with context)",
    },
    {
      "<leader>af",
      function()
        require("avante").fix()
      end,
      desc = "Avante: Fix errors",
    },
  },

  config = function(_, opts)
    vim.defer_fn(function()
      vim.notify("Avante.nvim loaded with optimized settings for code generation", vim.log.levels.INFO)
    end, 100)

    require("avante").setup(opts)
  end,
}
