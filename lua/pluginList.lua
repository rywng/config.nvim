-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

require('packer').init {
    display = {
        open_fn = function()
            return require("packer.util").float {border = "single"}
        end,
        prompt_border = "single"
    },
    git = {
        clone_timeout = 600 -- Timeout, in seconds, for git clones
    },
    auto_clean = true,
    compile_on_sync = true,
    auto_reload_compiled = true
}

return require('packer').startup(function(use)
    use {'wbthomason/packer.nvim', event = "VimEnter"}

    -- core UI
    use {
        'b4skyx/serenade',
        after = 'packer.nvim',
        config = function()
            vim.g.serenade_enable_italic = 1
            vim.g.serenade_sign_column_background = 'none'
            vim.g.serenade_better_performance = 1
            vim.cmd("colorscheme serenade")
        end
    }
    use {'kyazdani42/nvim-web-devicons', after = 'packer.nvim'}
    use {
        'nvim-lualine/lualine.nvim',
        after = {'serenade', 'nvim-web-devicons'},
        config = function() require "plugins.statusline" end
    }

    -- lsp stuff
    use {'neovim/nvim-lspconfig', event = "BufEnter"}
    use {
        'williamboman/nvim-lsp-installer',
        config = function() require "plugins.lspinstall" end,
        after = 'nvim-lspconfig'
    }
    use {
        "ray-x/lsp_signature.nvim",
        after = "nvim-lsp-installer",
        config = function() require "plugins.lsp_signature" end
    }

    -- tree sitter
    use {
        'nvim-treesitter/nvim-treesitter',
        event = "UIEnter",
        config = function() require "plugins.treesitter" end,
        run = ':TSUpdate'
    }

    -- completer
    use {
        'ms-jpq/coq_nvim',
        branch = 'coq',
        after = {'nvim-lsp-installer', 'zk-nvim'},
        run = ':COQdeps',
        config = function() require "plugins.coq" end
    }
    use {'ms-jpq/coq.artifacts', after = 'coq_nvim', branch = 'artifacts'}
    use {
        'ms-jpq/coq.thirdparty',
        branch = '3p',
        after = 'coq_nvim',
        config = function()
            require("coq_3p") {
                {src = "nvimlua", short_name = "nLUA"}, {src = "repl"},
                {src = "vimtex", short_name = "vTEX"}
            }

        end
    }

    -- formating and editing
    use {"sbdchd/neoformat", cmd = "Neoformat"}
    use {
        "mattn/emmet-vim",
        ft = {'html', 'htmldjango', 'css', 'markdown'},
        setup = function() require "plugins.emmet" end
    }
    use {"machakann/vim-sandwich", event = "BufEnter"}

    use {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    }
    use {
        "windwp/nvim-autopairs",
        event = "BufEnter",
        config = function() require("plugins.nvim-autopairs") end
    }

    -- navigation
    use {
        'kyazdani42/nvim-tree.lua',
        cmd = 'NvimTreeToggle',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require("plugins.nvim-tree") end
    }
    use {
        'andymass/vim-matchup',
        after = 'nvim-treesitter',
        config = function() require "plugins.matchup" end
    }
    use {
        'abecodes/tabout.nvim',
        config = function() require('tabout').setup {} end,
        after = {'nvim-treesitter', 'nvim-autopairs', 'coq_nvim'} -- if a completion plugin is using tabs load it before
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}},
        config = function() require "plugins.telescope" end,
        cmd = 'Telescope'
    }
    use {'preservim/tagbar', cmd = 'TagbarToggle'}
    use {
        'phaazon/hop.nvim',
        event = "UIEnter",
        as = 'hop',
        config = function()
            require'hop'.setup {keys = 'etovxqpdygfblzhckisuran'}
        end
    }

    -- eye-candy
    use {
        "lukas-reineke/indent-blankline.nvim",
        after = {"nvim-treesitter", "nvim-treesitter-context"},
        event = "UIEnter",
        config = function() require "plugins.indent-blankline" end
    }
    use {
        'lewis6991/gitsigns.nvim',
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require "plugins.gitsigns" end
    }
    use {
        'p00f/nvim-ts-rainbow',
        after = "nvim-treesitter",
        config = function() require "plugins.nvim-ts-rainbow" end
    }
    use {
        'nvim-treesitter/nvim-treesitter-context',
        after = "nvim-treesitter",
        config = function()
            require'treesitter-context'.setup {
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
                patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
                    -- For all filetypes
                    -- Note that setting an entry here replaces all other patterns for this entry.
                    -- By setting the 'default' entry below, you can control which nodes you want to
                    -- appear in the context window.
                    default = {
                        'class', 'function', 'method', 'for', -- These won't appear in the context
                        'while', 'if', 'switch', 'case'
                    }
                }
            }
        end
    }
    use {
        'winston0410/range-highlight.nvim',
        event = "CmdlineEnter",
        config = function() require("range-highlight").setup {} end,
        requires = 'winston0410/cmd-parser.nvim'
    }
    use {
        'norcalli/nvim-colorizer.lua',
        after = "packer.nvim",
        config = function() require "plugins.nvim-colorizer" end
    }

    -- integrations
    use {"tpope/vim-fugitive", cmd = "G"}
    use {
        "mickael-menu/zk-nvim",
        filetypes = {'markdown'},
        config = function() require "plugins.zk" end
    }

    -- fixes and misc. stuff
    use {"antoinemadec/FixCursorHold.nvim"}
end)
-- vim:set shiftwidth=4 tabstop=4:
