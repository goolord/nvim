return function()
    local startify = require'alpha.themes.startify'
    startify.nvim_web_devicons.enabled = false
    local alpha = require'alpha'
    alpha.setup(startify.opts)
end
