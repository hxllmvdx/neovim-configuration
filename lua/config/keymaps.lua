-- Visual mode: Shift+Tab удаляет отступы во всех выделенных строках
vim.keymap.set("v", "<S-Tab>", "<", { desc = "Unindent selection" })

-- Normal mode: Shift+Tab удаляет отступ у текущей строки
vim.keymap.set("n", "<S-Tab>", "<<", { desc = "Unindent current line" })

-- Optional: для consistency, Tab добавляет отступы
vim.keymap.set("v", "<Tab>", ">", { desc = "Indent selection" })
vim.keymap.set("n", "<Tab>", ">>", { desc = "Indent current line" })
