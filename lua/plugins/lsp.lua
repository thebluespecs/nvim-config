return {
    "mason-org/mason.nvim",
    dependencies = {
        "mason-org/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
        -- Setup Mason
        require("mason").setup()

        -- -- Setup LSP with basic capabilities
        local lspconfig = require("lspconfig")
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "gopls" },
            handlers = {
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities
                    })
                end,
            },
        })
    end,
}
