--vim.keymap.set(<mode>, <key>, <action>, <opts>)

-- define common options
local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}

vim.g.mapleader = " "  -- sets leader to space

-----------------
-- Normal mode --
-----------------
-- Keymap: Ctrl+n to toggle Neo-tree (force override default behavior)
vim.api.nvim_set_keymap('n', '<C-n>', ":lua require('neo-tree.command').execute({ toggle = true, dir = vim.loop.cwd() })<CR>", { noremap = true, silent = true })

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Telescope keymaps (lazy-load safe)
do
  local ok, telescope_builtin = pcall(require, 'telescope.builtin')
  if ok then
    vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, opts)
    vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, opts)
    vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, opts)
    vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, opts)
  end
end

-- ToggleTerm keymap (lazy-load safe)
do
  local ok = pcall(require, 'toggleterm')
  if ok then
    vim.keymap.set('n', '<leader>tt', ':ToggleTerm<CR>', opts)
  end
end

-- Gitsigns keymaps (lazy-load safe)
do
  local ok, gitsigns = pcall(require, 'gitsigns')
  if ok then
    vim.keymap.set('n', ']g', gitsigns.next_hunk, opts)
    vim.keymap.set('n', '[g', gitsigns.prev_hunk, opts)
    vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk, opts)
    vim.keymap.set('n', '<leader>gr', gitsigns.reset_hunk, opts)
  end
end

-- DAP keymaps (lazy-load safe)
do
  local ok, dap = pcall(require, 'dap')
  if ok then
    vim.keymap.set('n', '<F5>', function() dap.continue() end, opts)
    vim.keymap.set('n', '<F10>', function() dap.step_over() end, opts)
    vim.keymap.set('n', '<F11>', function() dap.step_into() end, opts)
    vim.keymap.set('n', '<F12>', function() dap.step_out() end, opts)
    vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, opts)
    vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end, opts)
  end
end

-- DAP UI keymaps
pcall(function()
  local dapui = require('dapui')
  vim.keymap.set('n', '<leader>du', function() dapui.toggle() end, opts)
end)

-- Format with conform.nvim (lazy-load safe)
do
  local ok, conform = pcall(require, 'conform')
  if ok then
    vim.keymap.set('n', '<leader>fm', function() conform.format({ async = true, lsp_fallback = true }) end, opts)
  end
end

-- Which-key (lazy-load safe)
do
  local ok = pcall(require, 'which-key')
  if ok then
    vim.keymap.set('n', '<leader>wk', ':WhichKey<CR>', opts)
  end
end

-- Lazy.nvim (lazy-load safe)
do
  local ok = pcall(require, 'lazy')
  if ok then
    vim.keymap.set('n', '<leader>lz', ':Lazy<CR>', opts)
  end
end

-- Buffer navigation
vim.keymap.set('n', '<S-l>', ":bnext<CR>", opts)
vim.keymap.set('n', '<S-h>', ":bprevious<CR>", opts)
vim.keymap.set('n', '<leader>bd', ":bdelete<CR>", opts)

-- Quick save/quit
vim.keymap.set('n', '<leader>w', ":w<CR>", opts)
vim.keymap.set('n', '<leader>q', ":q<CR>", opts)

-- Window management
vim.keymap.set('n', '<leader>sv', ":vsplit<CR>", opts)
vim.keymap.set('n', '<leader>sh', ":split<CR>", opts)
vim.keymap.set('n', '<leader>se', ":wincmd =<CR>", opts)
vim.keymap.set('n', '<leader>sx', ":close<CR>", opts)

-- Toggle colorizer
vim.keymap.set('n', '<leader>cc', ":ColorizerToggle<CR>", opts)

-- Toggle bufferline pick mode
vim.keymap.set('n', '<leader>bp', ":BufferLinePick<CR>", opts)

-- Toggle dashboard
vim.keymap.set('n', '<leader>db', ":Alpha<CR>", opts)

-- Harpoon keymaps
pcall(function()
  local harpoon = require('harpoon')
  vim.keymap.set('n', '<leader>ha', function() harpoon:list():append() end, opts)
  vim.keymap.set('n', '<leader>hm', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, opts)
  vim.keymap.set('n', '<leader>hn', function() harpoon:list():select(1) end, opts)
end)

-- Trouble keymaps
vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', opts)
vim.keymap.set('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', opts)
vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', opts)
vim.keymap.set('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', opts)
vim.keymap.set('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>', opts)

-- Neotest keymaps
pcall(function()
  local neotest = require('neotest')
  vim.keymap.set('n', '<leader>tn', function() neotest.run.run() end, opts)
  vim.keymap.set('n', '<leader>tf', function() neotest.run.run(vim.fn.expand('%')) end, opts)
  vim.keymap.set('n', '<leader>ts', function() neotest.summary.toggle() end, opts)
end)

-- TODO comments
vim.keymap.set('n', '<leader>td', '<cmd>TodoTrouble<cr>', opts)
vim.keymap.set('n', '<leader>tq', '<cmd>TodoQuickFix<cr>', opts)

-- Fugitive keymaps
vim.keymap.set('n', '<leader>gs', '<cmd>Git<cr>', opts)

-- Diffview keymaps
vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<cr>', opts)

-- Markdown preview
vim.keymap.set('n', '<leader>mp', '<cmd>MarkdownPreviewToggle<cr>', opts)

-- Session management
vim.keymap.set('n', '<leader>ss', '<cmd>SessionSave<cr>', opts)
vim.keymap.set('n', '<leader>sr', '<cmd>SessionRestore<cr>', opts)

-- Spectre keymaps
vim.keymap.set('n', '<leader>sr', "<cmd>lua require('spectre').open()<CR>", opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)


