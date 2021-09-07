local function setup_servers()
    require'lspinstall'.setup(coq.lsp_ensure_capabilities())
    local servers = require'lspinstall'.installed_servers()
    for _, server in pairs(servers) do require'lspconfig'[server].setup {} end
end


-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function()
    setup_servers() -- reload installed servers
    vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

-- setup coq.lua
local lsp = require 'lspconfig'
require("packer").loader("coq_nvim coq.artifacts")
vim.g.coq_settings = {auto_start = true, clients = {tabnine = {enabled = true}}}
local coq = require 'coq'
setup_servers()
lsp.gopls.setup(coq.lsp_ensure_capabilities({
    cmd = {"gopls", "serve"},
    settings = {gopls = {analyses = {unusedparams = true}, staticcheck = true}}
}))

-- load coq.lua
vim.cmd("COQnow -s")
