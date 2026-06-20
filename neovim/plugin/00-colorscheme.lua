vim.pack.add({ "https://github.com/ellisonleao/gruvbox.nvim" })

require("gruvbox").setup({
	terminal_colors = true,
	undercurl = true,
	underline = true,
	bold = true,
	italic = {
		strings = true,
		emphasis = true,
		comments = true,
		operators = false,
		folds = true,
	},
	strikethrough = true,
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	inverse = true,
	contrast = "hard",
	palette_overrides = {},
	overrides = {
		-- Diffview panel UI
		DiffviewPrimary = { fg = "#83a598" },
		DiffviewSecondary = { fg = "#8ec07c" },
		DiffviewReference = { fg = "#d3869b" },
		DiffviewDim1 = { fg = "#a89984" },
		DiffviewFilePanelTitle = { fg = "#83a598", bold = true },
		DiffviewFilePanelCounter = { fg = "#d3869b", bold = true },
		DiffviewFilePanelRootPath = { fg = "#8ec07c", bold = true },
		DiffviewFilePanelFileName = { fg = "#ebdbb2" },
		DiffviewFilePanelPath = { fg = "#a89984" },
		DiffviewFilePanelInsertions = { fg = "#b8bb26" },
		DiffviewFilePanelDeletions = { fg = "#fb4934" },
		DiffviewFilePanelConflicts = { fg = "#fe8019" },
		-- Diffview git status indicators
		DiffviewStatusAdded = { fg = "#b8bb26" },
		DiffviewStatusModified = { fg = "#fabd2f" },
		DiffviewStatusRenamed = { fg = "#83a598" },
		DiffviewStatusCopied = { fg = "#83a598" },
		DiffviewStatusTypeChanged = { fg = "#fabd2f" },
		DiffviewStatusUnmerged = { fg = "#fe8019" },
		DiffviewStatusUntracked = { fg = "#a89984" },
		DiffviewStatusDeleted = { fg = "#fb4934" },
		DiffviewStatusBroken = { fg = "#fb4934" },
		DiffviewStatusIgnored = { fg = "#504945" },
		-- Enhanced diff fill characters (subtle, non-distracting)
		DiffviewDiffDelete = { fg = "#504945" },
	},
	dim_inactive = false,
	transparent_mode = false,
})

vim.cmd.colorscheme("gruvbox")
