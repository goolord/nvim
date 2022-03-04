return function()
    -- --[[
    local alpha = require'alpha'
    local startify = require'alpha.themes.alpha'
    -- startify.nvim_web_devicons.enabled = false
    startify.config.opts.noautocmd = true

    alpha.setup(startify.config)
    --]]

    --[[
    local d = require'alpha.themes.dashboard-term'
    alpha.setup(d.config)
    ]]
end
