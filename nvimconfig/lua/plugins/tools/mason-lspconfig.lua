return{
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = { "lua_ls","ts_ls","jsonls","bashls" },
        automatic_installation = true,
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
