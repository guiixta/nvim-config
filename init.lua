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
vim.api.nvim_set_option("clipboard", "unnamedplus")

-- Atalhos para 'salvar', 'sair e salvar' e  'sair'
vim.keymap.set("n", "<C-x>", ":wq<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")

-- Atalho para copiar 
--- vim.keymap.set("v", "<leader>0", '"*y')
vim.keymap.set('v', '<leader>0', function() vim.cmd('normal! y') local content = vim.fn.getreg('"') vim.fn.system('wl-copy', content) end, { desc = "Copy to wl-copy", silent = true })
-- vim.keymap.set('v', '<leader>0', require('osc52').copy_visual, {desc = "Copy osc52 to clipboard", silent = true})


-- Substituir termo selecionado no modo Visual
vim.keymap.set('x', '<leader>[', function()
    local antigo_reg = vim.fn.getreg('z')
    
    vim.cmd('normal! "zy')
    
    local termo = vim.fn.escape(vim.fn.getreg('z'), '/\\*~^$.')
    
    vim.fn.setreg('z', antigo_reg)

    local comando = string.format([[:<C-u>%%s/%s//g<Left><Left>]], termo)
    
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(comando, true, false, true), 'n', false)
end, { desc = "Substituir seleção atual no arquivo" })


vim.keymap.set('n', '<leader>-', '<Cmd>nohlsearch<CR>', {silent = true})
