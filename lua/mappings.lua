local map = vim.api.nvim_set_keymap

-- generic mappings
map('v', '<', '<gv', {noremap = true})
map('v', '>', '>gv', {noremap = true})
map('n', 'Y', 'y$', {noremap = true})
map('n', 'n', 'nzzzv', {noremap = true})
map('n', 'N', 'Nzzzv', {noremap = true})

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
map('i', ',', ',<c-g>u', {noremap = true})
map('i', '.', '.<c-g>u', {noremap = true})
map('i', '!', '!<c-g>u', {noremap = true})
map('i', '?', '?<c-g>u', {noremap = true})

-- plugin mappings
-- gitsigns
map('', '<leader>gs', ':Gitsigns toggle_signs<cr>', {silent = true})
-- lsp stuff
map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>',
    {silent = false, noremap = true})
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true})
map('', '<leader>K', '<cmd>lua vim.diagnostic.open_float()<CR>',
    {noremap = true})
map('', '<leader>qf',
    '<cmd>lua vim.diagnostic.setqflist({open = false})<cr><cmd>Telescope quickfix<cr>',
    {silent = true})

-- toggle tagbar
map('', '<leader>tt', ':TagbarToggle<cr>', {silent = true})

-- toggle NvimTree
map('', '<C-n>', ':NvimTreeToggle<cr>', {silent = true})

-- toggle formatter
map('', '<leader>fm', ':Neoformat<cr>', {silent = true})

-- toggle Hop
map('', '<leader>b', ':HopWordBC<cr>', {silent = true})
map('', '<leader>w', ':HopWordAC<cr>', {silent = true})
map('', '<leader>l', ':HopWordCurrentLine<cr>', {silent = true})

-- telescope stuff
map('', '<leader>fd', ':Telescope fd<cr>', {silent = true})
map('', '<leader>tb', ':Telescope buffers<cr>', {silent = true})

-- Barbar controls
local opts = {noremap = true, silent = true}
-- Move to previous/next
map('n', 'gT', '<Cmd>BufferPrevious<CR>', opts)
map('n', 'gt', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-P>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A-N>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<A-w>', '<Cmd>BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
