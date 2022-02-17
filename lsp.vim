
lua << EOF



local lsp_installer = require('nvim-lsp-installer')

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- (optional) Customize the options passed to the server

    --if server.name == "rust-analyzer" then
        -- opts.root_dir = function() ... end
    --end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)


local servers = {
    -- rust
    'rust_analyzer@nightly',
    -- toml
    'taplo',
    -- vimscript
    'vim-ls', 
    -- zig
    'zls',
    -- python
    'pyright',
    -- c#
    'charp_ls',
    -- cmake
    'cmake',
    -- c/c++
    'clangd',
    -- lua
    'sumneko_lua',
    -- bash
    'bashls',
    -- haskell
    'hls', 
    -- html
    'html',
    -- markdown
    'grammarly',
    --'zk'
}



local lsp_installer = require'nvim-lsp-installer.servers'

for _, name in pairs(servers) do
    local server_is_found, requested_server = lsp_installer.get_server(name)
    if server_is_found then
        requested_server:on_ready(function ()
            local opts = {}
            requested_server:setup(opts)
        end)
        if not requested_server:is_installed() then
            -- Queue the server to be installed
            requested_server:install()
        end
    end
end





EOF

