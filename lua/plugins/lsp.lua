local builtin = require("telescope.builtin")

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Buffer local mappings. See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "<leader>fm", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
		-- see :h lsp-defaults. Use telescope for handling these.
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
		vim.keymap.set("n", "gri", builtin.lsp_implementations)
		vim.keymap.set("n", "grr", builtin.lsp_references, opts)
		vim.keymap.set("n", "grt", builtin.lsp_type_definitions, opts)
		-- Custom telescope stuff
		vim.keymap.set("n", "<leader>f/", builtin.lsp_dynamic_workspace_symbols, opts)
		vim.keymap.set("n", "<leader>f?", builtin.lsp_document_symbols, opts)
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, opts)
		-- Inlay hint
		vim.keymap.set("n", "gih", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end)
		-- Also enable signature help for more mods
		vim.keymap.set({ "n", "i", "s" }, "<C-s>", vim.lsp.buf.signature_help, opts)
	end,
})

vim.diagnostic.config({
	virtual_lines = {
		severity = vim.diagnostic.severity.ERROR

	},
	virtual_text = {
		severity = {
			max = vim.diagnostic.severity.WARN
		}
	},
	jump = {
		float = true
	}
})
