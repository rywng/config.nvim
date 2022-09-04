return require('packer').startup(function(use)
    use {'wbthomason/packer.nvim'}

    -- core UI
    use({
        'juancldcmt/sere-forest',
		branch = "dev",
        config = function()
            vim.g.everforest_better_performance = 1
            vim.cmd('colorscheme everforest')
        end
    })
    use {'kyazdani42/nvim-web-devicons'}
    use {
        'nvim-lualine/lualine.nvim',
        after = {'nvim-web-devicons'},
        config = function() require 'plugins.statusline' end
    }
    use {
        'romgrk/barbar.nvim',
        requires = {'kyazdani42/nvim-web-devicons'},
        event = 'BufAdd',
        after = {'nvim-web-devicons'},
        config = function() require 'plugins.barbar' end
    }

    -- lsp stuff
    use {'neovim/nvim-lspconfig', event = 'UIEnter'}
    use {
        'williamboman/nvim-lsp-installer',
        after = 'nvim-lspconfig',
        config = function() require 'plugins.lspinstall' end
    }
    use {'hrsh7th/cmp-nvim-lsp', after = 'nvim-lsp-installer'}
    use {
        'ray-x/lsp_signature.nvim',
        after = 'nvim-lsp-installer',
        config = function() require 'plugins.lsp-signature' end
    }

    -- tree sitter
    use {
        'nvim-treesitter/nvim-treesitter',
        event = 'UIEnter',
        config = function() require 'plugins.treesitter' end,
        run = ':TSUpdate'
    }

    -- completer
    use {'L3MON4D3/LuaSnip', event = 'UIEnter'}
    use {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        after = {'LuaSnip', 'cmp-nvim-lsp', 'nvim-treesitter'},
        config = function() require 'plugins.cmp' end,
        requires = {
            -- local
            {'hrsh7th/cmp-cmdline', after = 'nvim-cmp'},
            {'hrsh7th/cmp-buffer', after = 'nvim-cmp'},
            {'hrsh7th/cmp-path', after = 'nvim-cmp'}, {
                'petertriho/cmp-git',
                after = 'nvim-cmp',
                config = function() require("cmp_git").setup() end
            }, {'delphinus/cmp-ctags', after = 'nvim-cmp'}, -- end
            -- lsp
            {'hrsh7th/cmp-nvim-lsp-document-symbol', after = 'nvim-cmp'}, -- TS
            {'ray-x/cmp-treesitter', after = 'nvim-cmp'}, -- end
            -- Snip
            {'saadparwaiz1/cmp_luasnip', after = {'nvim-cmp', 'LuaSnip'}}
        }
    }

    -- formating and editing
    use {
        'windwp/nvim-autopairs',
        after = 'nvim-cmp',
        config = function() require('plugins.nvim-autopairs') end
    }
    use {'sbdchd/neoformat', cmd = 'Neoformat'}
    use {
        'mattn/emmet-vim',
        ft = {'html', 'htmldjango', 'css', 'markdown'},
        setup = function() require 'plugins.emmet' end
    }
    use {'machakann/vim-sandwich', event = 'UIEnter'}

    use {
        'numToStr/Comment.nvim',
        event = 'UIEnter',
        config = function() require('Comment').setup() end
    }

    -- navigation
    use {
        'kyazdani42/nvim-tree.lua',
        cmd = 'NvimTreeToggle',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function() require('plugins.nvim-tree') end
    }
    use {
        'andymass/vim-matchup',
        after = 'nvim-treesitter',
        config = function() require 'plugins.matchup' end
    }
    use {
        'abecodes/tabout.nvim',
        config = function() require('tabout').setup {} end,
        after = {'nvim-treesitter', 'nvim-autopairs', 'nvim-cmp'} -- if a completion plugin is using tabs load it before
    }
    use {
        'nvim-telescope/telescope.nvim',
        event = 'UIEnter',
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require 'plugins.telescope' end
    }
    use {'preservim/tagbar', cmd = 'TagbarToggle'}
    use {
        'phaazon/hop.nvim',
        event = 'UIEnter',
        as = 'hop',
        config = function()
            require'hop'.setup {keys = 'etovxqpdygfblzhckisuran'}
        end
    }

    -- eye-candy
    use {
        'lukas-reineke/indent-blankline.nvim',
        after = {'nvim-treesitter'},
        config = function() require 'plugins.indent-blankline' end
    }
    use {
        'lewis6991/gitsigns.nvim',
        event = 'UIEnter',
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require 'plugins.gitsigns' end
    }
    use {
        'p00f/nvim-ts-rainbow',
        after = 'nvim-treesitter',
        config = function() require 'plugins.nvim-ts-rainbow' end
    }
    use {
        'nvim-treesitter/nvim-treesitter-context',
        after = 'nvim-treesitter',
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
        event = 'CmdlineEnter',
        config = function() require('range-highlight').setup {} end,
        requires = 'winston0410/cmd-parser.nvim'
    }
    use {
        'norcalli/nvim-colorizer.lua',
        event = 'BufEnter',
        config = function() require 'plugins.nvim-colorizer' end
    }

    -- integrations
    use {'tpope/vim-fugitive', cmd = 'G'}
    use {
        'mickael-menu/zk-nvim',
        requires = {'nvim-telescope/telescope.nvim'},
        event = 'UIEnter',
        after = {'telescope.nvim'},
        ft = {'markdown'},
        config = function() require 'plugins.zk' end
    }

    -- fixes and misc. stuff
    use {'antoinemadec/FixCursorHold.nvim', event = 'UIEnter'}
end)
-- vim:set shiftwidth=4 tabstop=4:
