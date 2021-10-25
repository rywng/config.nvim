require("indent_blankline").setup {
    buftype_exclude = {"terminal", "help", "packer"},
    char = "▏",
    space_char_blankline = ' ',
    max_indent_increase = 2,
    show_first_indent_level = false,
    show_trailing_blankline_indent = false,
		use_treesitter = true
}
