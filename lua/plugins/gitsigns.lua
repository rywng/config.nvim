require('gitsigns').setup {
    keymaps = {
        -- Default keymap options
        buffer = true,
        noremap = true,
        ["n ]c"] = {
            expr = true,
            "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"
        },
        ["n [c"] = {
            expr = true,
            "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"
        },
        ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line()<CR>'
    },

    -- signs
    status_formatter = nil, -- Use default
    numhl = false,
    sign_priority = 10,
    signs = {
        add = {hl = "DiffAdd", text = "+", numhl = "GitSignsAddNr"},
        change = {hl = "DiffChange", text = ">", numhl = "GitSignsChangeNr"},
        changedelete = {
            hl = "DiffChange",
            text = "~",
            numhl = "GitSignsChangeNr"
        },
        delete = {hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr"},
        topdelete = {
            hl = "DiffDelete",
            text = "‾",
            numhl = "GitSignsDeleteNr"
        }
    },
    yadm = {enable = true},

    -- Current line blame
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 250,
        ignore_whitespace = false
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>'
}
