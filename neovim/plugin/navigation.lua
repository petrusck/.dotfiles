vim.pack.add({
	-- Shared dependencies (used by telescope, harpoon, neo-tree, oil)
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/MunifTanjim/nui.nvim",
	-- Telescope
	{ src = "https://github.com/nvim-telescope/telescope.nvim", version = "0.1.x" },
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	-- Harpoon
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
	-- Neo-tree
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = "v3.x" },
	-- Oil
	"https://github.com/stevearc/oil.nvim",
	-- Undotree
	"https://github.com/mbbill/undotree",
})

-- Telescope
require("telescope").setup({})
pcall(require("telescope").load_extension, "fzf")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search files" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search by grep" })
vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Search buffers" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search help" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search diagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Search resume" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = "Search recent files" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search current word" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search keymaps" })
vim.keymap.set("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Search Neovim config files" })

-- Harpoon
local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end)
vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)
vim.keymap.set("n", "<C-h>", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-t>", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<C-n>", function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<C-s>", function()
	harpoon:list():select(4)
end)
vim.keymap.set("n", "<C-S-P>", function()
	harpoon:list():prev()
end)
vim.keymap.set("n", "<C-S-N>", function()
	harpoon:list():next()
end)

-- Neo-tree (netrw is disabled in init.lua)
vim.keymap.set("n", "<leader>t", ":Neotree toggle<CR>", { silent = true })

require("neo-tree").setup({
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,
	close_if_last_window = true,
	filesystem = {
		filtered_items = {
			visible = true,
		},
		hijack_netrw_behavior = "open_default",
	},
	default_component_configs = {
		icon = {
			folder_empty = "󰜌",
			folder_empty_open = "󰜌",
		},
		git_status = {
			symbols = {
				renamed = "󰁕",
				unstaged = "󰄱",
			},
		},
	},
	document_symbols = {
		kinds = {
			File = { icon = "󰈙", hl = "Tag" },
			Namespace = { icon = "󰌗", hl = "Include" },
			Package = { icon = "󰏖", hl = "Label" },
			Class = { icon = "󰌗", hl = "Include" },
			Property = { icon = "󰆧", hl = "@property" },
			Enum = { icon = "󰒻", hl = "@number" },
			Function = { icon = "󰊕", hl = "Function" },
			String = { icon = "󰀬", hl = "String" },
			Number = { icon = "󰎠", hl = "Number" },
			Array = { icon = "󰅪", hl = "Type" },
			Object = { icon = "󰅩", hl = "Type" },
			Key = { icon = "󰌋", hl = "" },
			Struct = { icon = "󰌗", hl = "Type" },
			Operator = { icon = "󰆕", hl = "Operator" },
			TypeParameter = { icon = "󰊄", hl = "Type" },
			StaticMethod = { icon = "󰠄 ", hl = "Function" },
		},
	},
	source_selector = {
		sources = {
			{ source = "filesystem", display_name = " 󰉓 Files " },
			{ source = "git_status", display_name = " 󰊢 Git " },
		},
	},
	window = {
		position = "left",
		width = 30,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = {
			["<leader><leader>"] = "open",
			["<leader>p"] = { "toggle_preview", config = { use_float = true } },
			["l"] = "open_vsplit",
			["t"] = "open_tabnew",
			["w"] = "open_with_window_picker",
			["o"] = {
				"add",
				config = { show_path = "none" },
			},
			["O"] = "add_directory",
			["dd"] = "delete",
			["c"] = "rename",
			["yy"] = "copy_to_clipboard",
			["p"] = "paste_from_clipboard",
			["m"] = "move",
			["q"] = "close_window",
			["r"] = "refresh",
			["?"] = "show_help",
		},
	},
	event_handlers = {
		{
			event = "neo_tree_buffer_enter",
			handler = function()
				vim.opt_local.relativenumber = false
			end,
		},
	},
})

-- Auto-open on VimEnter only when no file arguments are given
vim.api.nvim_create_augroup("neotree", {})
vim.api.nvim_create_autocmd("VimEnter", {
	desc = "Open Neotree automatically when opening a directory or no arguments",
	group = "neotree",
	callback = function()
		if vim.fn.argc() == 0 then
			vim.cmd("Neotree toggle")
			vim.opt_local.relativenumber = false
		end
	end,
})

-- Oil
require("oil").setup({})
vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })

-- Undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
