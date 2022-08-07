-- CORE SETTINGS
local o = vim.o
local global = vim.g

-- look and feel
vim.opt.shortmess:append({I = true}) -- remove intro message
o.termguicolors = true
o.ruler = true
o.relativenumber = true
o.number = true
o.showmode = false
o.scrolloff = 10
o.softtabstop = 2
o.shiftwidth = 2

-- controlling
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
o.ignorecase = true
o.smartcase = true
o.smartindent = true
o.mouse = "i"
o.autoindent = true

-- neoformat settings.
global.neoformat_basic_format_align = 1
global.neoformat_basic_format_trim = 1

-- leader settings
global.mapleader = ' '

-- indent blankline settings
global.indent_blankline_char = '▏'
