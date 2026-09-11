vim.g.mapleader = ' '

vim.pack.add({
	-- Theme
	-- {
	-- 	src = 'https://github.com/morhetz/gruvbox',
	-- 	version = 'v2.0.0',
	-- 	name = 'gruvbox'
	-- }
	{ src = 'https://github.com/echasnovski/mini.pick' },
	{ src = 'https://github.com/echasnovski/mini.extra' },
	{ src = 'https://github.com/echasnovski/mini.icons' },
	{ src = 'https://github.com/echasnovski/mini.files' },
	{ src = 'https://github.com/echasnovski/mini.diff' },
})

require('mini.icons').setup()
require('mini.pick').setup()
require('mini.extra').setup()
require('mini.files').setup()
require('mini.diff').setup()

vim.keymap.set('n', ']c', function()
	MiniDiff.goto_hunk('next')
end) -- next git change
vim.keymap.set('n', '[c', function()
	MiniDiff.goto_hunk('prev')
end) -- previous git change

vim.o.background = "light"
-- vim.cmd.colorscheme("gruvbox")

vim.lsp.config['zig'] = {
	cmd = { 'zls' },
	filetypes = { 'zig', 'zon' },
	root_markers = { 'build.zig' }
}
vim.lsp.enable('zig')

vim.lsp.config['lua'] = {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = { '.luarc.json', '.luarc.jsonc', '.git' }
}
vim.lsp.enable('lua')

vim.lsp.config['terraform'] = {
	cmd = { 'terraform-ls', 'serve' },
	filetypes = { 'terraform', 'terraform-vars' },
	root_markers = { '.terraform', '.git' }
}
vim.lsp.enable('terraform')

vim.opt.completeopt = { 'menuone', 'noinsert', 'popup' }
vim.o.ignorecase = true
vim.o.smartcase = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- clear search highlight

vim.keymap.set('i', '<A-BS>', '<C-w>')              -- delete word before cursor

vim.keymap.set('i', '<C-Space>', function()
	vim.lsp.completion.get()
end) -- manually trigger LSP completion

vim.keymap.set('i', '<Tab>', function()
	if vim.fn.pumvisible() == 1 then
		return '<C-y>' -- popup open: accept the selected item
	elseif vim.snippet.active({ direction = 1 }) then
		vim.snippet.jump(1)
		return ''
	else
		return '<Tab>'
	end
end, { expr = true })

vim.keymap.set('n', '<leader>g', function()
	MiniPick.builtin.grep_live()
end) -- live full-text search across project

vim.keymap.set('n', '<leader>p', function()
	MiniPick.builtin.files()
end)                                     -- fuzzy-find files by name

vim.keymap.set('n', '-', MiniFiles.open) -- open file explorer at current file's directory

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		vim.lsp.completion.enable(true, args.data.client_id, args.buf)

		local opts = { buffer = args.buf }
		vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, opts) -- go to definition
		vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts) -- go to type definition
		vim.keymap.set('n', '<leader>h', vim.lsp.buf.signature_help, opts) -- show function signature help
		vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts) -- format buffer via LSP
		vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts) -- show diagnostic under cursor
		vim.keymap.set('n', '<leader>n', vim.diagnostic.goto_next, opts) -- next diagnostic
		vim.keymap.set('n', '<leader>N', vim.diagnostic.goto_prev, opts) -- previous diagnostic
		vim.keymap.set('n', '<leader>s', function()
			MiniExtra.pickers.lsp({ scope = 'document_symbol' })
		end, opts) -- fuzzy-search symbols in current file
		vim.keymap.set('n', '<leader>S', function()
			MiniExtra.pickers.lsp({ scope = 'workspace_symbol_live' })
		end, opts) -- live fuzzy-search symbols across project

		vim.api.nvim_create_autocmd('BufWritePre', {
			buffer = args.buf,
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
	end,
})
