-- https://github.com/nvim-treesitter/nvim-treesitter

local function setup()
    require("nvim-treesitter.configs").setup({
        ensure_installed = {
            "c",      -- recommended default
            "lua",    -- recommended default
            "vim",    -- recommended default
            "vimdoc", -- recommended default
            "query",  -- recommended default
            "luadoc",
            "phpdoc",
            "regex",           -- for noice
            "bash",            -- for noice
            "markdown",        -- for noice
            "markdown_inline", -- for noice
            "org",
        },
        auto_install = true,

        highlight = {
            enable = true,
            disable = {},
            additional_vim_regex_highlighting = { "org", },
        },

        -- Indentation based on treesitter for the = operator.
        -- NOTE: This is an experimental feature.
        indent = {
            enable = true,
        },
    })


    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt.foldenable = false
end

return setup
