-- ~/.config/nvim/lua/config/dap/init.lua

-- Подключаем конфигурации языков
require("config.dap.python")
require("config.dap.cpp")

local dap, dapui = require("dap"), require("dapui")

-- Автооткрытие UI при запуске отладки
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
