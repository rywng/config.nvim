require("indent_blankline").setup {
    buftype_exclude = {"terminal", "help","packer"},
    indent_blankline_buftype_exclude = {"terminal"},
    indentLine_enabled = 1,
    indent_blankline_char = "▏",
    show_current_context = true,
    indent_blankline_show_trailing_blankline_indent = false,
    indent_blankline_show_first_indent_level = false
}
