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
vim.api.nvim_set_keymap('', '<A-T>', '<C-w>T', {})
-- undo to the last , . or !
vim.api.nvim_set_keymap('i', ',', ',<c-g>u', {noremap = true})
vim.api.nvim_set_keymap('i', '.', '.<c-g>u', {noremap = true})
vim.api.nvim_set_keymap('i', '!', '!<c-g>u', {noremap = true})
vim.api.nvim_set_keymap('i', '?', '?<c-g>u', {noremap = true})

-- plugin mappings
-- gitsigns
vim.api.nvim_set_keymap('', '<leader>gs', ':Gitsigns toggle_signs<cr>',
                        {silent = true})
-- lsp stuff
vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>',
                            {noremap = true})
vim.api.nvim_set_keymap('', '<leader>K',
                        '<cmd>lua vim.diagnostic.open_float()<CR>',
                        {noremap = true})
vim.api.nvim_set_keymap('', '<leader>qf',
                        '<cmd>lua vim.diagnostic.setqflist({open = false})<cr><cmd>Telescope quickfix<cr>',
                        {silent = true})
-- toggle tagbar
vim.api.nvim_set_keymap('', '<leader>tt', ':TagbarToggle<cr>', {silent = true})
-- toggle NvimTree
vim.api.nvim_set_keymap('', '<C-n>', ':NvimTreeToggle<cr>', {silent = true})
-- toggle formatter
vim.api.nvim_set_keymap('', '<leader>fm', ':Neoformat<cr>', {silent = true})
-- toggle comment
vim.api.nvim_set_keymap('', '<leader>/', ':CommentToggle<cr>', {silent = true})
-- toggle Hop
vim.api.nvim_set_keymap('', '<leader>b', ':HopWordBC<cr>', {silent = true})
vim.api.nvim_set_keymap('', '<leader>w', ':HopWordAC<cr>', {silent = true})
vim.api.nvim_set_keymap('', '<leader>l', ':HopWordCurrentLine<cr>',
                        {silent = true})
-- telescope stuff
vim.api.nvim_set_keymap('', '<leader>fd', ':Telescope fd<cr>', {silent = true})
vim.api.nvim_set_keymap('', '<leader>tb', ':Telescope buffers<cr>',
                        {silent = true})
