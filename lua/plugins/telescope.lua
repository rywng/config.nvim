local trouble = require("trouble.providers.telescope")


require('telescope').setup {
	defaults = { layout_strategy = 'flex',
		layout_config = { flex = { flip_columns = 144 } },
		mappings = {
			i = { ["<c-t>"] = trouble.open_with_trouble },
			n = { ["<c-t>"] = trouble.open_with_trouble },
		},
	},
}
