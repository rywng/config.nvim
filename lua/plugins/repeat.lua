local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
-- Repeat movement with ; and ,
-- vim way: ; goes to the direction you were moving.
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
-- Repeat vim builtins
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
-- Repeat gitsigns
local gitsigns = require "gitsigns"
local next_hunk = function()
	if vim.wo.diff then
		vim.cmd.normal({ ']c', bang = true })
	else
		gitsigns.nav_hunk('next')
	end
end
local prev_hunk = function()
	if vim.wo.diff then
		vim.cmd.normal({ '[c', bang = true })
	else
		gitsigns.nav_hunk('prev')
	end
end
local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(next_hunk, prev_hunk)
vim.keymap.set({ "n", "x", "o" }, "]c", next_hunk_repeat)
vim.keymap.set({ "n", "x", "o" }, "[c", prev_hunk_repeat)
-- Repeat lsp diagnoistics
local next_diagnostic, prev_diagnostic = ts_repeat_move.make_repeatable_move_pair(vim.diagnostic.goto_next,
	vim.diagnostic.goto_prev)
vim.keymap.set({ "n", "x", "o" }, "]d", next_diagnostic)
vim.keymap.set({ "n", "x", "o" }, "[d", prev_diagnostic)
