require("blink.cmp").setup({
	fuzzy = { implementation = "prefer_rust" },
	sources = {
		providers = {
			path = {
				opts = {
					get_cwd = function(_)
						local clients = vim.lsp.get_clients({ bufnr = vim.api
						.nvim_get_current_buf() })
						if next(clients) == nil then
							return vim.fn.getcwd()
						else
							return clients[1]["root_dir"]
						end
					end,
				},
			},
		},
	},
})
