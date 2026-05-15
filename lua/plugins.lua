local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug('mason-org/mason.nvim')


Plug('nvim-tree/nvim-tree.lua')
Plug('nvim-tree/nvim-web-devicons')
Plug('goolord/alpha-nvim')
Plug('mattn/emmet-vim')

vim.call('plug#end')

-- Habilitando highlight para  linguagens 
require('nvim-treesitter').install { 'rust', 'javascript', 'zig', 'php', 'blade', 'lua', 'html' }

require('nvim-treesitter').setup({
  highlight = {
      enable = true,
  },
})


require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})


-- Atalhos nvim-tree aberto
local function meus_atalhos(bufnr)
  local api = require "nvim-tree.api"
  local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end  

  api.map.on_attach.default(bufnr)

  -- deletando C-t para usa-lo de togglee
  vim.keymap.del("n", "<C-t>", { buffer = bufnr })

  -- Meus atalhos
  vim.keymap.set("n", "<C-u>", api.tree.change_root_to_parent, opts("Up"))
end

-- atalhos globais
vim.keymap.set("n", "<C-t>", function() require("nvim-tree.api").tree.toggle() end, {desc = "Toggle Tree", silent = true})

require("nvim-tree").setup({
  sort = {
      sorter = "case_sensitive",
  },
  view = {
      width = 30,
  },
  renderer = {
      group_empty = true,
  },
  filters ={
      dotfiles = true,
  },
  on_attach = meus_atalhos,
})


require("alpha").setup(
  require "alpha.themes.startify".config
)


