local prequire = require('ds_omega.utils').prequire
local utils_is_available, utils = prequire('ds_omega.config.keymappings._common.utils')
local keymappings = require("ds_omega.config.keymappings._common.constants").keymappings

if not utils_is_available then
    return
end

local gitlab_is_available, gitlab = require('ds_omega.ds_omega_utils').prequire_plugin('gitlab')
if not gitlab_is_available or not gitlab then
    return
end

local comment_key = { 'a', 'A' }

return {
    n = {
        [keymappings.leader_right] = {
            g = {
                s = {
                    gitlab.summary,
                    'Show summary for current branch',
                },
                g = {
                    gitlab.review,
                    'Review current branch',
                },
                G = {
                    gitlab.choose_merge_request,
                    'Choose merge request',
                },
                [comment_key[1]] = {
                    gitlab.create_comment,
                    'Add comment on current line'
                },
            },
        },
        ['<Leader>i'] = {
            g = {
                gitlab.move_to_discussion_tree_from_diagnostic,
                'Merge request discussion'
            },
        },
    },
    x = {
        [keymappings.leader_right] = {
            g = {
                [comment_key[1]] = {
                    gitlab.create_multiline_comment,
                    'Add multi-line comment on selection'
                },
                [comment_key[2]] = {
                    gitlab.create_comment_suggestion,
                    'Add multi-line comment suggestion on selection'
                },
            },
        },
    },
}
