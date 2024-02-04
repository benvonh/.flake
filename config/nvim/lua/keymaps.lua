vim.g.mapleader = ' '

local function remap(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { silent = true, noremap = true })
end

remap('i', '<c-c>', '<esc>')
remap('n', 'n', 'nzz')
remap('n', 'N', 'Nzz')
remap('n', '<c-u>', '<c-u>zz')
remap('n', '<c-d>', '<c-d>zz')
remap('n', 'H', '<cmd>bprev<cr>')
remap('n', 'L', '<cmd>bnext<cr>')
remap('n', '<a-h>', '<c-w>H')
remap('n', '<a-j>', '<c-w>J')
remap('n', '<a-k>', '<c-w>K')
remap('n', '<a-l>', '<c-w>L')
remap('v', 'p', '"_dP')
remap('v', '<', '<gv')
remap('v', '>', '>gv')
remap('v', 'J', ':m \'>+1<cr>gv=gv')
remap('v', 'K', ':m \'<-2<cr>gv=gv')
remap({ 'n', 'v' }, '<leader>y', '"+y')
remap({ 'n', 'v' }, '<leader>Y', '"+Y')
remap({ 'n', 'v' }, '<leader>d', '"_d')
remap({ 'n', 'v' }, '<leader>D', '"_D')
