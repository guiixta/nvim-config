local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug('mason-org/mason.nvim')


Plug('nvim-tree/nvim-tree.lua')
Plug('nvim-tree/nvim-web-devicons')
Plug('goolord/alpha-nvim')
Plug('mattn/emmet-vim')
Plug('nvim-lualine/lualine.nvim')
Plug('akinsho/bufferline.nvim')

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

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}


require('bufferline').setup({})
