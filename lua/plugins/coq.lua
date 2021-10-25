vim.g.coq_settings = {
    keymap = {recommended = false, pre_select = true},
    auto_start = true,
    clients = {tabnine = {enabled = true}},
    display = {ghost_text = {enabled = false}, icons = {mode = "none"}}
}
vim.cmd('COQnow -s')
