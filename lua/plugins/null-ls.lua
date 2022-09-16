local null_ls = require("null-ls")

-- builtins
-- local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local hover = null_ls.builtins.hover
local completion = null_ls.builtins.completion

local sources = {
	code_actions,
	diagnostics,
	formatting,
	hover,
	completion
}

null_ls.setup({ sources = sources })
