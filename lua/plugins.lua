local ENV = require('ds_omega.constants.env')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup(vim.tbl_map(function(module) return { import = 'ds_omega.config.' .. module.import } end, {
  { import = 'Assistance' },
  { import = 'Architecturing' },
  { import = 'Commands' },
  { import = 'Completion' },
  { import = 'Editing' },
  { import = 'EditorManagement' },
  { import = 'Git' },
  { import = 'Highlighting' },
  { import = 'Integrations' },
  { import = 'Notebooks' },
  { import = 'Lsp' },
  { import = 'Snippets' },
  { import = 'Testing' },
  { import = 'Navigation' },
  { import = 'NeovimDevelopment' },
  { import = 'ProjectManagement' },
  { import = 'TaskManagement' },
  { import = 'TextObjects' },
  { import = 'Ui' },
  { import = 'WindowManagement' },
  { import = 'Workspace' },
  { import = 'Markdown' },
  { import = 'Orgmode' },
  { import = 'Writing' },

  -- # Meta layers.
  -- 'DataCenter' holds plugins and settings that help with realization of
  -- a 'DataCenter' strategy. Similar to 'Integrations' layer but focuses on
  -- goal of gathering information from multiple sources in one place.
  { import = 'DataCenter' },
}), {
  dev = {
    ---@type string | fun(plugin: LazyPlugin): string directory where you store your local plugin projects
    path = "~/.bookmarks/shared-projects/--personal/NeoVim__",
  }
})

-- local startup = require('ds_omega.utils.core').startup

-- startup({
--     function(use, use_plugin, use_rocks)

--       -- General.
--       -- use_rocks({ 'functional' })

--       -- - Xonsh syntax file.
--       use({ 'abhishekmukherg/xonsh-vim' })
--       -- - Yank without moving cursor.
--       use({ 'svban/YankAssassin.vim', event = 'VimEnter' })

--       -- * Integration.
--       -- - With system.
--       -- use({ 'majkinetor/vim-omnipresence' })

--       -- * Russian layout.
--       --use({ 'powerman/vim-plugin-ruscmd' })
--       use({
--           'lyokha/vim-xkbswitch',
--           config = [[ require('ds_omega.config.xkbswitch') ]],
--       })

--       -- * Collections of snippets.
--       -- - Emmet for html.
--       use({
--           'mattn/emmet-vim',
--           -- Specifies code to run before this plugin is loaded.
--           --  Have to disable it globally before it's loaded. Otherwise plugin will
--           --  polute all filetypes with it's keybindings after it has been loaded
--           --  in some file.
--           setup = [[ require('ds_omega.config.emmet-vim_setup') ]],
--           ft = { 'css', 'html', 'javascriptreact', 'typescriptreact' },
--           config = [[ require('ds_omega.config.emmet-vim') ]],
--       })

--       -- ! Doesn't support lazy loading! Normal vim groups are not mapped to TS
--       --   groups.
--       use({
--           'nvim-treesitter/nvim-treesitter',
--           -- - We recommend updating the parsers on update.
--           run = ':TSUpdate',
--           config = [[ require('ds_omega.config.treesitter') ]],
--       })

--       use({
--           'stsewd/sphinx.nvim',
--           run = ':UpdateRemotePlugins',
--       })

--       -- * Quickfix list.
--       use({
--           'kevinhwang91/nvim-bqf',
--           event = 'FileType qf',
--           requires = {
--               {
--                   'junegunn/fzf.vim',
--                   requires = {
--                       'junegunn/fzf',
--                       opt = false,
--                       run = function() -- Make sure that you have the latest binary.
--                         vim.fn['fzf#install']()
--                       end,
--                   },
--               },
--               {
--                   'nvim-treesitter/nvim-treesitter',
--                   opt = true, -- Highly recommended.
--               },
--           },
--       })

--       -- * Highlighting.
--       --   Nerd patched fonts required.
--       -- use({
--       --     'bryanmylee/vim-colorscheme-icons',
--       -- })

--       -- - Documentation generation.
--       use({
--           'danymat/neogen',
--           config = [[ require('ds_omega.config.neogen') ]],
--           --config = function()
--           --require('neogen').setup();
--           --end,
--           requires = 'nvim-treesitter/nvim-treesitter',
--           -- Uncomment next line if you want to follow only stable versions.
--           -- tag = "*",
--       })

--       -- Python-related text object
--       --use({ 'jeetsukumaran/vim-pythonsense', ft = { 'python' } })

--       --use({'machakann/vim-swap', event = 'VimEnter'})

--       -- Clear highlight search automatically for you
--       -- use({'romainl/vim-cool', event = 'VimEnter'})

--       -- Stay after pressing * and search selected text
--       --use({'haya14busa/vim-asterisk', event = 'VimEnter'})

--       -- A grepping tool
--       -- use {'mhinz/vim-grepper', cmd = {'Grepper', '<plug>(GrepperOperator)'}}

--       -- Show git change (change, delete, add) signs in vim sign column
--       -- use 'airblade/vim-gitgutter'

--       -- Highlight URLs inside vim
--       --use({'itchyny/vim-highlighturl', event = 'VimEnter'})

--       --open URL in browser
--       --use({'tyru/open-browser.vim', event = 'VimEnter'})

--       -- Only install these plugins if ctags are installed on the system
--       --if utils.executable('ctags') then
--       ---- show file tags in vim window
--       --use({'liuchengxu/vista.vim', cmd = 'Vista'})
--       --end

--       -- Handy unix command inside Vim (Rename, Move etc.)
--       --use({'tpope/vim-eunuch', cmd = {'Rename', 'Delete'}})

--       --if vim.g.is_mac then
--       --use({ 'lyokha/vim-xkbswitch', event = { 'InsertEnter' } })
--       --elseif vim.g.is_win then
--       --use({ 'Neur1n/neuims', event = { 'InsertEnter' } })
--       --end

--       -- Syntax check and make
--       -- use 'neomake/neomake'

--       -- Better git log display
--       -- Other alternatives are listed in FAQ
--       --use({ 'rbong/vim-flog', requires = 'tpope/vim-fugitive', cmd = { 'Flog' } })

--       -- Better git commit experience
--       --use({'rhysd/committia.vim', opt = true, setup = [[vim.cmd('packadd committia.vim')]]})

--       -- Faster footnote generation
--       --use({ 'vim-pandoc/vim-markdownfootnotes', ft = { 'markdown' } })

--       -- Vim tabular plugin for manipulate tabular, required by markdown plugins
--       --use({ 'godlygeek/tabular', cmd = { 'Tabularize' } })

--       -- Markdown JSON header highlight plugin
--       --use({ 'elzr/vim-json', ft = { 'json', 'markdown' } })

--       --use {'matze/vim-tex-fold', ft = {'tex', }}
--       --use 'Konfekt/FastFold'

--       -- Modern matchit implementation
--       -- Better alternative to vim default `%`.
--       --use({'andymass/vim-matchup', event = 'VimEnter'})

--       -- Debugger plugin
--       --if vim.g.is_win or vim.g.is_linux then
--       --use({ 'sakhnik/nvim-gdb', run = { 'bash install.sh' }, opt = true, setup = [[vim.cmd('packadd nvim-gdb')]] })
--       --end
--     end,
--     config = {
--         max_jobs = 16,

--         -- snapshot = util.join_paths(ENV.NVIM_CONFIG, "packer-lock.json"),
--         snapshot_path = ENV.NVIM_CONFIG,

--         compile_path = util.join_paths(ENV.NVIM_LUA, 'packer_compiled.lua'),
--         git = {
--             default_url_format = plug_url_format,
--         },

--         display = {
--             open_fn = require('packer.util').float,
--         },
--     },
--     layers = require('layers_specification'),
-- })
