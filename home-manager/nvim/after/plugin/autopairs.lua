local rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')
local pairs = require('nvim-autopairs')

pairs.setup({
    map_c_w = true,
    check_ts = true
})

pairs.add_rule(rule('tempalte<', '>', 'cpp')
    :with_cr(true):with_del(true)
    :with_move(cond.is_bracket_line_move())
)
