-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

require('packer').init {
    opt_default = true,
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
    --    auto_reload_compiled = true
}

return require('packer').startup(function(use)
    use {'wbthomason/packer.nvim', event = 'VimEnter'}

    -- core UI
    use {'kyazdani42/nvim-web-devicons', after = 'packer.nvim'}
    use {
        'hoob3rt/lualine.nvim',
        after = 'nvim-web-devicons',
        config = function() require "plugins.statusline" end
    }
    use {
        'RRethy/nvim-base16',
        event = 'VimEnter',
        config = function() require "plugins.base16" end
    }

    -- lsp stuff
    use {
        'nvim-treesitter/nvim-treesitter',
        event = 'BufRead',
        config = function() require "plugins.treesitter" end,
        run = ':TSUpdate'
    }
    use {'neovim/nvim-lspconfig', event = 'BufRead'}
    use {
        'kabouzeid/nvim-lspinstall',
        after = 'nvim-lspconfig',
        config = function() require "plugins.lspinstall" end
    }
    use {'onsails/lspkind-nvim', after = 'nvim-lspconfig'}
    use {"ray-x/lsp_signature.nvim", after = 'nvim-lspconfig'}
    -- packer
    use {
        'ms-jpq/coq_nvim',
        branch = 'coq',
        requires = {'ms-jpq/coq.artifacts', branch = 'artifacts'}
    }

    -- formating and editing
    use {"sbdchd/neoformat", cmd = "Neoformat"}
    use {
        "mattn/emmet-vim",
        event = "FileType html,css",
        setup = function() require "plugins.emmet" end
    }
    use {"machakann/vim-sandwich", event = "BufRead"}

    -- navigation
    use {
        'kyazdani42/nvim-tree.lua',
        cmd = 'NvimTreeToggle',
        requires = 'kyazdani42/nvim-web-devicons'
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

    -- eye-candy
    use {
        'sunjon/shade.nvim',
        event = "BufAdd",
        config = function() require "plugins.shade" end
    }
    use {
        "lukas-reineke/indent-blankline.nvim",
        after = {"nvim-treesitter","nvim-base16"},
        config = function() require "plugins.indent-blankline" end
    }

end)
