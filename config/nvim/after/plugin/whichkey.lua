wk = require('which-key')

wk.register({
	-- basic commands
    ['<leader>q'] = { '<cmd>q<cr>', 'Quit buffer' },
    ['<leader>w'] = { '<cmd>w<cr>', 'Write buffer' },
    ['<leader>x'] = { '<cmd>x<cr>', 'Write & Quit buffer'},
    ['<leader>v'] = { '<cmd>vsplit<cr>', 'Split pane vertically' },
    ['<leader>r'] = { '<cmd>bp<bar>sp<bar>bn<bar>bd<cr>', 'Remove buffer' },
    ['<leader>'] = {
        z = {
            name = 'Neovim',
            z = { '<cmd>qa<cr>', 'Quit' },
            x = { '<cmd>wa<cr>', 'Save' },
            c = { '<cmd>xa<cr>', 'Save & Quit' }
        }
    },
	-- plugin commands
    ['<leader>e'] = { '<cmd>NvimTreeToggle<cr>', 'Toggle explorer' },
    ['<leader>l'] = { '<cmd>Telescope live_grep<cr>', 'Search word' },
    ['<leader>f'] = { '<cmd>Telescope find_files<cr>', 'Search file' },
	['<leader>p'] = {
		function()
			vim.ui.input(
				{ prompt = 'Search in: ' },
				function(input)
                    if input ~= nil then
					    vim.cmd('Telescope find_files cwd=' .. input)
                    end
				end
			)
		end, 'Search file from path'
	}
})
