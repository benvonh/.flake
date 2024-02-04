require('nvim-tree').setup({
    hijack_cursor = true,
    renderer = {
        indent_markers = {
            enable = true
        },
        icons = {
            git_placement = 'after',
            show = { folder_arrow = false }
        }
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true
    },
    git = {
        ignore = false
    },
    update_focused_file = {
        enable = true
    }
})
