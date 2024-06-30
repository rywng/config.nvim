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
			vim.g.gruvbox_material_enable_italic = true
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
			"FelipeLema/cmp-async-path",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
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

	-- Code editing
	{
		"echasnovski/mini.surround",
		event = "ModeChanged",
		keys = "s",
		config = function()
			require('mini.surround').setup()
		end
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
			vim.keymap.set('n', '<leader>f?', ':Telescope lsp_document_symbols<cr>'),
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
		ft = 'qf',
		opts = {
			-- disable fugitive in preview: https://github.com/kevinhwang91/nvim-bqf?tab=readme-ov-file#customize-configuration
			preview = {
				should_preview_cb = function(bufnr, qwinid)
					local ret = true
					local bufname = vim.api.nvim_buf_get_name(bufnr)
					local fsize = vim.fn.getfsize(bufname)
					if fsize > 100 * 1024 then
						-- skip file size greater than 100k
						ret = false
					elseif bufname:match('^fugitive://') then
						-- skip fugitive buffer
						ret = false
					end
					return ret
				end
			},
		}
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
		'abecodes/tabout.nvim',
		event = 'InsertCharPre',
		opts = {
			tabkey = '<C-l>',
			backwards_tabkey = '<C-h>',
			act_as_tab = false
		},
	},
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true,
		opts = {
			check_ts = true,
			ts_config = {
				lua = { 'string' },
				javascript = { 'template_string' },
				java = false,
			}
		}
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
		'stevearc/dressing.nvim',
		event = "UIEnter"
	},
	{
		"tpope/vim-fugitive",
		event = "CmdlineEnter"
	},
	{
		"hedyhli/outline.nvim",
		cmd = { "Outline", "OutlineOpen" },
		keys = {
			vim.keymap.set('n', '<leader>o', ':Outline<cr>'),
		},
		config = function()
			require("outline").setup({})
		end
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
}

local vscode_plugins = {
	{ 'echasnovski/mini.surround', version = false, lazy = false },
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
