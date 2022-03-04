return function()
    -- --[[
    local alpha = require'alpha'
    local theta = require'alpha.themes.theta'
    theta.nvim_web_devicons.highlight = "Normal"
    theta.config.opts.noautocmd = true

    alpha.setup(theta.config)
    --]]

    --[[
    local d = require'alpha.themes.dashboard-term'
    alpha.setup(d.config)
    ]]
end
