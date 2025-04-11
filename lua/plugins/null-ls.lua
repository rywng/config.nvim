require("mason-null-ls").setup({
	ensure_installed = {},
	automatic_installation = false,
	handlers = {},
})

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.code_actions.gitsigns,
		null_ls.builtins.formatting.dxfmt,
	},
})
