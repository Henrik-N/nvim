lua << EOF
-- Icons
require('nvim-web-devicons').setup {
    default = true,
}

-- File explorer
require('nvim-tree').setup {
    disable_netrw       =   true,
    hijack_netrw        =   true,
    open_on_setup       =   false,
    ignore_ft_on_setup  =   {}, -- will not open filetype if setup is in this list
    auto_close          =   true,
    open_on_tab         =   false,
    update_to_buf_dir   =   { enable = true, auto_open = true },
    hijack_cursor       =   true,
    update_cwd          =   true, -- updates the root directory of the tree ':DirChanged' (when you run :cd, usually)
    diagnostics         =   { enable = false },
    update_focused_file =   { enable = true, update_cwd = true, ignore_list = {} }, -- update the focused file in the tree on buffer change
    system_open         =   { cmd = nil, args = {} },
    
    view = {
        width       =   30,
        height      =   30,
        side        =   'left',
        auto_resize =   true, -- will resize itself after opening a file
        mappings    =   { custom_only = false, list = {} }, -- if custom_only = true, uses list to set the mappings
    },
}
EOF
