-- Keymaps
local set = vim.keymap.set
vim.g.mapleader = " "

--for naviagting in split windows
set('i', 'jj', '<Esc><CR>')
set('n', '<c-h>', '<c-w>h')
set('n', '<c-j>', '<c-w>j')
set('n', '<c-k>', '<c-w>k')
set('n', '<c-l>', '<c-w>l')

--for splitting the window
set('n', '<leader>v', '<c-w>v')
set('n', '<leader>s', '<c-w>s')
set('n', '<leader>c', '<c-w>c')
set('n', '<leader>o', '<c-w>o')

--clear search highlight
set('n', '<leader>\\', ':nohlsearch<CR>')

--Sexplore, explore, and Vexplore
set("n", "<leader>pv", vim.cmd.Vex)
