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

vim.loader.enable()

local plugins = {
    {
        "Mofiqul/vscode.nvim",
        priority = 1000,
        lazy = false,
        config = function () require("plugins.config.vscode") end,
    },
    {
        "rcarriga/nvim-notify",
        priority = 900,
        config = function () require("plugins.config.notify") end,
    },
    {
        "rafamadriz/friendly-snippets",
    },
    {
        "L3MON4D3/LuaSnip",
        config = function () require("plugins.config.luasnip") end,
        -- comment out on windows and install jsregexp manually
        build = "make install_jsregexp",
        version = "2.*",
    },
    {
        "windwp/nvim-autopairs",
        config = function () require("plugins.config.autopairs") end,
    },
    {
        "saadparwaiz1/cmp_luasnip",
    },
    {
        "hrsh7th/cmp-buffer",
    },
    {
        "hrsh7th/cmp-path",
    },
    {
        "hrsh7th/cmp-cmdline",
    },
    {
        "onsails/lspkind-nvim",
    },
    {
        "hrsh7th/nvim-cmp",
        config = function () require("plugins.config.cmp") end,
    },
    {
        "hrsh7th/cmp-nvim-lsp",
    },
    {
        "williamboman/mason.nvim",
        config = function () require("plugins.config.mason") end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function () require("plugins.config.mason_lspconfig") end,
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        config = function () require("plugins.config.lsp_signature") end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function () require("lsp"):setup() end,
        lazy = true,
        ft = require("lsp"):filetypes(),
    },
    {
        "nvim-treesitter/nvim-treesitter",
        config = function () require("plugins.config.treesitter") end,
        lazy = true,
        event = "VimEnter",
    },
    {
        "mfussenegger/nvim-dap",
        config = function () require("plugins.config.dap") end,
        lazy = true,
        ft = require("lsp"):filetypes(),
    },
    {
        "rcarriga/nvim-dap-ui",
        config = function () require("plugins.config.dap_ui") end,
    },
    {
        "kyazdani42/nvim-web-devicons",
    },
    {
        "tpope/vim-fugitive",
        config = function () require("plugins.config.fugitive") end,
        lazy = true,
        event = "VimEnter",
    },
    {
        "rbong/vim-flog",
        config = function () require("plugins.config.flog") end,
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function () require("plugins.config.lualine") end,
        lazy = true,
        event = "VimEnter",
    },
    {
        "nvim-lua/plenary.nvim",
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function () require("plugins.config.gitsigns") end,
        lazy = true,
        event = "VimEnter",
    },
    {
        "nvim-telescope/telescope.nvim",
        config = function () require("plugins.config.telescope") end,
        lazy = true,
        event = "VimEnter",
    },
    {
        "numToStr/Comment.nvim",
        config = function () require("plugins.config.comment") end,
        lazy = true,
        event = "VimEnter",
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function () require("plugins.config.indent-blankline") end,
        lazy = true,
        event = "VimEnter",
    },
    {
        "simeji/winresizer",
        config = function () require("plugins.config.winresizer") end,
        lazy = true,
        keys = { "<C-W>r", },
    },
    {
        "sindrets/winshift.nvim",
        config = function () require("plugins.config.winshift") end,
        lazy = true,
        keys = { "<C-W>m", },
    },
    {
        "martinda/Jenkinsfile-vim-syntax",
        lazy = true,
        ft = { "jenkinsfile", "Jenkinsfile", },
    },
    {
        "kyazdani42/nvim-tree.lua",
        config = function () require("plugins.config.tree") end,
    },
    {
        "dstein64/vim-startuptime",
        lazy = true,
        event = "VimEnter",
    },
    {
        "stevearc/aerial.nvim",
        config = function () require("plugins.config.aerial") end,
    },
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        config = function () require("plugins.config.neorg") end,
    },
    {
        "RubixDev/mason-update-all",
        config = function () require("plugins.config.mason_update_all") end,
    },
    {
        "famiu/bufdelete.nvim",
        config = function () require("plugins.config.bufdelete") end,
    },
}

local opts = {}

require("lazy").setup(plugins, opts)