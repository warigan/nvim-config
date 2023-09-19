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

-- https://github.com/folke/noice.nvim

require("noice").setup({
    cmdline = {
        view = "cmdline_popup",
        format = {
            cmdline = false,
            search_down = false,
            search_up = false,
            filter = false,
            lua = false,
            help = false,
        },
    },
    messages = {
        enabled = true,
    },
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
        hover = {
            silent = true,
        },
    },
    presets = {
        command_palette = true,
    },
})

-- using notify directly instead
-- vim.notify = require("noice").notify
