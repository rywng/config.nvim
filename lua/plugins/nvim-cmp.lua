local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- For some reason using vim.snippet work but I will play it safe.
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		["<C-n>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end),
		["<C-p>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end),
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<C-y>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({
					select = true,
				})
			else
				fallback()
			end
		end),

		['<C-l>'] = cmp.mapping(function(fallback)
			if luasnip.locally_jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		['<C-h>'] = cmp.mapping(function(fallback)
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		{ name = "async_path" },
		{ name = "luasnip" }, -- For luasnip users.
		{ name = "nvim_lsp" },
		{ name = 'buffer' },
		{ name = 'nvim_lua' },
	}),
	completion = {
		completeopt = 'menu,menuone,noinsert,noselect'
	}
})

cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	completion = {
		completeopt = 'menu,menuone,noselect'
	},
	sources = {
		{ name = 'buffer' }
	},
})

-- `:` cmdline setup.
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	completion = {
		completeopt = 'menu,menuone,noselect'
	},
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{
			name = 'cmdline',
			option = {
				ignore_cmds = {}
			}
		}
	})
})
