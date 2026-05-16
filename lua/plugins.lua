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
Plug('ojroques/nvim-osc52')

Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')

Plug('numToStr/Comment.nvim')
Plug('lukas-reineke/indent-blankline.nvim')
Plug('brenton-leighton/multiple-cursors.nvim')
vim.call('plug#end')

-- Habilitando highlight para  linguagens 
require('nvim-treesitter').setup({
  ensure_installed = { 'rust', 'javascript', 'zig', 'php', 'blade', 'lua', 'html' },
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

require('bufferline').setup({
    options = {
        mode = "buffers",
        style_preset = {
			 require('bufferline').style_preset.italic,
			 require('bufferline').style_preset.bold,
		  },
        themable = true,
        numbers = "none", -- Opções: "none", "ordinal", "buffer_id", "both"
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d", 
        middle_mouse_command = nil,    
        indicator = {
            icon = '▎',
            style = 'icon', -- Opções: 'icon', 'underline', 'none'
        },
        buffer_close_icon = '󰅖',
        modified_icon = '● ',
        close_icon = ' ',
        left_trunc_marker = ' ',
        right_trunc_marker = ' ',
        
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,
        
        -- Se você usa nvim-lsp ou coc, mude para "nvim_lsp" ou "coc"
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_update_on_event = true,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            return "("..count..")"
        end,

        -- Exemplo clássico para dar espaço ao NvimTree (se você usar)
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "left",
                separator = true
            }
        },
        
        color_icons = true, 
        show_buffer_icons = true, 
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        show_duplicate_prefix = true, 
        duplicates_across_groups = true, 
        persist_buffer_sort = true, 
        move_wraps_at_ends = false, 
        
        separator_style = "slant", -- Opções: "slant", "slope", "thick", "thin"
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        auto_toggle_bufferline = true,
        
        hover = {
            enabled = true,
            delay = 200,
            reveal = {'close'}
        },
        sort_by = 'insert_after_current',
        pick = {
            alphabet = "abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMOPQRSTUVWXYZ1234567890",
        },
    }
})

vim.keymap.set('n', '<M-Left>', ':BufferLineCyclePrev<CR>', {silent = true})
vim.keymap.set('n', '<M-Right>', ':BufferLineCycleNext<CR>', {silent = true})
vim.keymap.set('n', '<leader>x', ':bdelete<CR>', {silent = true})


local function configlsp()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  vim.lsp.enable('intelephense', { capabilities = capabilities })
  vim.lsp.enable('eslint', { capabilities = capabilities })
end

configlsp()


local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function (args)
      vim.snippet.expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, -- Puxa dados do Intelephense / EsLint
  }, {
    { name = 'buffer' },   -- Puxa palavras do arquivo atual
  })
})


require('Comment').setup({
	---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment
    ignore = nil,
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
        ---Line-comment toggle keymap
        line = 'gcc',
        ---Block-comment toggle keymap
        block = 'gbc',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        ---Line-comment keymap
        line = 'gc',
        ---Block-comment keymap
        block = 'gb',
    },
    ---LHS of extra mappings
    extra = {
        ---Add comment on the line above
        above = 'gcO',
        ---Add comment on the line below
        below = 'gco',
        ---Add comment at the end of line
        eol = 'gcA',
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
    },
    pre_hook = nil,
    post_hook = nil,
})

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup({
	indent = {
		highlight = highlight
	}
})


require('multiple-cursors').setup({
	disabled_default_keymaps = {"NormalModeKeymaps", "VisualModeKeymaps"},
})

vim.keymap.set({'n', 'i', 'x'}, "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", { desc = "Adicionar cursor abaixo" })
vim.keymap.set({'n', 'i', 'x'}, "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", { desc = "Adicionar cursor acima" })
vim.keymap.set({'n', 'x'}, "<C-j>", "<Cmd>MultipleCursorsAddDown<CR>", { desc = "Adicionar cursor abaixo" })
vim.keymap.set({'n', 'x'}, "<C-k>", "<Cmd>MultipleCursorsAddUp<CR>", { desc = "Adicionar cursor acima" })

-- Mouse e Enter
vim.keymap.set({'n', 'i'}, "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", { desc = "Adicionar/Remover cursor no clique" })
vim.keymap.set('n', "<C-Return>", "<Cmd>MultipleCursorsAddDelete<CR>", { desc = "Bloquear ou remover cursor" })

-- Atalhos com Leader (Seleção inteligente de palavras)
vim.keymap.set('x', "<leader>m", "<Cmd>MultipleCursorsAddVisualArea<CR>", { desc = "Adicionar cursores nas linhas selecionadas" })
vim.keymap.set({'n', 'x'}, "<leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", { desc = "Selecionar TODAS as ocorrências da palavra" })
vim.keymap.set({'n', 'x'}, "<leader>A", "<Cmd>MultipleCursorsAddMatchesV<CR>", { desc = "Selecionar todas na área anterior" })
vim.keymap.set({'n', 'x'}, "<leader>d", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", { desc = "Selecionar próxima ocorrência (Estilo Ctrl+D)" })
vim.keymap.set({'n', 'x'}, "<leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>", { desc = "Pular para próxima ocorrência" })
vim.keymap.set({'n', 'x'}, "<leader>l", "<Cmd>MultipleCursorsLock<CR>", { desc = "Trancar cursores virtuais" })
