local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})


vim.call('plug#end')

-- Habilitando highlight para  linguagens 
vim.api.nvim_create_autocmd('javascript', {
  callback = function()
    vim.treesitter.start()
  end,
})
