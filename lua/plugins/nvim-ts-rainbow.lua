require'nvim-treesitter.configs'.setup {
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = 4096, -- Do not enable for files with more than n lines, int
        colors = { "#84a0c6", "#a093c7", "#89b8c2"}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    }
}

