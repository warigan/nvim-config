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

vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.mousemodel = "extend"
vim.opt.fillchars:append("diff: ")
vim.opt.splitbelow = true
vim.opt.splitright = true
-- set tabline=%!MyTabLine()
vim.opt.tabstop = 8
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smarttab = false
-- Folds are configured in nvim-treesitter, but this needs to be set before
-- loading the first buffer which is not possible in nvim-treesitter.lua due to
-- lazy loading (I think)
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "indent"
vim.opt.foldignore = ""
vim.opt.guifont = "JetBrains Mono:11"
vim.opt.completeopt:append({ "menu", "menuone", "preview", "noinsert", })
-- Max number of items
vim.opt.pumheight = 20
-- pseudo transparency for completion menu
vim.opt.pumblend = 10
-- pseudo transparency for floating window
vim.opt.winblend = 5
-- set nowrap
vim.opt.clipboard:append("unnamedplus")
vim.opt.matchpairs:append({ "<:>", "':'", "\":\"", })
vim.opt.fileencoding = "utf-8"
-- Only relevant with wrap enabled (default)
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.showbreak = "↪"
-- Minimum amount of lines to show offset +/- to cursorline
vim.opt.scrolloff = 3
vim.opt.visualbell = true
vim.opt.errorbells = false
-- Persistent undo even after you close a file and re-open it
vim.opt.undofile = true
-- Insert mode key word completion setting, see :h 'compelete'
-- and https://medium.com/usevim/set-complete-e76b9f196f0f#:~:text=When%20in%20Insert%20mode%2C%20you,%2D%2D%20CTRL%2DN%20goes%20backwards.
-- kspell is only relevant if ':set spell' is toggled on, e.g. when editing
-- documents
vim.opt.complete:append("kspell")
vim.opt.complete:remove({ "w", "b", "u", "t", })
vim.opt.spelllang = "en"
-- Align indent to next multiple value of shiftwidth.
-- E.g., only insert as many spaces necessary for reaching the next shiftwidth
vim.opt.shiftround = true
-- Allow virtualedit (editing on empty spaces) in visual block mode (Ctrl+V)
vim.opt.virtualedit = "block"
-- True color support. Avoid if terminal does not support it.
vim.opt.termguicolors = true
vim.opt.signcolumn = "auto"
-- Diff options
vim.opt.diffopt = {}
-- Use vertical split by default
vim.opt.diffopt:append("vertical")
-- Insert filler lines
vim.opt.diffopt:append("filler")
-- Execute :diffoff when only one diff window remain
vim.opt.diffopt:append("closeoff")
-- Use internal diff library
vim.opt.diffopt:append("internal")
-- These make diffs easier to read, please see the following:
-- https://vimways.org/2018/the-power-of-diff/
vim.opt.diffopt:append({ "indent-heuristic", "algorithm:histogram", })
vim.fn.execute("filetype plugin on")
vim.opt.hlsearch = false
vim.opt.laststatus = 3
