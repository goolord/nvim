vim.diagnostic.config {
    virtual_text = {spacing = 2, prefix = '❰'},
    underline = true,
    update_in_insert = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = " ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticError",
            [vim.diagnostic.severity.WARN]  = "DiagnosticWarn",
            [vim.diagnostic.severity.INFO]  = "DiagnosticInfo",
            [vim.diagnostic.severity.HINT]  = "DiagnosticHint",
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = "NONE",
            [vim.diagnostic.severity.WARN]  = "NONE",
            [vim.diagnostic.severity.INFO]  = "NONE",
            [vim.diagnostic.severity.HINT]  = "NONE",
        },
    }
}
