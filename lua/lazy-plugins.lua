local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		"--depth=1",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local opts = {
	defaults = {
		lazy = true,
	},
	dev = {
		path = "~/.local/src",
	},
	install = {
		-- try to load one of these colorschemes when starting an installation during startup
		colorscheme = { "gruvbox-material", "habamax" },
	},
	performance = {
		rtp = {
			paths = { "/usr/share/vim/vimfiles" },
		},
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
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugins.statusline")
		end,
		event = "UIEnter",
	},

	-- QoL Mini Plugin
	{
		"echasnovski/mini.surround",
		event = "ModeChanged",
		keys = "s",
		opts = {}
	},

	-- TS, LSP, Completion
	{
		"andymass/vim-matchup",
		lazy = false, -- This only works with lazy = false. It's 3ms more to the loading time.
		keys = {
			vim.keymap.set("n", "<leader>", ":MatchupWhereAmI<cr>", { silent = true }),
		},
		opts = {
			treesitter = {
				stopline = 500,
			}
		}
	},
	{
		"saghen/blink.cmp",
		event = { "InsertEnter", "CmdlineEnter", "CmdwinEnter" },
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		config = function()
			require("plugins.blink-cmp")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
			"nvimtools/none-ls.nvim",
		},
		event = "VeryLazy",
		config = function()
			require("plugins.lsp") -- Contains lsp keys
			require("plugins.lsp-servers")
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("plugins.null-ls")
		end,
	},

	-- Code editing
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
			ts_config = {
				lua = { "string" },
				javascript = { "template_string" },
				java = false,
			},
		},
	},

	-- Navigation
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-ui-select.nvim",
			},
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build =
				'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install'
			},
			dependencies = { "nvim-tree/nvim-web-devicons" },
		},
		event = "CmdlineEnter",
		keys = {
			vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<cr>"),
			vim.keymap.set("n", "<leader>fb", ":Telescope buffers<cr>"),
			vim.keymap.set("n", "<leader>ff", ":Telescope find_files<cr>"),
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
				defaults = {
					layout_strategy = "flex",
					layout_config = {
						flex = { flip_columns = 160 },
					},
				},
			})
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("ui-select") -- make nvim's ui_select use telescope, like code actions
		end,
	},

	-- Eye candy UI
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("plugins.gitsigns")
		end
	},

	-- misc and games
	{
		"seandewar/killersheep.nvim",
		cmd = "KillKillKill",
	},
}

-- ordinary Neovim
require("lazy").setup(plugins, opts)
