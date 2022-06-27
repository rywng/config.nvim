-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require'nvim-tree'.setup {
    disable_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {},
    open_on_tab = true,
    hijack_cursor = true,
    hijack_directories = {enable = true, auto_open = true},
    hijack_netrw = true,
    update_cwd = true,
    diagnostics = {
        enable = true,
        icons = {hint = "", info = "", warning = "", error = ""}
    },
    system_open = {cmd = nil, args = {}},
    view = {
        width = 30,
        height = 30,
        hide_root_folder = false,
        side = 'left',
    }
}

