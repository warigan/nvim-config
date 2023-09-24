--[[
    Copyright 2023 Oscar Wallberg

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
]]

-- https://github.com/nvim-orgmode/orgmode

local orgmode = require("orgmode")
orgmode.setup_ts_grammar()
orgmode.setup({
    org_agenda_files = { "~/Documents/org/**/*", },
    org_default_notes_file = "~/Documents/org/notes.org",
    org_todo_keywords = {
        "TODO(t)",
        "ACTIVE(a)",
        "WAITING(w)",
        "|",
        "DONE(d)",
        "DISCARDED(c)",
    },
    org_todo_keyword_faces = {
        ACTIVE = ":foreground dodgerblue :weight bold",
        WAITING = ":foreground lightgoldenrod :weight bold",
        DISCARDED = ":foreground grey :weight bold",
    },
    win_split_mode = "float",
    win_border = "single",
    org_archive_location = "~/Documents/org/archive.org::",
    org_log_done = "note",
    org_log_into_drawer = "LOGBOOK",
    org_highlight_latex_and_related = "entities",
    org_agenda_span = "week",
    org_agenda_skip_scheduled_if_done = true,
    org_agenda_skip_deadline_if_done = true,

})