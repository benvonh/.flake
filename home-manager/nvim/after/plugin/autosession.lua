require('auto-session').setup({
    auto_session_enable_last_session = false,
    auto_session_enabled = true,
    auto_session_create_enabled = true,
    auto_save_enabled = true,
    auto_restore_enabled = true,
    auto_session_use_git_branch = true,
    pre_save_cmds = { 'NvimTreeClose' },
    post_restore_cmds = { 'NvimTreeOpen' }
})
