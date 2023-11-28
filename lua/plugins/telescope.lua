local trouble = require("trouble.providers.telescope")


require('telescope').setup {
	defaults = { layout_strategy = 'vertical',
		layout_config = { height = 0.95 },
		mappings = {
			i = { ["<c-t>"] = trouble.open_with_trouble },
			n = { ["<c-t>"] = trouble.open_with_trouble },
		},
	},
}
