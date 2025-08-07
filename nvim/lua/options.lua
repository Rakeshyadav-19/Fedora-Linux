-- Hint: use `:h <option>` to figure out the meaning if needed
vim.opt.clipboard = 'unnamedplus'   -- use system clipboard 
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.mouse = 'a'                 -- enable mouse support

-- Tab
vim.opt.tabstop = 4                 -- number of visual spaces per TAB
vim.opt.softtabstop = 4             -- number of spacesin tab when editing
vim.opt.shiftwidth = 4              -- insert 4 spaces on a tab
vim.opt.expandtab = true            -- tabs are spaces, mainly because of python

-- UI config
vim.opt.termguicolors = true        -- true color support
vim.opt.relativenumber = true       -- relative line numbers
vim.opt.number = true               -- absolute line numbers
vim.opt.cursorline = true           -- highlight current line
vim.opt.splitbelow = true           -- horizontal splits below
vim.opt.splitright = true           -- vertical splits to the right
vim.opt.scrolloff = 8               -- keep 8 lines above/below cursor
vim.opt.sidescrolloff = 8           -- keep 8 columns left/right of cursor
vim.opt.updatetime = 300            -- faster completion
vim.opt.timeoutlen = 400            -- faster which-key response
vim.opt.signcolumn = 'yes'          -- always show signcolumn
vim.opt.undofile = true             -- persistent undo
vim.opt.showmode = false            -- don't show -- INSERT --

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
