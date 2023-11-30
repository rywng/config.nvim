local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local opts = {
	install = {
		colorscheme = { "gruvbox" }
	},
	dev = {
		path = "~/.local/src"
	}
}

local plugins = {
	-- main UI
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme gruvbox]])
		end
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugins.statusline")
		end,
		event = "UIEnter"
	},
	-- TS, LSP, Completion
	{
		"williamboman/mason.nvim",
		lazy = true
	},
	{

		"nvim-treesitter/nvim-treesitter",
		lazy = true,
		config = function()
			require("plugins.treesitter")
		end,
		build = ":TSUpdate"
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		lazy = true
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-cmdline",
			"FelipeLema/cmp-async-path",
			{
				"saadparwaiz1/cmp_luasnip",
				dependencies = {
					"L3MON4D3/LuaSnip"
				}
			},
		},
		event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			require("plugins/cmp")
		end
	},
	{
		"Dynge/gitmoji.nvim",
		ft = { "gitcommit", "NeogitCommitMessage" },
		opts = {
			filetypes = { "gitcommit", "octo", "NeogitCommitMessage" },
			completion = {
				append_space = true,
			},
		},
		dependencies = "hrsh7th/nvim-cmp"
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		lazy = true
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
				dependencies = {
					"williamboman/mason.nvim",
				}
			},
		},
		config = function()
			require("plugins.lsp")
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		config = function()
			require("plugins.null-ls")
		end,
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim"
		}
	},
	-- Code editing
	{
		"machakann/vim-sandwich",
		keys = "s"
	},
	{
		"numToStr/Comment.nvim",
		event = "ModeChanged",
		keys = "g",
		config = function()
			require("Comment").setup()
		end
	},
	{
		"andymass/vim-matchup",
		event = "BufEnter"
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { 'nvim-lua/plenary.nvim' },
		event = "CmdlineEnter",
		keys = {
			vim.keymap.set('', '<leader>t/', ':Telescope lsp_dynamic_workspace_symbols<cr>'),
			vim.keymap.set('', '<leader>tg', ':Telescope live_grep<cr>'),
			vim.keymap.set('', '<leader>tb', ':Telescope buffers<cr>'),
			vim.keymap.set('', '<leader>tf', ':Telescope fd<cr>'),
		},
		config = function()
			require("plugins.telescope")
		end
	},
	{
		"folke/trouble.nvim",
		lazy = true,
		cmd = "Troubletoggle",
		keys = {
			vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end),
			vim.keymap.set("n", "<leader>xw",
				function() require("trouble").toggle("workspace_diagnostics") end),
			vim.keymap.set("n", "<leader>xd",
				function() require("trouble").toggle("document_diagnostics") end),
			vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end),
			vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end),
			-- lsp
			vim.keymap.set("n", "<leader>gr", function()
				require("trouble").toggle("lsp_references")
			end),
			vim.keymap.set('n', '<leader>D', function()
				require("trouble").toggle("lsp_type_definitions")
			end),
			vim.keymap.set('n', 'gd', function ()
				require("trouble").toggle("lsp_definitions")
			end),
			vim.keymap.set('n', '<leader>gi', function()
				require("trouble").toggle("lsp_implementations")
			end),
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		cmd = "Neogen",
		opts = {
			snippet_engine = "luasnip"
		},
		config = true,
	},
	{
		'altermo/ultimate-autopair.nvim',
		event = { 'InsertEnter', 'CmdlineEnter' },
		opts = {
		},
	},

	-- Eye candy UI
	{
		"NvChad/nvim-colorizer.lua",
		cmd = { "ColorizerAttachToBuffer",
			"ColorizerToggle"
		},
		config = function()
			require("colorizer").setup()
		end
	},
	{
		"winston0410/range-highlight.nvim",
		event = "CmdlineEnter"
	},
	{
		'cameron-wags/rainbow_csv.nvim',
		config = true,
		ft = {
			'csv',
			'tsv',
			'csv_semicolon',
			'csv_whitespace',
			'csv_pipe',
			'rfc_csv',
			'rfc_semicolon'
		},
		cmd = {
			'RainbowDelim',
			'RainbowDelimSimple',
			'RainbowDelimQuoted',
			'RainbowMultiDelim'
		}
	},
	{
		'simrat39/symbols-outline.nvim',
		cmd = { 'SymbolsOutline', 'SymbolsOutlineOpen' },
		keys = {
			vim.keymap.set('n', '<leader>o', ':SymbolsOutline<cr>'),
		},
		opts = { autofold_depth = 12 }
	},
	{
		'stevearc/dressing.nvim',
		event = "UIEnter"
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufEnter",
		opts = {
			signcolumn = false,
			numhl = true,
			current_line_blame_opts = {
				delay = 300,
				ignore_whitespace = false,
				virt_text_priority = 100,
			},
		},
	},

	-- misc and games
	{
		"seandewar/killersheep.nvim",
		cmd = "KillKillKill"
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"nvim-telescope/telescope.nvim", -- optional
			"sindrets/diffview.nvim", -- optional
		},
		cmd = { "Neogit", "NeogitResetState" },
		keys = {
			vim.keymap.set("n", "<leader>ng", ":Neogit<cr>")
		},
		opts = {
			disable_hint = true,
		},
	},
}

local vscode_plugins = {
	{
		"machakann/vim-sandwich",
		keys = "s"
	},
	{
		"numToStr/Comment.nvim",
		event = "BufEnter",
		config = function()
			require("Comment").setup()
		end
	},
}

if vim.g.vscode then
	-- VSCode extension
	require("lazy").setup(vscode_plugins, opts)
else
	-- ordinary Neovim
	require("lazy").setup(plugins, opts)
end
