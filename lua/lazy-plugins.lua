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
	defaults = {
		lazy = true,
	},
	dev = {
		path = "~/.local/src"
	},
	install = {
		-- try to load one of these colorschemes when starting an installation during startup
		colorscheme = { "gruvbox-material", "habamax" },
	},
}

local plugins = {
	-- main UI
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_better_performance = true
			vim.g.gruvbox_material_enable_bold = true
			vim.g.gruvbox_material_foreground = 1
			vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
			vim.cmd([[colorscheme gruvbox-material]])
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
	},
	{

		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins.treesitter")
		end,
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/nvim-treesitter-textobjects"
		}
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup {
				multiline_threshold = 4,
				max_lines = 8
			}
		end
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip").setup()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
		-- install jsregexp (optional!).
		build = "make install_jsregexp"
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
			require("plugins/nvim-cmp")
		end
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"neovim/nvim-lspconfig",
		},
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

	-- rust lsp support
	{
		'mrcjkb/rustaceanvim',
		ft = { 'rust' },
		key = {
			vim.keymap.set('n', '<leader>rr', ':RustLsp runnables<cr>'),
		}
	},
	{
		'saecki/crates.nvim',
		tag = 'stable',
		event = { "BufRead Cargo.toml" },
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('crates').setup({
				null_ls = {
					enabled = true,
				},
			})
			-- setup cmp completion
			vim.api.nvim_create_autocmd("BufRead", {
				group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
				pattern = "Cargo.toml",
				callback = function()
					require('cmp').setup.buffer({ sources = { { name = "crates" } } })
				end,
			})
		end,
	},

	-- Code editing
	{
		"machakann/vim-sandwich",
		event = "ModeChanged",
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
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'CFLAGS=-march=native make',
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-fzf-native.nvim'
		},
		event = "CmdlineEnter",
		keys = {
			vim.keymap.set('n', '<leader>f/', ':Telescope lsp_dynamic_workspace_symbols<cr>'),
			vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<cr>'),
			vim.keymap.set('n', '<leader>fb', ':Telescope buffers<cr>'),
			vim.keymap.set('n', '<leader>ff', ':Telescope find_files<cr>'),
			vim.keymap.set('n', '<leader>fd', ':Telescope diagnostics<cr>'),
		},
		config = function()
			require("telescope").setup {
				defaults = {
					layout_strategy = 'flex',
					layout_config = {
						flex = { flip_columns = 160 }
					},
				},
			}
			require('telescope').load_extension('fzf')
		end
	},
	{
		'kevinhwang91/nvim-bqf',
		ft = 'qf'
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
			tabout = { enable = true, hopout = true }
		},
	},

	-- Eye candy UI
	{
		"NvChad/nvim-colorizer.lua",
		cmd = { "ColorizerAttachToBuffer",
			"ColorizerToggle"
		},
		event = "BufRead",
		config = function()
			require 'colorizer'.setup {
				filetypes = {
					'*',
					css = { rgb_fn = true, },
					html = { names = false, }
				},
			}
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
		'stevearc/dressing.nvim',
		event = "UIEnter"
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufEnter",
		keys = {
			-- View changed in git
			vim.keymap.set('n', ']c', function()
				if vim.wo.diff then return ']c' end
				vim.schedule(function()
					require("gitsigns").next_hunk()
				end)
				return '<Ignore>'
			end, { expr = true }),

			vim.keymap.set('n', '[c', function()
				if vim.wo.diff then return '[c' end
				vim.schedule(function()
					require("gitsigns").prev_hunk()
				end)
				return '<Ignore>'
			end, { expr = true }),

			vim.keymap.set("n", "<leader>hp",
				function() require("gitsigns").preview_hunk() end)
		},
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
		"sindrets/diffview.nvim",
		event = "CmdlineEnter"
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"nvim-telescope/telescope.nvim", -- optional
			"sindrets/diffview.nvim", -- optional
		},
		cmd = { "Neogit", "NeogitResetState" },
		opts = {
			disable_hint = true,
		},
	},
}

local vscode_plugins = {
	{
		"machakann/vim-sandwich",
		event = "BufEnter",
		keys = "s"
	},
	{
		"numToStr/Comment.nvim",
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
