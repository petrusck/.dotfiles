-- Swift auto-runner: execute Swift files on save
vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("SwiftFilesRunner", { clear = true }),
	pattern = "*.swift",
	callback = function()
		local file_name = vim.api.nvim_buf_get_name(0)
		local buf_name = "[Swift Output]"

		-- Find or create the output buffer
		local buf = vim.fn.bufnr(buf_name)
		if buf == -1 then
			buf = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_buf_set_name(buf, buf_name)
		end

		-- Ensure the buffer is visible in a split
		local win = vim.fn.bufwinid(buf)
		if win == -1 then
			vim.cmd("botright split")
			vim.api.nvim_win_set_buf(0, buf)
			vim.api.nvim_win_set_height(0, 12)
		end

		-- Clear and set initial content
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "$ swift " .. file_name, "" })

		local append = function(_, data)
			if data then
				vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
			end
		end

		vim.fn.jobstart({ "swift", file_name }, {
			stdout_buffered = true,
			on_stdout = append,
			on_stderr = append,
		})
	end,
})

-- Set vimtex options before loading (reads globals on plugin load)
vim.g.vimtex_view_method = "skim"

vim.pack.add({
	"https://github.com/lervag/vimtex",
	{ src = "https://github.com/mrcjkb/haskell-tools.nvim", version = vim.version.range("4.x") },
	"https://github.com/cfdrake/vim-pbxproj",
})
