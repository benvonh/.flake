local bufferline = require('bufferline')

bufferline.setup({
	options = {
		mode = 'buffers',
		style_preset = bufferline.style_preset.default,
		numbers = 'none',
		close_command = 'bdelete! %d',
		right_mouse_command = 'bdelete! %d',
		left_mouse_command = 'buffer %d',
		middle_mouse_command = nil,
		indicator = {
			icon = '▏',
			style = 'icon'
		},
		buffer_close_icon = '󰅖',
		modified_icon = '●',
		close_icon = '',
		left_trunc_marker = '',
		right_trunc_marker = '',
		max_name_length = 18,
		max_prefix_length = 15,
		truncate_names = true,
		tab_size = 18,
		diagnostics = 'nvim_lsp',
		diagnostics_update_in_insert = false,
		offsets = {
			{
				filetype = 'NvimTree',
				text = 'File Explorer',
				text_align = 'center',
				separator = true
			}
		},
		color_icons = true,
		show_buffer_icons = true,
		show_buffer_close_icons = true,
		show_close_icon = true,
		show_tab_indicators = true,
		show_duplicate_prefix = true,
		persist_buffer_sort = true,
		move_wraps_at_ends = false,
		separator_style = 'slant',
		enforce_regular_tabs = false,
		always_show_bufferline = true,
		hover = {
			enabled = true,
			delay = 200,
			reveal = { 'close' }
		}
	}
})
