local lspzero = require('lsp-zero')

lspzero.on_attach(function(client, bufnr)
    lspzero.default_keymaps({ buffer = bufnr })
end)

require('mason').setup()

require('mason-lspconfig').setup({
    ensure_installed = {
        'bashls',
        'clangd',
        'cmake',
        'cssls',
        'diagnosticls',
        'dockerls',
        'html',
        'jsonls',
        'ltex',
        'lua_ls',
        'marksman',
        'rnix',
        'pyright'
    },
    handlers = {
        lspzero.default_setup
    }
})
