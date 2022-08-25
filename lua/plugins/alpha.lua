return function()
    local alpha = require'alpha'
    -- --[[
    local startify = require'alpha.themes.startify'
    -- startify.nvim_web_devicons.highlight = "Normal"
    startify.nvim_web_devicons.enabled = false
    startify.config.opts.noautocmd = true

    alpha.setup(startify.config)
    --]]

    --[[
    local d = require'alpha.themes.dashboard'
    alpha.setup(d.config)
    --]]
end
