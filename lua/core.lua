-- Core Settings
local opt = vim.o
local global = vim.g

-- look and feel
vim.opt.shortmess:append({ I = true }) -- remove intro message
opt.relativenumber = true
opt.cursorline = true
opt.number = true
opt.showmode = false
opt.scrolloff = 10
opt.ruler = true
opt.termguicolors = true
opt.tabstop = 2
opt.shiftwidth = 2

-- controlling
opt.ignorecase = true
opt.smartcase = true
opt.smartindent = true
opt.mouse = "i"

-- completion for lua
opt.completeopt = 'noinsert'

-- neoformat settings.
global.neoformat_basic_format_align = 1
global.neoformat_basic_format_retab = 1
global.neoformat_basic_format_trim = 1

-- leader settings
global.mapleader = ' '
