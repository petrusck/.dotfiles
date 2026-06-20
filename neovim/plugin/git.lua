vim.pack.add({
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/sindrets/diffview.nvim",
})

require("gitsigns").setup({
	signs = {
		add = { text = "│" },
		change = { text = "│" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
		untracked = { text = "┆" },
	},
	signcolumn = true,
	numhl = false,
	linehl = false,
	word_diff = true,
	watch_gitdir = { follow_files = true },
	auto_attach = true,
	attach_to_untracked = false,
	current_line_blame = false,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol",
		delay = 1000,
		ignore_whitespace = false,
		virt_text_priority = 100,
	},
	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
	sign_priority = 6,
	update_debounce = 100,
	max_file_length = 40000,
	preview_config = {
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
})

require("diffview").setup({
	enhanced_diff_hl = true,
	view = {
		default = {
			layout = "diff2_horizontal",
			disable_diagnostics = true,
			winbar_info = true,
		},
		merge_tool = {
			layout = "diff3_mixed",
			disable_diagnostics = true,
			winbar_info = true,
		},
		file_history = {
			layout = "diff2_horizontal",
			disable_diagnostics = true,
			winbar_info = true,
		},
	},
	file_panel = {
		listing_style = "tree",
		tree_options = {
			flatten_dirs = true,
			folder_statuses = "only_folded",
		},
		win_config = {
			position = "left",
			width = 35,
		},
	},
	hooks = {
		diff_buf_read = function()
			vim.opt_local.wrap = false
			vim.opt_local.list = false
			vim.opt_local.relativenumber = false
		end,
	},
})

-- Diffview keymaps
vim.keymap.set("n", "<leader>go", "<cmd>DiffviewOpen<cr>", { desc = "Diffview: open (working tree vs index)" })
vim.keymap.set("n", "<leader>gc", "<cmd>DiffviewClose<cr>", { desc = "Diffview: close" })
vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "Diffview: current file history" })
vim.keymap.set("n", "<leader>gH", "<cmd>DiffviewFileHistory<cr>", { desc = "Diffview: branch history" })
vim.keymap.set("n", "<leader>gf", "<cmd>DiffviewFocusFiles<cr>", { desc = "Diffview: focus file panel" })
vim.keymap.set("n", "<leader>gt", "<cmd>DiffviewToggleFiles<cr>", { desc = "Diffview: toggle file panel" })
vim.keymap.set("n", "<leader>gr", "<cmd>DiffviewRefresh<cr>", { desc = "Diffview: refresh" })
