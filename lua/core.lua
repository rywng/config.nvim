-- CORE SETTINGS
local o = vim.o
local global = vim.g

-- look and feel
o.termguicolors = true
o.ruler = true
o.relativenumber = true
o.number = true
o.showmode = false
o.scrolloff = 10

-- controlling
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
o.ignorecase = true
o.smartcase = true
o.smartindent = true
o.autoindent = true
o.mouse = "i"

-- leader settings
global.mapleader = ' '
