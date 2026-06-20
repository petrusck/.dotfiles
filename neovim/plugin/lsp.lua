vim.pack.add({
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/barreiroleo/ltex-extra.nvim",
})

require("mason").setup()

-- Diagnostic config with custom sign icons
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "󰠠",
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = "Error",
			[vim.diagnostic.severity.WARN] = "Warn",
			[vim.diagnostic.severity.INFO] = "Info",
			[vim.diagnostic.severity.HINT] = "Hint",
		},
	},
})

-- LspAttach: only custom keymaps not built-in in 0.11
-- (gd, gD, gi, K, [d, ]d, grn, gra are all built-in now)
vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP Actions",
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)
		vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
	end,
})

-- Enable all configured LSP servers (configs auto-discovered from lsp/ directory)
vim.lsp.enable({
	"kotlin_lsp",
	"lua_ls",
	"ltex_plus",
	"vacuum",
	"ruby_lsp",
	"taplo",
	"gitlab_ci_ls",
	"sourcekit",
})
