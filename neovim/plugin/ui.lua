vim.pack.add({
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	"https://github.com/petertriho/nvim-scrollbar",
	"https://github.com/folke/zen-mode.nvim",
})

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "gruvbox-material",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	extensions = { "neo-tree" },
})

require("ibl").setup({
	indent = { char = "▏" },
	scope = { enabled = false },
})

require("scrollbar").setup({})
require("scrollbar.handlers.gitsigns").setup()

require("zen-mode").setup({
	window = { width = 150 },
})
