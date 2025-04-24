-- Global mappings.
vim.keymap.set("n", "<leader>ih", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

local builtin = require('telescope.builtin')

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		-- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "<leader>fm", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
		vim.keymap.set("n", "grt", builtin.lsp_type_definitions, opts)
		vim.keymap.set("n", "gri", builtin.lsp_implementations, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)
		-- according to keymaps on latest https://neovim.io/doc/user/lsp.html#lsp-defaults
		vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "gra", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "grr", builtin.lsp_references, opts)
		vim.keymap.set({ "n", "i", "s" }, "<C-s>", vim.lsp.buf.signature_help, opts)
	end,
})

require("mason-lspconfig").setup({})
-- Dynamic loading of lsp servers
require("mason-lspconfig").setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- Default handler (optional)
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
		})
	end,

	["clangd"] = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		capabilities.offsetEncoding = { "utf-16" }
		require("lspconfig").clangd.setup({ capabilities = capabilities })
	end,

	["html"] = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		require("lspconfig").html.setup({
			filetypes = { "html", "htmldjango" },
			capabilities = capabilities,
		})
	end,
})

-- Customize lsp symbols
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = nil })
end
