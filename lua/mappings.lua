-- generic mappings

vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true})
vim.api.nvim_set_keymap('n', 'Y', 'y$', {noremap = true})
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', {noremap = true})
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', {noremap = true})
-- Shortcutting split navigation
vim.api.nvim_set_keymap('', '<A-h>', '<C-w>h', {})
vim.api.nvim_set_keymap('', '<A-j>', '<C-w>j', {})
vim.api.nvim_set_keymap('', '<A-k>', '<C-w>k', {})
vim.api.nvim_set_keymap('', '<A-l>', '<C-w>l', {})
vim.api.nvim_set_keymap('', '<A-H>', '<C-w>H', {})
vim.api.nvim_set_keymap('', '<A-J>', '<C-w>J', {})
vim.api.nvim_set_keymap('', '<A-K>', '<C-w>K', {})
vim.api.nvim_set_keymap('', '<A-L>', '<C-w>L', {})
vim.api.nvim_set_keymap('', '<A->>', '<C-w>>', {})
vim.api.nvim_set_keymap('', '<A-<>', '<C-w><', {})
-- undo to the last , . or !
vim.api.nvim_set_keymap('i', ',', ',<c-g>u', {noremap = true})
vim.api.nvim_set_keymap('i', '.', '.<c-g>u', {noremap = true})
vim.api.nvim_set_keymap('i', '!', '!<c-g>u', {noremap = true})
vim.api.nvim_set_keymap('i', '?', '?<c-g>u', {noremap = true})
