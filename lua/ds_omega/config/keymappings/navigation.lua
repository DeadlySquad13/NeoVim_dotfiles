local prequire = require('ds_omega.utils').prequire

local telescope_builtin = require('telescope.builtin')
local telescope_extensions = require('telescope').extensions

local KEY = require('ds_omega.config.keymappings._common.constants').KEY

local navigation_mappings = {
    name = 'Navigation',
    -- * Telescope.
    n = {
        telescope_builtin.resume,
        'Resume'
    },

    f = {
        telescope_builtin.find_files,
        'Files in current directory',
    },
    F = {
        '<Cmd>RnvimrToggle<Cr>',
        'Files via Rnvimr',
    },
    o = {
        telescope_builtin.oldfiles,
        'Old files',
    },

    b = {
        telescope_builtin.buffers,
        'Buffers',
    },

    s = {
        telescope_builtin.git_status,
        'Git Status (changed files)',
    },

    -- S = {
    --   require('session-lens').search_session()
    --   'Session search',
    -- },
    g = {
        telescope_builtin.live_grep,
        'Live grep',
    },

    h = {
        telescope_builtin.help_tags,
        'Help tags',
    },
    ['<S-t>'] = {
        telescope_builtin.treesitter,
        'Treesitter',
    },

    m = {
        telescope_builtin.marks,
        'Marks',
    },

    [KEY.forward_slash] = { ':Neotree<cr>', 'Filetree' },

    e = {
        ':e .',
        'Edit file',
        silent = false,
    },
}

local scope_extension = telescope_extensions.scope
if not vim.tbl_isempty(scope_extension) then
    navigation_mappings = vim.tbl_extend("force", navigation_mappings, {
        b = {
            telescope_builtin.buffers,
            'Tab-local Buffers',
        },
        B = {
            scope_extension.buffers,
            'Global Buffers',
        },
    })
end

local projects_extension = telescope_extensions.projects
if not vim.tbl_isempty(projects_extension) then
    navigation_mappings = vim.tbl_extend("force", navigation_mappings, {
        p = {
            projects_extension.projects,
            'Projects',
        },
    })
end

local file_browser_extension = telescope_extensions.file_browser
if not vim.tbl_isempty(file_browser_extension) then
    navigation_mappings = vim.tbl_extend("force", navigation_mappings, {
        ['-'] = {
            file_browser_extension.file_browser,
            'File browser',
        },
    })
end

local cabinet_extension = telescope_extensions.cabinet
if not vim.tbl_isempty(cabinet_extension) then
    navigation_mappings = vim.tbl_extend("force", navigation_mappings, {
        d = {
            function()
                cabinet_extension.cabinet({})
            end,
            'Cabinet Drawers',
        },
    })
end

local tabs_extension = telescope_extensions['telescope-tabs']
if not vim.tbl_isempty(tabs_extension) then
    navigation_mappings = vim.tbl_extend("error", navigation_mappings, {
        t = {
            tabs_extension.list_tabs,
            'Tabs',
        },
    })
end

-- Must be last to overwrite everything!
local search_tabs_is_available, search_tabs = prequire('search')

if search_tabs_is_available then
    navigation_mappings = vim.tbl_extend("force", navigation_mappings, {
        b = {
            function() search_tabs.open({ collection = 'buffers', tab_name = 'Tab-local' }) end,
            'Tab-local Buffers (tab)',
        },
        B = {
            function() search_tabs.open({ collection = 'buffers', tab_name = 'Global' }) end,
            'Global Buffers (tab)',
        },

        --[[ f = {
            function() search_tabs.open({ collection = 'files', tab_name = 'Files in current directory' }) end,
            'Files in current directory (tab)'
        },
        r = { -- ? Add non-tab version to navigation? It kinda useful: you don't swap cwd during this command. But it sucks to have so much file command variants :D
            function() search_tabs.open({ collection = 'files', tab_name = 'Files in current directory' }) end,
            'Recent project files (tab)'
        },
        ['-'] = {
            function() search_tabs.open({ collection = 'files', tab_name = 'File browser' }) end,
            'File browser (tab)'
        },
        o = {
            function() search_tabs.open({ collection = 'files', tab_name = 'Old files' }) end,
            'Old files (tab)'
        }, ]]
    })
end

return navigation_mappings
