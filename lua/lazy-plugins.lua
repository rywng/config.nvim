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
		end
	},
	-- TS, LSP, Completion
	{
		"williamboman/mason.nvim"
	},
	{

		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins.treesitter")
		end
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				"hrsh7th/cmp-nvim-lsp",
			},
			-- TODO: check the cmp sources
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"FelipeLema/cmp-async-path",
			"ray-x/cmp-treesitter",
			{
				"saadparwaiz1/cmp_luasnip",
				dependencies = {
					"L3MON4D3/LuaSnip"
				}
			},
			{
				"windwp/nvim-autopairs",
				config = function()
					require("plugins.nvim-autopairs")
				end
			},
		},
		event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			require("plugins/cmp")
		end
	},
	{
		"Dynge/gitmoji.nvim",
		ft = "gitcommit",
		dependencies = "hrsh7th/nvim-cmp"
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		dependencies = {
			"neovim/nvim-lspconfig",
			dependencies = {
				{
					"williamboman/mason-lspconfig.nvim",
					dependencies = {
						"williamboman/mason.nvim",
					}
				},
				"null-ls.nvim"
			},
			config = function()
				require("plugins.lsp")
			end,
		}
	},
	{
		"jay-babu/mason-null-ls.nvim",
		config = function()
			require("plugins.null-ls")
		end,
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim"
		}
	},
	-- Code editing
	{
		"machakann/vim-sandwich",
		keys = "s"
	},
	{
		"numToStr/Comment.nvim",
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
		config = function()
			require("plugins.telescope")
		end
	},
	{
		"tpope/vim-fugitive",
		event = "CmdlineEnter"
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
		'simrat39/symbols-outline.nvim',
		cmd = { 'SymbolsOutline', 'SymbolsOutlineOpen' },
		opts = { autofold_depth = 12 }
	},
	{
		'stevearc/dressing.nvim'
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
	}
}

local vscode_plugins = {
	"machakann/vim-sandwich",
	{
		"numToStr/Comment.nvim",
		event = "BufEnter",
		config = function()
			require("Comment").setup()
		end
	},
	"tpope/vim-fugitive"
}

if vim.g.vscode then
	-- VSCode extension
	require("lazy").setup(vscode_plugins, opts)
else
	-- ordinary Neovim
	require("lazy").setup(plugins, opts)
end
