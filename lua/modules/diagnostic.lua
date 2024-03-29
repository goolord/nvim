local sign = vim.fn.sign_define

sign("DiagnosticSignError", {text = " ", texthl = "DiagnosticError", linehl = "NONE"})
sign("DiagnosticSignWarn" , {text = " ", texthl = "DiagnosticWarn" , linehl = "NONE"})
sign("DiagnosticSignInfo" , {text = " ", texthl = "DiagnosticInfo" , linehl = "NONE"})
sign("DiagnosticSignHint" , {text = " ", texthl = "DiagnosticHint" , linehl = "NONE"})

vim.diagnostic.config {
    signs = true,
    virtual_text = {spacing = 2, prefix = '❰'},
    underline = true,
    update_in_insert = true
}
