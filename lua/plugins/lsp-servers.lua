-- Reference :h lspconfig-all
-- Lua
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
-- Clang
vim.lsp.enable("clangd")
-- Python
vim.lsp.enable('ty')
vim.lsp.enable('ruff')
-- Arduino
vim.lsp.enable("arduino_language_server")
