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

-- plugin mappings
-- toggle NvimTree
vim.api.nvim_set_keymap('', '<C-n>', ':NvimTreeToggle<cr>', {silent = true})
-- toggle formatter
vim.api.nvim_set_keymap('', '<leader>fm', ':Neoformat<cr>', {silent = true})
vim.api.nvim_set_keymap('', '<leader>/', ':CommentToggle<cr>', {silent = true})
vim.api.nvim_set_keymap('', '<leader>r', ':SnipRun<cr>', {silent = true})
vim.api.nvim_set_keymap('', '<leader>b', ':HopWordBC<cr>', {silent = true})
vim.api.nvim_set_keymap('', '<leader>w', ':HopWordAC<cr>', {silent = true})
vim.api.nvim_set_keymap('', '<leader>k', ':HopLineStartBC<cr>', {silent = true})
vim.api.nvim_set_keymap('', '<leader>j', ':HopLineStartAC<cr>', {silent = true})
vim.api.nvim_set_keymap('', '<leader>tf', ':Telescope fd<cr>', {silent = true})
vim.api.nvim_set_keymap('', '<leader>tb', ':Telescope buffers<cr>', {silent = true})
vim.api.nvim_set_keymap('', '<leader>tq', ':Telescope quickfix<cr>', {silent = true})
vim.api.nvim_set_keymap('', '<leader>tdd',
                        ':Telescope lsp_document_diagnostics<cr>', {silent = true})
vim.api.nvim_set_keymap('', '<leader>tdw',
                        ':Telescope lsp_workspace_diagnostics<cr>', {silent = true})
vim.api.nvim_set_keymap('', '<leader>dt', ':lua require("dapui").toggle()<cr>', {silent = true})
vim.api.nvim_set_keymap('', '<leader>de', ':lua require("dapui").eval()<cr>', {silent = true})
