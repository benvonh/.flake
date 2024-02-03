require('nvim-treesitter.configs').setup({
    auto_install = true,
    ensure_installed = {
        'c',
        'cpp',
        'python',
        'bash',
        'nix'
    },
    indent = {
        enable = true
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    }
})
