-- Reference :h lspconfig-all
-- Lua
vim.lsp.config['lua_ls'] = {
	-- Command and arguments to start the server.
	cmd = { 'lua-language-server' },
	-- Filetypes to automatically attach to.
	filetypes = { 'lua' },
	-- Sets the "workspace" to the directory where any of these files is found.
	-- Files that share a root directory will reuse the LSP server connection.
	-- Nested lists indicate equal priority, see |vim.lsp.Config|.
	root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
	-- Specific settings to send to the server. The schema is server-defined.
	-- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			}
		}
	}
}
vim.lsp.enable('lua_ls')
-- Rust
vim.lsp.enable("rust_analyzer")
-- Nix
vim.lsp.config("nil_ls", {
	settings = {
		['nil'] = {
			formatting = {
				command = { "alejandra" },
			},
		},
	},
})
vim.lsp.enable("nil_ls")
-- Toml
vim.lsp.enable("taplo")
-- Clang
vim.lsp.enable("clangd")
