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

-- generic mappings
map('v', '<', '<gv', { noremap = true })
map('v', '>', '>gv', { noremap = true })
map('n', 'Y', 'y$', { noremap = true })
map('n', 'n', 'nzzzv', { noremap = true })
map('n', 'N', 'Nzzzv', { noremap = true })

-- Shortcutting split navigation
map('', '<A-h>', '<C-w>h')
map('', '<A-j>', '<C-w>j')
map('', '<A-k>', '<C-w>k')
map('', '<A-l>', '<C-w>l')
map('', '<A-H>', '<C-w>H')
map('', '<A-J>', '<C-w>J')
map('', '<A-K>', '<C-w>K')
map('', '<A-L>', '<C-w>L')
map('', '<M-S-.>', '<C-w>>')
map('', '<M-S-,>', '<C-w><')
map('', '<M-S-=>', '<C-w>+')
map('', '<M-->', '<C-w>-')
map('', '<A-T>', '<C-w>T')

-- undo to the last , . or !
map('i', ',', ',<c-g>u', { noremap = true })
map('i', '.', '.<c-g>u', { noremap = true })
map('i', '!', '!<c-g>u', { noremap = true })
map('i', '?', '?<c-g>u', { noremap = true })
