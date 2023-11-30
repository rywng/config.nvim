-- CORE SETTINGS
local o = vim.o
local global = vim.g

-- look and feel
o.number = true
o.relativenumber = true
o.ruler = true
o.scrolloff = 10
o.showmode = false
o.spell = true
global.netrw_bufsettings = "noma nomod relativenumber nowrap ro nobl"

-- controlling
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
o.autoindent = true
o.ignorecase = true
o.smartcase = true
o.smartindent = true

-- leader settings
global.mapleader = ' '

-- env settings for plugins
global.tagbar_sort = 0
