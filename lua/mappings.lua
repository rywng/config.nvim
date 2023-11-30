local map = vim.keymap.set

-- vscode
if vim.g.vscode then
	-- undo/REDO via vscode
	map("n", "u", "<Cmd>call VSCodeNotify('undo')<CR>")
	map("n", "<C-r>", "<Cmd>call VSCodeNotify('redo')<CR>")
	map("n", "gf", "<Cmd>call VSCodeCall('editor.action.openLink')<CR>", { noremap = true })
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
