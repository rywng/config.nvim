require('gitsigns').setup {
    -- signs
    status_formatter = nil, -- Use default
    numhl = false,
    sign_priority = 10,
		attach_to_untracked = false, -- fix gitsigns with yadm in ~
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
    -- yadm = {enable = true},

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
