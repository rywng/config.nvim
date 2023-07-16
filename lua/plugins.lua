return require("packer").startup(function(use)
	use({ "wbthomason/packer.nvim" })

	-- core UI
	use({
		"ellisonleao/gruvbox.nvim",
		config = function()
			vim.cmd("colorscheme gruvbox")
		end,
	})
	use({ "nvim-tree/nvim-web-devicons" })
	use({
		"nvim-lualine/lualine.nvim",
		after = { "nvim-web-devicons" },
		config = function()
			require("plugins.statusline")
		end,
	})

	-- lsp stuff
	use({
		"neovim/nvim-lspconfig",
		after = { "mason-lspconfig.nvim", "null-ls.nvim" },
		config = function()
			require("plugins.lsp")
		end,
	})
	use({ "williamboman/mason-lspconfig.nvim", after = "mason.nvim" })
	use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-lspconfig" })
	use({
		"ray-x/lsp_signature.nvim",
		after = { "nvim-cmp" },
		config = function()
			require("plugins.lsp-signature")
		end,
	})

	-- tree sitter modules and tree sitter
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = {
			{
				"HiPhish/nvim-ts-rainbow2",
				after = { "nvim-treesitter" },
				config = function()
					require("plugins.treesitter")
				end,
			},
		},
		event = "UIEnter",
		run = ":TSUpdate",
	})

	-- completer
	use({
		"L3MON4D3/LuaSnip",
		event = "UIEnter",
		requires = { "rafamadriz/friendly-snippets" },
	})
	use({
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		after = { "LuaSnip", "cmp-nvim-lsp", "nvim-treesitter" },
		config = function()
			require("plugins.cmp")
		end,
		requires = {
			-- local
			{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
			{ "hrsh7th/cmp-buffer",  after = "nvim-cmp" },
			{ "hrsh7th/cmp-path",    after = "nvim-cmp" },
			{
				"petertriho/cmp-git",
				after = "nvim-cmp",
				config = function()
					require("cmp_git").setup()
				end,
			},
			{ "delphinus/cmp-ctags",                  after = "nvim-cmp" }, -- end
			-- lsp
			{ "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" }, -- TS
			{ "ray-x/cmp-treesitter",                 after = "nvim-cmp" }, -- end
			-- Snip
			{ "saadparwaiz1/cmp_luasnip",             after = { "nvim-cmp", "LuaSnip" } },
		},
	})

	-- formating and editing
	use({ "williamboman/mason.nvim", event = "BufEnter" })
	use({
		"windwp/nvim-autopairs",
		after = "nvim-cmp",
		config = function()
			require("plugins.nvim-autopairs")
		end,
	})
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		event = "BufEnter",
	})
	use({
		"jay-babu/mason-null-ls.nvim",
		config = function()
			require("plugins.null-ls")
		end,
		after = { "mason.nvim", "null-ls.nvim" },
	})
	use({
		"mattn/emmet-vim",
		ft = { "html", "htmldjango", "css", "markdown" },
		setup = function()
			require("plugins.emmet")
		end,
	})
	use({ "machakann/vim-sandwich", event = "UIEnter" })

	use({
		"numToStr/Comment.nvim",
		event = "UIEnter",
		config = function()
			require("Comment").setup()
		end,
	})

	-- navigation
	use({
		"andymass/vim-matchup",
		after = "nvim-treesitter",
		config = function()
			require("plugins.matchup")
		end,
	})
	use({
		"nvim-telescope/telescope.nvim",
		event = "UIEnter",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.telescope")
		end,
	})
	use({ "preservim/tagbar", cmd = "TagbarToggle" })
	use({
		"phaazon/hop.nvim",
		event = "UIEnter",
		as = "hop",
		config = function()
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})
	use({
		"c0r73x/neotags.lua",
		event = "BufEnter",
		config = function()
			require("neotags").setup({
				ctags = {
					directory = vim.env.HOME .. '/.cache/nvim/neotags/' -- default directory where to store tags

				}
			})
		end
	})

	-- eye-candy
	use({
		"eandrju/cellular-automaton.nvim",
		cmd = "CellularAutomaton",
	})
	use({
		"lewis6991/gitsigns.nvim",
		event = "UIEnter",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugins.gitsigns")
		end,
	})
	use({
		"nvim-treesitter/nvim-treesitter-context",
		after = "nvim-treesitter",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				patterns = {
					-- Match patterns for TS nodes. These get wrapped to match at word boundaries.
					-- For all filetypes
					-- Note that setting an entry here replaces all other patterns for this entry.
					-- By setting the 'default' entry below, you can control which nodes you want to
					-- appear in the context window.
					default = {
						"class",
						"function",
						"method",
						"for", -- These won't appear in the context
						"while",
						"if",
						"switch",
						"case",
					},
				},
			})
		end,
	})
	use({
		"winston0410/range-highlight.nvim",
		event = "CmdlineEnter",
		config = function()
			require("range-highlight").setup({})
		end,
		requires = "winston0410/cmd-parser.nvim",
	})
	use({
		"norcalli/nvim-colorizer.lua",
		event = "BufEnter",
		config = function()
			require("plugins.nvim-colorizer")
		end,
	})

	-- integrations
	use({ "tpope/vim-fugitive", cmd = "G" })
end)
-- vim:set shiftwidth=4 tabstop=4:
