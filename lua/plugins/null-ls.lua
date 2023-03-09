require("mason").setup()
require("mason-null-ls").setup({
    automatic_installation = false,
    automatic_setup = true, -- Recommended, but optional
})
require("null-ls").setup({
    sources = {
        -- Anything not supported by mason.
    }
})

require 'mason-null-ls'.setup_handlers() -- If `automatic_setup` is true.
