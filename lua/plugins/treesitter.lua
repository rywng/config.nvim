require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"gitignore",
		"gitattributes",
		"gitcommit",
		"git_config",
		"git_rebase",
		"vim",
		"vimdoc",
		"query"
	},
	matchup = {
		enable = true,
		include_match_words = true,
	},
	highlight = {
		enable = true,              -- false will disable the whole extension
		additional_vim_regex_highlighting = true, -- git commit, etc.
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,
	},
	indent = { enable = true },
	textobjects = {
		select = {
			enable = true,

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				-- You can optionally set descriptions to the mappings (used in the desc parameter of
				-- nvim_buf_set_keymap) which plugins like which-key display
				["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
				-- You can also use captures from other query groups like `locals.scm`
				["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
			},
			selection_modes = {
				['@parameter.outer'] = 'v', -- charwise
				['@function.outer'] = 'V', -- linewise
				['@class.outer'] = '<c-v>', -- blockwise
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = { query = "@class.outer", desc = "Next class start" },
				["]o"] = "@loop.*",
				["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" }, -- nvim builtin spell is useless
				["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
				["[o"] = "@loop.*",
				["[z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		lsp_interop = {
			enable = true,
			peek_definition_code = {
				["<leader>df"] = "@function.outer",
				["<leader>dc"] = "@class.outer",
			},
		},
	},
})

-- Set up repeating with TS
require("plugins.repeat")

-- Setup fold
vim.opt.foldenable = false -- effectively disable fold on load, enable with zi
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Matchup settings
vim.g.matchup_matchparen_offscreen = {
	method = "popup"
}
