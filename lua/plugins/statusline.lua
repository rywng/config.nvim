require 'lualine'.setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = "", right = "|" },
		section_separators = "",
		disabled_filetypes = {}
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = {
			'branch',
		},
		lualine_c = {
			{ 'filename', path = 1 },
			'diff',
		},
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
	-- Tabline is broken, disable for now.
	-- tabline = {
	--     lualine_a = {'buffers'},
	--     lualine_b = {},
	--     lualine_c = {},
	--     lualine_x = {},
	--     lualine_y = {},
	--     lualine_z = {'tabs'}
	-- },
	extensions = {}
}
