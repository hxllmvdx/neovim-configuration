-- ~/.config/nvim/lua/plugins/autosave.lua

return {
  {
    "pocco81/auto-save.nvim",
    event = "InsertLeave",
    opts = {
      execution_message = {
        message = function()
          return "Autosaved at " .. vim.fn.strftime("%H:%M:%S")
        end,
        dim = 0.18,
      },
      trigger_events = { "InsertLeave", "TextChanged" },
      condition = function(buf)
        if not vim.api.nvim_buf_is_valid(buf) then
          return false -- Буфер не существует
        end
        local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
        local modified = vim.api.nvim_buf_get_option(buf, "modified")
        local name = vim.api.nvim_buf_get_name(buf)
        return buftype == "" and modified and name ~= ""
      end,
      write_all_buffers = true,
      debounce_delay = 130,
    },
  },
}
