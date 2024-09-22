return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
    event = 'VimEnter',

    opts = function()
        local prequire = require('ds_omega.utils').prequire

        local recorder_is_available, recorder = prequire('recorder')

        local format_buf_name = require('ds_omega.config.utils').format_buf_name;

        -- Returns window number.
        --   Really useful for jumping between windows with `<win_number> c-w w`.
        local function get_window_number()
            return vim.api.nvim_win_get_number(0);
        end
        -- Returns current working directory.
        local function get_current_working_directory()
            return format_buf_name({ buf_name = vim.fn.getcwd() });
        end
        local globalstatus = vim.o.laststatus == 3

        local git_blame_is_available, git_blame = prequire('gitblame')

        --- "C:\\Program Files\\app\\some_file" to "C:\Program Files\app"
        ---@param str
        ---@return
        local function get_path_parent(str)
            return str:match("(.*[/\\])"):sub(1, -2) -- Sub to remove trailing slash.
        end

        -- TODO: Create custom lualine component in case it lags.
        local function in_project_with_activated_venv()
            local project_is_available, project = prequire('project_nvim.project')
            local swenv_api_is_available, swenv_api = prequire('swenv.api')

            if not (project_is_available and project and swenv_api_is_available and swenv_api) then
                return
            end

            local current_venv = swenv_api.get_current_venv()
            if not current_venv or vim.tbl_isempty(current_venv) then
                return
            end

            -- get_current_venv sometimes path returns wrong string. For example,
            -- 't5-2-/MachineLearning' will be 't5-2-MachineLearning'
            return (project.get_project_root() or vim.fn.getcwd()) == get_path_parent(current_venv.path)
        end

        local empty = require('lualine.component'):extend()
        function empty:draw(default_highlight)
            self.status = ''
            self.applied_separator = ''
            self:apply_highlights(default_highlight)
            self:apply_section_separators()
            return self.status
        end


        local function is_cabinet_available()
            local cabinet_is_available, cabinet = prequire('cabinet')

            return cabinet_is_available
        end

        -- Return current cabinet drawer (https://github.com/smilhey/cabinet.nvim).
        local function get_current_cabinet_drawer()
            local cabinet_is_available, cabinet = prequire('cabinet')

            if not cabinet then
              return
            end

            local current_drawer_name = cabinet.drawer_current()
            
            return current_drawer_name
        end

        return {
            options = {
                icons_enabled = true,
                theme = 'gruvbox',
                -- It's a combination of gruvbox_light and gruvbox_dark. It loads either of
                --   them based you your background option.
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {},
                always_divide_middle = true,
                globalstatus = globalstatus,
            },
            sections = {
                lualine_a = { recorder_is_available and recorder.displaySlots or nil },
                lualine_b = {
                    'branch',
                    --[[ {
                        'mode',
                        fmt = function(mode)
                            if vim.b['visual_multi'] then
                                return mode .. ' - MULTI'
                            end
                        end
                    }, ]]
                    -- Reference: https://github.com/nvim-lualine/lualine.nvim/issues/951#issuecomment-1513861877
                    {
                        function()
                            if vim.b['visual_multi'] then
                                local ret = vim.api.nvim_exec2('call b:VM_Selection.Funcs.infoline()', { output = true })
                                return string.match(ret.output, 'M.*')
                            end
                        end
                    },
                    {
                        empty,
                        color = "lualine_c_normal",
                        separator = {
                            left = "",
                            right = "",
                        },
                    },
                    {
                        "swenv",
                        icon = ' ',
                        color = { fg = "green" },
                        cond = function()
                            return vim.bo.filetype == "python"
                        end,
                    },
                },
                lualine_c = {
                    { get_current_working_directory, icon = in_project_with_activated_venv() and '🐍' or nil },
                    'rest' -- Show .env file in http files if it exists (rest.nvim).
                },

                lualine_x = {
                    not git_blame_is_available and 'diagnostics' or
                    { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
                },
                lualine_y = { { get_current_cabinet_drawer, cond = is_cabinet__available } },
                lualine_z = { 'diff' },
            },
            inactive_sections = not globalstatus and {
                lualine_a = { get_window_number },
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = {},
                lualine_y = { 'location' },
                lualine_z = {},
            } or nil,
            tabline = {},
            extensions = {}
        }
    end,

    config = true,
}
