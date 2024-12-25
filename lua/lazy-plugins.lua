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
	-- The dependency is a mess, I might try to fix them sometime
	{

		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins.treesitter")
		end,
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"andymass/vim-matchup",
		}
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip").setup()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_vscode").load({ paths = "./snippets" }) -- relative to the directory of $MYVIMRC
			require("luasnip").filetype_extend("htmldjango", { "html" })
			require("luasnip").filetype_extend("lua", { "luadoc" })
			require("luasnip").filetype_extend("python", { "pydoc" })
			require("luasnip").filetype_extend("rust", { "rustdoc" })
			require("luasnip").filetype_extend("java", { "javadoc" })
			require("luasnip").filetype_extend("c", { "cdoc" })
			require("luasnip").filetype_extend("cpp", { "cppdoc" })
			require("luasnip").filetype_extend("sh", { "shelldoc" })
		end,
		-- install jsregexp (optional!).
		build = "gmake install_jsregexp"
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
		dependencies = {
			"neovim/nvim-lspconfig",
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
				"williamboman/mason.nvim",
			},
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.lsp") -- Contains lsp keys
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
		dependencies = {
			"neovim/nvim-lspconfig"
		},
		config = function()
			vim.keymap.set('n', '<leader>rr', ':RustLsp runnables<cr>')
			-- Override some of generic lsp's actions
			vim.keymap.set('n', '<leader>e', ":RustLsp renderDiagnostic current<cr>")
		end
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
		"nvim-telescope/telescope.nvim",
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }
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
			-- load fzf
			require('telescope').load_extension('fzf')
		end
	},
	{
		'kevinhwang91/nvim-bqf',
		ft = 'qf',
		opts = {
			-- disable fugitive in preview: https://github.com/kevinhwang91/nvim-bqf?tab=readme-ov-file#customize-configuration
			preview = {
				should_preview_cb = function(bufnr)
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
		event = "VeryLazy",
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
		'stevearc/dressing.nvim',
		event = "VeryLazy"
	},
	{
		"tpope/vim-fugitive",
		event = "CmdlineEnter"
	},
	{
		"hedyhli/outline.nvim",
		cmd = { "Outline", "OutlineOpen" },
		keys = {
			vim.keymap.set('n', 'gO', ':Outline<cr>'),
		},
		config = function()
			require("outline").setup({
				preview_window = {
					auto_preview = true,
				},
				keymaps = {
					peek_location = {},
					goto_and_close = 'o'
				}
			})
		end
	},
	{
		"lewis6991/gitsigns.nvim",
		event = 'VeryLazy',
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
		'vyfor/cord.nvim',
		build = './build || .\\build',
		event = 'VeryLazy',
		opts = {
			display = {
				show_cursor_position = true,
			},
			text = {
				workspace = string.format('On %s %s', vim.uv.os_uname().sysname,
					vim.uv.os_uname().release),
				-- workspace = 'On '.. vim.uv.os_uname().sysname .. " " .. vim.uv.os_uname().release,
			}
		},
	}
}

local vscode_plugins = {
	{ 'echasnovski/mini.surround', version = false, lazy = false },
}

if vim.g.vscode then
	-- VSCode extension
	require("lazy").setup(vscode_plugins, opts)
else
	-- ordinary Neovim
	require("lazy").setup(plugins, opts)
end
