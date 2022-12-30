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
o.autoindent = true
o.mouse = "a"

-- leader settings
global.mapleader = ' '
