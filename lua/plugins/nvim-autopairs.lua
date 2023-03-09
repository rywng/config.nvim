local npairs = require("nvim-autopairs")

npairs.setup({
	map_bs = true,
	map_cr = true,
	map_c_w = true,
	enable_check_bracket_line = true,
	check_ts = true,
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
