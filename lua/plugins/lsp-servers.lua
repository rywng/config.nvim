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
-- Toml
vim.lsp.enable("taplo")
-- Clang
vim.lsp.enable("clangd")
-- Python
vim.lsp.enable('ty')
vim.lsp.enable('ruff')
