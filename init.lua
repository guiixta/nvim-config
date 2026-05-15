vim.g.mapleader = " "
vim.g.maplocalleader = " "

require('plugins')

vim.opt.termguicolors = true

vim.opt.shiftwidth = 3
vim.opt.tabstop = 3
vim.opt.softtabstop = 3

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"

-- Atalhos para 'salvar', 'sair e salvar' e  'sair'
vim.keymap.set("n", "<C-x>", ":wq<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")

-- Atalho para copiar 
-- vim.keymap.set("v", "<leader>0", '"*y')
vim.keymap.set('v', '<leader>0', function() local content = vim.fn.getreg('"') vim.fn.system('wl-copy', content) end, {desc = "Copy wl-copy", silent = true})
