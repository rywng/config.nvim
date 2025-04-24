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
		config = function()
			require("mini.surround").setup()
		end,
	},

	-- TS, LSP, Completion
	{

		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins.treesitter")
		end,
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			{
				"andymass/vim-matchup",
				keys = {
					vim.keymap.set("n", "<leader>", ":MatchupWhereAmI<cr>", { silent = true }),
				},
			},
		},
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
			{
				"brunotvs/mason-lspconfig.nvim",
				"williamboman/mason.nvim",
				"jay-babu/mason-null-ls.nvim",
				"saghen/blink.cmp",
			},
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugins.lsp") -- Contains lsp keys
		end,
	},
	{
		"williamboman/mason.nvim",
		event = "CmdlineEnter",
		opts = { ui = { icons = { package_installed = "✓" } } },
	},
	{
		"jay-babu/mason-null-ls.nvim",
		config = function()
			require("plugins.null-ls")
		end,
		dependencies = {
			"nvimtools/none-ls.nvim",
		},
	},

	-- Code editing
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		cmd = "Neogen",
		opts = {},
	},
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
				"cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
			},
		},
		event = "CmdlineEnter",
		keys = {
			vim.keymap.set("n", "<leader>f?", ":Telescope lsp_dynamic_workspace_symbols<cr>"),
			vim.keymap.set("n", "<leader>f/", ":Telescope lsp_document_symbols<cr>"),
			vim.keymap.set("n", "<leader>fb", ":Telescope buffers<cr>"),
			vim.keymap.set("n", "<leader>fd", ":Telescope diagnostics<cr>"),
			vim.keymap.set("n", "<leader>ff", ":Telescope find_files<cr>"),
			vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<cr>"),
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
			-- load fzf
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		opts = {
			-- disable fugitive in preview: https://github.com/kevinhwang91/nvim-bqf?tab=readme-ov-file#customize-configuration
			preview = {
				should_preview_cb = function(bufnr)
					local ret = true
					local bufname = vim.api.nvim_buf_get_name(bufnr)
					local fsize = vim.fn.getfsize(bufname)
					if fsize > 100 * 1024 or bufname:match("^fugitive://") then
						-- skip fugitive buffer and large buffer
						ret = false
					end
					return ret
				end,
			},
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		event = "VeryLazy",
		config = function()
			require("plugins.neo-tree")
		end,
	},

	-- Eye candy UI
	{
		"NvChad/nvim-colorizer.lua",
		cmd = { "ColorizerAttachToBuffer", "ColorizerToggle" },
		event = "VeryLazy",
		config = function()
			require("colorizer").setup({
				filetypes = {
					"*",
					css = { rgb_fn = true },
					html = { names = false },
				},
			})
		end,
	},
	{
		"tpope/vim-fugitive",
		event = "CmdlineEnter",
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
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
		"zapling/mason-lock.nvim",
		event = "CmdlineEnter",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lock").setup({
				lockfile_path = vim.fn.stdpath("config") .. "/mason-lock.json", -- (default)
			})
		end,
	},
	{
		"seandewar/killersheep.nvim",
		cmd = "KillKillKill",
	},
}

local vscode_plugins = {
	{ "echasnovski/mini.surround", version = false, lazy = false },
}

if vim.g.vscode then
	-- VSCode extension
	require("lazy").setup(vscode_plugins, opts)
else
	-- ordinary Neovim
	require("lazy").setup(plugins, opts)
end
