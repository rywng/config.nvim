-- Reference :h lspconfig-all
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
-- Latex
vim.lsp.config("texlab", {
	settings = {
		['texlab'] = {
			build = {
				executable = "tectonic",
				args = { "-X",
					"compile",
					"%f",
					"--synctex",
					"--keep-logs",
					"--keep-intermediates" 
				},
				pdfDirectory= "build",
				auxDirectory= "build",
			},
			latexFormatter = "tex-fmt"
		}
	}
})
vim.lsp.enable("texlab")
