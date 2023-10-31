local map = vim.api.nvim_set_keymap

-- vscode
if vim.g.vscode then
    -- undo/REDO via vscode
    map("n","u","<Cmd>call VSCodeNotify('undo')<CR>", {})
    map("n","<C-r>","<Cmd>call VSCodeNotify('redo')<CR>", {}) 
    map("n","gf", "<Cmd>call VSCodeCall('editor.action.openLink')<CR>", {silent = true, noremap = true})
end

-- generic mappings
map('v', '<', '<gv', { noremap = true })
map('v', '>', '>gv', { noremap = true })
map('n', 'Y', 'y$', { noremap = true })
map('n', 'n', 'nzzzv', { noremap = true })
map('n', 'N', 'Nzzzv', { noremap = true })

-- Shortcutting split navigation
map('', '<A-h>', '<C-w>h', {})
map('', '<A-j>', '<C-w>j', {})
map('', '<A-k>', '<C-w>k', {})
map('', '<A-l>', '<C-w>l', {})
map('', '<A-H>', '<C-w>H', {})
map('', '<A-J>', '<C-w>J', {})
map('', '<A-K>', '<C-w>K', {})
map('', '<A-L>', '<C-w>L', {})
map('', '<M-S-.>', '<C-w>>', {})
map('', '<M-S-,>', '<C-w><', {})
map('', '<M-S-=>', '<C-w>+', {})
map('', '<M-->', '<C-w>-', {})
map('', '<A-T>', '<C-w>T', {})

-- undo to the last , . or !
map('i', ',', ',<c-g>u', { noremap = true })
map('i', '.', '.<c-g>u', { noremap = true })
map('i', '!', '!<c-g>u', { noremap = true })
map('i', '?', '?<c-g>u', { noremap = true })

-- plugin mappings
-- gitsigns
map('', '<leader>gs', ':Gitsigns toggle_signs<cr>', { silent = true })
-- lsp stuff
map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>',
	{ silent = false, noremap = true })
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true })
map('', '<leader>K', '<cmd>lua vim.diagnostic.open_float()<CR>',
	{ noremap = true })
map('', '<leader>qf',
	'<cmd>lua vim.diagnostic.setqflist({open = false})<cr><cmd>Telescope quickfix<cr>',
	{ silent = true })

-- toggle tagbar
map('', '<leader>tt', ':TagbarToggle<cr>', { silent = true })

-- toggle formatter
map('', '<leader>fm', ':lua vim.lsp.buf.format({async = true})<cr>', { silent = true })

-- toggle Hop
map('', '<leader>b', ':HopWordBC<cr>', { silent = true })
map('', '<leader>w', ':HopWordAC<cr>', { silent = true })
map('', '<leader>l', ':HopWordCurrentLine<cr>', { silent = true })

-- telescope stuff
map('', '<leader>fd', ':Telescope fd<cr>', { silent = true })
map('', '<leader>tb', ':Telescope buffers<cr>', { silent = true })
