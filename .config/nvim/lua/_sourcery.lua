local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'
local util = require 'lspconfig/util'

if not configs.sourcery then
    configs.sourcery = {
        default_config = {
            cmd = {'sourcery', 'lsp'},
            filetypes = {'python'},
            init_options = {
                editor_version = 'vim',
                extension_version = 'vim.lsp',
                token = 'user_9IMPzM1nhVENfmTL5gZoD0KOh3_zFWPCHqjuHQs019beGcu1yi78i0TYBmM'
            },
            root_dir = function(fname)
                local root_files = {
                    'pyproject.toml', 'setup.py', 'setup.cfg',
                    'requirements.txt', 'Pipfile'
                }
                return util.root_pattern(unpack(root_files))(fname) or
                           util.find_git_ancestor(fname) or
                           util.path.dirname(fname)
            end,
            settings = {}
        }
    }
end

lspconfig.sourcery.setup {}
