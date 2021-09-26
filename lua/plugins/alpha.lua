return function()
    local alpha = require'alpha'
    local startify = require'alpha.themes.startify'
    startify.nvim_web_devicons.enabled = false
    alpha.setup(startify.opts)
end
