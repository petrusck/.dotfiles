vim.loader.enable()

-- Set leader keys before plugins so mappings are correct
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- [[ Options ]]
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = false
opt.shiftround = true
opt.autoindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.inccommand = "split"

-- UI
opt.cursorline = true
opt.scrolloff = 10
opt.signcolumn = "yes"
opt.showmode = false
opt.termguicolors = true
opt.breakindent = true
opt.linebreak = true
opt.showbreak = "↪ "
opt.mouse = "a"
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Files
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undo"
opt.autoread = true
opt.confirm = true
opt.hidden = true

-- Clipboard: schedule after UiEnter to avoid startup slowdown
vim.schedule(function()
	opt.clipboard = "unnamedplus"
end)

-- Spell
opt.spell = true
opt.spelllang = "en_us"

-- Folding
opt.foldmethod = "indent"
opt.foldlevel = 99

-- Performance
opt.updatetime = 250
opt.timeoutlen = 300

-- [[ Keymaps ]]
local map = vim.keymap.set

-- Clear search highlights
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Move visual block up/down
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Move line up/down in normal mode (not overriding J/K)
map("n", "<leader>j", ":m .+1<CR>==")
map("n", "<leader>k", ":m .-2<CR>==")

-- Scroll centered
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Search centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Paste without yanking
map("x", "<leader>p", '"_dP')

-- Window navigation (C-h reserved for Harpoon)
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "<C-l>", "<C-w><C-l>")

-- Open URL in browser
map("n", "gx", '<Cmd>call jobstart(["open", expand("<cfile>")], {"detach": v:true})<CR>')

-- Buffer navigation
map("n", "<leader>th", ":bprev<CR>", { silent = true })
map("n", "<leader>tl", ":bnext<CR>", { silent = true })
map("n", "<leader>tj", ":bfirst<CR>", { silent = true })
map("n", "<leader>tk", ":blast<CR>", { silent = true })
map("n", "<leader>td", ":bdelete<CR>", { silent = true })

-- Spell switching
map("n", "<leader>dd", ":setlocal spelllang=de_de<CR>", { silent = true })
map("n", "<leader>ee", ":setlocal spelllang=en_us<CR>", { silent = true })

-- Exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>")

-- [[ Autocmds ]]
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight yanked text
autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- Wrap on diff
autocmd("FilterWritePre", {
	pattern = "*",
	command = "if &diff | setlocal wrap< | endif",
})

-- Markdown settings
autocmd("BufEnter", {
	pattern = "*.md",
	callback = function()
		vim.opt_local.conceallevel = 1
		vim.opt_local.complete:append("kspell")
	end,
})

-- Git commit kspell completion
autocmd("FileType", {
	pattern = "gitcommit",
	callback = function()
		vim.opt_local.complete:append("kspell")
	end,
})

-- Filetype detection
vim.filetype.add({
	pattern = {
		[".*openapi.*%.ya?ml"] = "yaml.openapi",
		[".*openapi.*%.json"] = "json.openapi",
		[".*/git/.*config.*"] = "gitconfig",
	},
})

-- GitLab CI filetype
autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.gitlab-ci*.{yml,yaml}*",
	callback = function()
		vim.bo.filetype = "yaml.gitlab"
	end,
})

-- Regenerate spell files on startup
local spell_dir = vim.fn.stdpath("config") .. "/spell"
for _, f in ipairs(vim.fn.glob(spell_dir .. "/*.add", false, true)) do
	if
		vim.fn.filereadable(f) == 1
		and (vim.fn.filereadable(f .. ".spl") == 0 or vim.fn.getftime(f) > vim.fn.getftime(f .. ".spl"))
	then
		vim.cmd("mkspell! " .. vim.fn.fnameescape(f))
	end
end

-- [[ Disable netrw (neo-tree replaces it) ]]
-- Must be set before plugin/ scripts are sourced
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- [[ vim.pack build hooks ]]
-- Created before any vim.pack.add() calls (in plugin/ files) so they fire on install too
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		local plugin_dir = vim.fn.stdpath("data") .. "/site/pack/core/opt/" .. name

		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end

		if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
			vim.system({ "make" }, { cwd = plugin_dir }):wait()
		end

		if name == "peek.nvim" and (kind == "install" or kind == "update") then
			vim.system({ "deno", "task", "--quiet", "build:fast" }, { cwd = plugin_dir }):wait()
		end
	end,
})
