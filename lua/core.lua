-- Core Settings

local opt = vim.o

-- look and feel
opt.relativenumber = true
opt.number = true
opt.showmode = false
opt.scrolloff = 10
opt.ruler = true
opt.termguicolors = true
opt.shiftwidth = 2

-- controlling
opt.ignorecase = true
opt.smartcase = true
opt.smartindent = true
opt.mouse = "i"

-- completion for lua
opt.completeopt = 'menuone,noselect'
