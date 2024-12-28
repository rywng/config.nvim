-- CORE SETTINGS
local o = vim.o
local g = vim.g
local map = vim.keymap.set

-- look and feel
g.netrw_banner = 0
g.netrw_bufsettings = "noma nomod relativenumber nowrap ro nobl"
g.netrw_liststyle = 3
g.netrw_winsize = 25
o.number = true
o.relativenumber = true
o.ruler = true
o.scrolloff = 10
o.showmode = false
o.title = true
vim.opt.diffopt = { "internal", "filler", "closeoff", "iwhite" }

-- controlling
g.mapleader = ' '
o.autoindent = true
o.breakindent = true
o.complete = ''
o.ignorecase = true
o.smartcase = true
o.smartindent = true
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert' }

-- vscode
if vim.g.vscode then
	vim.opt.syntax = "OFF"
	g.clipboard = g.vscode_clipboard
	-- undo/REDO via vscode
	map("n", "u", "<Cmd>call VSCodeNotify('undo')<CR>")
	map("n", "<C-r>", "<Cmd>call VSCodeNotify('redo')<CR>")
	map("n", "gf", "<Cmd>call VSCodeCall('editor.action.openLink')<CR>", { noremap = true })
	map({ "i", "n" }, "", "<Cmd>call VSCodeCall('editor.action.triggerParameterHints')<CR>", { noremap = true })
end

-- Fix Y, and center candidate on search
map('n', 'Y', 'y$', { noremap = true })
map('n', 'n', 'nzzzv', { noremap = true })
map('n', 'N', 'Nzzzv', { noremap = true })

-- undo to the last , . ? or !
map('i', ',', ',<c-g>u', { noremap = true })
map('i', '.', '.<c-g>u', { noremap = true })
map('i', '!', '!<c-g>u', { noremap = true })
map('i', '?', '?<c-g>u', { noremap = true })
