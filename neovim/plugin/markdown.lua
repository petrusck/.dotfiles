vim.pack.add({
	"https://github.com/arminveres/md-pdf.nvim",
	"https://github.com/dhruvasagar/vim-table-mode",
	"https://github.com/Maduki-tech/nvim-plantuml",
})

require("md-pdf").setup({
	margins = "1.5cm",
	highlight = "tango",
	toc = true,
	preview_cmd = function()
		return "firefox"
	end,
})

vim.keymap.set("n", "<leader>,", function()
	require("md-pdf").convert_md_to_pdf()
end, { desc = "Markdown to PDF" })

require("plantuml").setup({
	output_dir = "/tmp",
	viewer = "open",
	auto_refresh = true,
})

-- Peek: lazy-load after startup (non-critical, has deno build step)
vim.schedule(function()
	vim.pack.add({ "https://github.com/toppair/peek.nvim" })
	require("peek").setup()
	vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
	vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
end)
