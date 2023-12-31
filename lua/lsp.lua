local package_name = "lsp"
local utils = require("utils")

local P = {}

P._filetypes = nil
P._language_servers = nil

P.capabilities = {}

P.config = {
    bashls = {},
    clangd = {},
    cmake = {},
    diagnosticls = {},
    jedi_language_server = {},
    lemminx = {},
    lua_ls = {},
    phpactor = {},
    intelephense = {},
    zls = {},
    rust_analyzer = {},
    gopls = {},
}

for server, _ in pairs(P.config) do
    utils.try_require("lsp." .. server, package_name, function (mod)
        P.config[server] = mod
    end)
end

local function ca_rename()
    local old = vim.fn.expand("<cword>")
    local new
    vim.ui.input(
        { prompt = ("Rename `%s` to: "):format(old), },
        function (input)
            new = input
        end
    )
    if new and new ~= "" then
        vim.lsp.buf.rename(new)
    end
end

function P._setup_diagnostics()
    -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#customizing-how-diagnostics-are-displayed
    vim.diagnostic.config({
        underline = true,
        signs = true,
        virtual_text = {
            prefix = "",
            format = function (diagnostic)
                return diagnostic.message
            end,
        },
        float = {
            show_header = false,
            source = "always",
            border = "single",
            focusable = false,
            format = function (diagnostic)
                return string.format("%s", diagnostic.message)
            end,
        },
        update_in_insert = false,
        severity_sort = false,
    })
    local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " ", }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl, })
    end
end

function P.on_attach(client, bufnr)
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = bufnr, }
    vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set({ "n", "i", }, "<C-k>", vim.lsp.buf.hover, opts)
    vim.keymap.set({ "n", "i", }, "<C-j>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set({ "n", "i", }, "<C-h>", vim.lsp.buf.document_highlight, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>lr", ca_rename, opts)
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set(
        { "n", "x", },
        "<leader>lf",
        function ()
            if vim.bo.filetype ~= "php" then
                return vim.lsp.buf.format()
            end

            local dls = require("lsp.diagnosticls")
            local formatters = dls.lspconfig.init_options.formatFiletypes.php
            for _, fmt in ipairs(formatters) do
                if fmt == "php_cs_fixer" then
                    ---@type table
                    local winview = vim.fn.winsaveview()
                    vim.cmd.write({ bang = true, })
                    vim.lsp.buf.format()
                    vim.cmd.write({ bang = true, })
                    vim.fn.winrestview(winview)
                    return
                end
            end

            return vim.lsp.buf.format()
        end,
        opts
    )

    -- For document highlight
    vim.cmd.highlight({ "link LspReferenceRead Visual", bang = true, })
    vim.cmd.highlight({ "link LspReferenceText Visual", bang = true, })
    vim.cmd.highlight({ "link LspReferenceWrite Visual", bang = true, })
    -- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", }, {
    --     buffer = bufnr,
    --     callback = vim.lsp.buf.document_highlight,
    -- })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", }, {
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
    })

    -- Auto show signature on insert in function parameters
    -- if client.server_capabilities.signatureHelpProvider then
    --     local chars = client.server_capabilities.signatureHelpProvider
    --         .triggerCharacters
    --     if chars and #chars > 0 then
    --         vim.api.nvim_create_autocmd("CursorHoldI", {
    --             buffer = bufnr,
    --             callback = vim.lsp.buf.signature_help,
    --         })
    --     end
    -- end

    vim.opt.updatetime = 300

    require("lsp-inlayhints").on_attach(client, bufnr, false)

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover, {
            border = "single"
        }
    )
    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
            border = "single"
        }
    )
end

function P.reload_server_buf(name)
    local server = P.config[name]
    local ft_map = {}
    for _, ft in ipairs(server.lspconfig.filetypes) do
        ft_map[ft] = true
    end
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(bufnr) then
            local buf_ft = vim.api.nvim_get_option_value(
                "filetype",
                { buf = bufnr, }
            )
            if ft_map[buf_ft] then
                vim.api.nvim_buf_call(
                    bufnr,
                    vim.cmd.edit
                )
            end
        end
    end
end

function P.filetypes()
    if not P._filetypes then
        P._filetypes = {}
        local unique = {}
        for _, server in pairs(P.config) do
            for _, ft in ipairs(server.lspconfig.filetypes) do
                if not unique[ft] then
                    table.insert(P._filetypes, ft)
                    unique[ft] = true
                end
            end
        end
    end

    return P._filetypes
end

function P.language_servers()
    if not P._language_servers then
        P._language_servers = {}
        for server, opts in pairs(P.config) do
            if opts.enabled ~= true then
                goto next_server
            end
            if opts.dependencies ~= nil then
                local not_installed = {}
                for _, dep in ipairs(opts.dependencies) do
                    if not utils.is_installed(dep) then
                        table.insert(not_installed, dep)
                    end
                end

                if #not_installed > 0 then
                    utils.warn(
                        ("Disabling %s "
                            .. "because the following required package(s) "
                            .. "are not installed: %s")
                        :format(
                            server,
                            table.concat(not_installed, ", ")
                        ),
                        package_name
                    )
                    opts.enabled = false
                    goto next_server
                end
            end

            if opts.py_module_deps ~= nil then
                local not_installed = {}
                for _, mod in ipairs(opts.py_module_deps) do
                    if not utils.python3_module_is_installed(mod) then
                        table.insert(not_installed, mod)
                    end
                end

                if #not_installed > 0 then
                    utils.warn(
                        ("Disabling %s "
                            + "because the following required python3 "
                            + "module(s) are not installed: %s")
                        :format(
                            server,
                            table.concat(not_installed, ", ")
                        ),
                        package_name
                    )
                    opts.enabled = false
                    goto next_server
                end
            end

            table.insert(P._language_servers, server)

            ::next_server::
        end
    end

    return P._language_servers
end

function P.setup_server(name)
    local server = P.config[name]

    if not server or server.enabled ~= true then
        return
    end

    local ok, lspconfig = pcall(require, "lspconfig")
    if not ok then
        utils.err("Missing required plugin lspconfig", package_name)
        return
    end

    -- server.lspconfig.root_dir = function () return vim.fn.getcwd() end
    if server.root_pattern then
        server.lspconfig.root_dir = lspconfig.util.root_pattern(
            unpack(server.root_pattern)
        )
    else
        server.lspconfig.root_dir = lspconfig.util.find_git_ancestor
    end
    server.lspconfig.capabilities = P.capabilities
    server.lspconfig.on_attach = function (...)
        local resp
        ok, resp = pcall(P.on_attach, ...)
        if not ok then
            utils.err(
                ("Failed to load on_attach for %s:\n%s"):format(name, resp)
            )
        end
    end

    if not pcall(lspconfig[name].setup, server.lspconfig) then
        utils.err("Unknown LSP server for lspconfig: " .. name, package_name)
        return
    end

    P.reload_server_buf(name)
end

function P.setup()
    P._setup_diagnostics()

    utils.try_require("cmp_nvim_lsp", package_name, function (mod)
        P.capabilities = mod.default_capabilities()
    end)

    utils.try_require("mason-lspconfig", package_name, function (mod)
        mod.setup_handlers({
            function (name)
                P.setup_server(name)
            end,
        })
    end)
end

return P
