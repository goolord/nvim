return function()
    local alpha = require'alpha'
    -- --[[
    local startify = require'alpha.themes.startify'
    -- startify.nvim_web_devicons.highlight = "Error"
    startify.nvim_web_devicons.enabled = false
    startify.config.opts.noautocmd = true
    -- startify.section.mru.opts = { inherit = { position = "center", width = 65 } }

    alpha.setup(startify.config)
    --]]

    --[[
    local d = require'alpha.themes.dashboard'
    alpha.setup(d.config)
    --]]
end
