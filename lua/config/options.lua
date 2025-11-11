-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Использовать пробел как leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Показывать номера строк
vim.opt.number = true

-- Относительные номера строк (опционально — уберите, если не нравится)
vim.opt.relativenumber = true

-- Включить подсветку текущей строки
vim.opt.cursorline = true

-- Использовать пробелы вместо табов
vim.opt.expandtab = true

-- Размер табуляции — 2 пробела
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Сохранять отступы при копировании/вставке
vim.opt.smartindent = true

-- Поиск с учётом регистра, только если есть заглавные буквы
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Визуальные улучшения
vim.opt.termguicolors = true
vim.opt.scrolloff = 8

-- Показывать диагностику в виртуальном тексте (справа от кода)
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
})

vim.opt.confirm = true -- автоматически сохранять при :q
