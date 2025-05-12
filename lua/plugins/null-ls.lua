local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.code_actions.gitsigns,
		function()
			if vim.fn.executable("dx") == 1 then
				return null_ls.builtins.formatting.dxfmt
			end
		end,
	},
})
