local vim = vim

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require('plugins')

vim.opt.termguicolors = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"
vim.api.nvim_set_option("clipboard", "unnamedplus")

vim.opt.fillchars = { eob = " " }
vim.o.signcolumn = "yes"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.undofile = true
vim.o.showmode = false
vim.o.updatetime = 250
vim.o.timeoutlen = 400

vim.opt.whichwrap:append "<>[]hl"

-- Atalhos para 'salvar', 'sair e salvar' e  'sair'
vim.keymap.set("n", "<C-x>", ":wq<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")


-- Atalho para copiar
--- vim.keymap.set("v", "<leader>0", '"*y')
vim.keymap.set('v', '<leader>0',
	function()
		vim.cmd('normal! y')
		local content = vim.fn.getreg('"')
		vim.fn.system('wl-copy', content)
	end, { desc = "Copy to wl-copy", silent = true })
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


vim.keymap.set('n', '<leader>-', '<Cmd>nohlsearch<CR>', { silent = true })

vim.keymap.set('n', '<leader>t', ':botright terminal<CR>', { desc = "Terminal open" })
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = "Sair do modo inserção do terminal" })
vim.api.nvim_create_autocmd('TermOpen', {
	group = vim.api.nvim_create_augroup('ConfigTerminalLocal', { clear = true }),
	pattern = '*',
	callback = function()
		-- Define o atalho apenas para o buffer atual do terminal (<buffer> / buffer = 0)
		vim.keymap.set('n', '<leader>t', '<Cmd>q!<CR>', {
			buffer = 0,
			desc = "Fechar terminal ativo",
			silent = true
		})
	end,
})


-- Mostra o erro em uma janela flutuante ao pausar o cursor em cima da linha
vim.api.nvim_create_autocmd("CursorHold", {
	buffer = bufnr,
	callback = function()
		local opts = {
			focusable = false,
			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
			border = 'rounded',
			source = 'always',
			prefix = ' ',
			scope = 'cursor',
		}
		vim.diagnostic.open_float(nil, opts)
	end,
})

-- Ajusta o tempo de espera para o popup aparecer (padrão é 4000ms / 4 segundos)
vim.o.updatetime = 300 -- 300 milissegundos é um bom equilíbrio

-- Atalho para ver os errors no arquivo
vim.keymap.set('n', '<leader>q', function()
	-- Pega o ID da janela do quickfix (se estiver fechada, retorna 0)
	local qf_winid = vim.fn.getqflist({ winid = 0 }).winid

	if qf_winid ~= 0 then
		-- Se o ID for diferente de 0, a janela está aberta. Então, fechamos.
		vim.cmd('cclose')
	else
		-- Se for 0, está fechada. Carregamos os diagnósticos e abrimos.
		vim.diagnostic.setqflist({ open = true })
	end
end, { desc = 'Toggle buffer com erros do arquivo atual' })

-- Vincula o 'gd' nativo à inteligência do LSP do Neovim
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Ir para definição (LSP)' })
