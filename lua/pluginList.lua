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
    compile_on_sync = true
    --		auto_reload_compiled = true
}

return require('packer').startup(function(use)
    use {'wbthomason/packer.nvim', event = 'VimEnter'}

    -- core UI
    use {'kyazdani42/nvim-web-devicons', after = 'packer.nvim'}
    use {
        'hoob3rt/lualine.nvim',
        after = {'nvim-web-devicons', 'nvim-base16'},
        config = function() require "plugins.statusline" end
    }
    use {
        'RRethy/nvim-base16',
        after = 'packer.nvim',
        config = function() require "plugins.base16" end
    }

    -- lsp stuff
    use {'neovim/nvim-lspconfig', event = "BufEnter"}
    use {
        'williamboman/nvim-lsp-installer',
        config = function() require "plugins.lspinstall" end,
        after = 'nvim-lspconfig'
    }

    -- tree sitter
    use {
        'nvim-treesitter/nvim-treesitter',
        event = "VimEnter",
        config = function() require "plugins.treesitter" end,
        run = ':TSUpdate'
    }
    use {
        'lewis6991/spellsitter.nvim',
        after = "nvim-treesitter",
        config = function() require('spellsitter').setup() end
    }

    -- completer
    use {
        'ms-jpq/coq_nvim',
        branch = 'coq',
        after = 'nvim-lsp-installer',
        run = ':COQdeps',
        config = function() require "plugins.coq" end
    }
    -- use {
    --     'ms-jpq/coq.artifacts',
    --     run = ':COQdeps',
    --     after = 'coq_nvim',
    --     branch = 'artifacts'
    -- }
    use {
        'ms-jpq/coq.thirdparty',
        branch = '3p',
        after = 'coq_nvim',
        config = function()
            require("coq_3p") {
                {src = "nvimlua", short_name = "nLUA"}, {src = "repl"}
            }

        end
    }
    -- formating and editing
    use {"sbdchd/neoformat", cmd = "Neoformat"}
    use {
        "mattn/emmet-vim",
        event = "FileType html,css",
        setup = function() require "plugins.emmet" end
    }
    use {"machakann/vim-sandwich", event = "VimEnter"}

    use {
        "terrortylor/nvim-comment",
        config = function() require('nvim_comment').setup() end,
        cmd = "CommentToggle"
    }
    use {
        "windwp/nvim-autopairs",
        after = "coq_nvim",
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
        "vimwiki/vimwiki",
        cmd = "VimwikiIndex",
        setup = function() require "plugins.vimwiki" end
    }
    use {
        'andymass/vim-matchup',
        after = 'nvim-treesitter',
        config = function() require "plugins.matchup" end
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}},
        cmd = 'Telescope'
    }
    use {'preservim/tagbar', cmd = 'TagbarToggle'}
    use {
        'phaazon/hop.nvim',
        event = "VimEnter",
        as = 'hop',
        config = function()
            require'hop'.setup {keys = 'etovxqpdygfblzhckisuran'}
        end
    }

    -- eye-candy
    use {
        "Pocco81/TrueZen.nvim",
        cmd = {'TZAtaraxis', 'TZFocus', 'TZMinimalist'},
        config = function() require "plugins.truezen" end
    }
    use {
        "lukas-reineke/indent-blankline.nvim",
        after = {"nvim-treesitter", "nvim-base16"},
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
        'winston0410/range-highlight.nvim',
        event = "CmdlineEnter",
        config = function() require("range-highlight").setup {} end,
        requires = 'winston0410/cmd-parser.nvim'
    }
    use {
        'norcalli/nvim-colorizer.lua',
        cmd = 'ColorizerToggle',
        config = function() require'colorizer'.setup() end
    }

    -- integrations
    use {"tpope/vim-fugitive", cmd = "G"}
end)
