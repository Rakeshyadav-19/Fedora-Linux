local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

require("lazy").setup({

    -- LSP config
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local servers = {
                "pylsp",         -- Python
                "ts_ls",         -- TypeScript/JavaScript (new)
                "html",          -- HTML
                "cssls",         -- CSS
                "jsonls",        -- JSON
                "bashls",        -- Bash
                "yamlls",        -- YAML
                "dockerls",      -- Docker
                "clangd",        -- C/C++
                "lua_ls",        -- Lua
                "rust_analyzer", -- Rust
                "marksman",      -- Markdown
                "eslint",        -- ESLint (JS/TS)
                "emmet_ls",      -- Emmet (HTML/CSS)
                "graphql",       -- GraphQL
                "prismals",      -- Prisma
                "tailwindcss",   -- Tailwind CSS
                "svelte",        -- Svelte
                "phpactor",      -- PHP
                "jdtls",         -- Java
                "lemminx",       -- XML
                "sqlls",         -- SQL
            }
            for _, server in ipairs(servers) do
                lspconfig[server].setup({})
            end
        end,
    },

    -- Auto-Completion
    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "*",
        opts = {
            keymap = {
                preset = "enter",
                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<Tab>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },
                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
                ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
            },
            appearance = {
                nerd_font_variant = "mono",
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
            completion = {
                keyword = { range = "prefix" },
                menu = {
                    draw = {
                        treesitter = { "lsp" },
                    },
                },
                trigger = { show_on_trigger_character = true },
                documentation = {
                    auto_show = true,
                },
            },
            signature = { enabled = true },
        },
        opts_extend = { "sources.default" },
    },

    -- LSP manager
    { "mason-org/mason.nvim", opts = {} },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = {
                -- Common LSPs for software and fullstack web development
                "pylsp",         -- Python
                "ts_ls",         -- TypeScript/JavaScript (new)
                "html",          -- HTML
                "cssls",         -- CSS
                "jsonls",        -- JSON
                "bashls",        -- Bash
                "yamlls",        -- YAML
                "dockerls",      -- Docker
                "clangd",        -- C/C++
                "lua_ls",        -- Lua
                "rust_analyzer", -- Rust
                "marksman",      -- Markdown
                "eslint",        -- ESLint (JS/TS)
                "emmet_ls",      -- Emmet (HTML/CSS)
                "graphql",       -- GraphQL
                "prismals",      -- Prisma
                "tailwindcss",   -- Tailwind CSS
                "svelte",        -- Svelte
                "phpactor",      -- PHP
                "jdtls",         -- Java
                "lemminx",       -- XML
                "sqlls",         -- SQL
            },
        },
    },

    -- File Explorer (Tree) plugin
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- for file icons
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    filtered_items = {
                        visible = true,
                        show_hidden_count = true,
                    },
                },
                default_component_configs = {
                    icon = {
                        folder_closed = "",
                        folder_open = "",
                        folder_empty = "",
                    },
                },
            })
           
        end,
    },

    -- Fuzzy Finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require('telescope').setup{}
        end,
    },

    -- Treesitter for better syntax highlighting and code navigation
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter.configs').setup {
                highlight = { enable = true },
                indent = { enable = true },
                ensure_installed = "all",
            }
        end,
    },

    -- Debug Adapter Protocol (DAP)
    {
        "mfussenegger/nvim-dap",
        config = function()
            -- Basic DAP setup, can be extended per language
        end,
    },

    -- Git integration
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup()
        end,
    },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require('lualine').setup { options = { theme = 'auto' } }
        end,
    },

    -- Terminal integration
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require('toggleterm').setup()
        end,
    },

    -- Test runner
    {
        "klen/nvim-test",
        config = function()
            require('nvim-test').setup()
        end,
    },

    -- Formatter
    {
        "stevearc/conform.nvim",
        config = function()
            require('conform').setup()
        end,
    },

    -- Notifications
    {
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require('notify')
        end,
    },

    -- Dashboard
    {
        "goolord/alpha-nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        config = function()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end,
    },

    -- Which-key for keymap discovery
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup{}
        end,
    },

    -- Theme: Catppuccin
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                integrations = {
                    treesitter = true,
                    lsp_trouble = true,
                    cmp = true,
                    gitsigns = true,
                    telescope = true,
                    nvimtree = true,
                    notify = true,
                    mini = true,
                },
            })
            vim.cmd.colorscheme "catppuccin"
        end,
    },

    -- Indent guides and scope lines
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = { char = "│" },
            scope = { enabled = true, show_start = true, show_end = true },
        },
        config = function()
            require("ibl").setup {
                indent = { char = "│" },
                scope = { enabled = true, show_start = true, show_end = true },
            }
        end,
    },

    -- Bufferline (tabs like VSCode)
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        config = function()
            require("bufferline").setup {
                options = {
                    mode = "buffers",
                    diagnostics = "nvim_lsp",
                    separator_style = "slant",
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                },
            }
        end,
    },

    -- Project management
    {
        "ahmedkhalf/project.nvim",
        lazy = false,
        config = function()
            require("project_nvim").setup {}
        end,
    },

    -- Better notifications (Noice)
    {
        "folke/noice.nvim",
        dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
        lazy = false,
        config = function()
            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                presets = {
                    bottom_search = true,
                    command_palette = true,
                    long_message_to_split = true,
                },
            })
        end,
    },

    -- UI: Dressing (better input/select popups)
    {
        "stevearc/dressing.nvim",
        lazy = false,
        config = function()
            require("dressing").setup()
        end,
    },

    -- UI: Improved command line
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup{}
        end,
    },

    -- Smooth scrolling
    {
        "karb94/neoscroll.nvim",
        lazy = false,
        config = function()
            require('neoscroll').setup()
        end,
    },

    -- Colorizer (highlight color codes)
    {
        "NvChad/nvim-colorizer.lua",
        lazy = false,
        config = function()
            require('colorizer').setup()
        end,
    },

    -- Performance: Faster startup
    {
        "lewis6991/impatient.nvim",
        config = function()
            pcall(require, 'impatient')
        end,
    },

    -- AI code completion (GitHub Copilot)
    {
        "github/copilot.vim",
        event = "InsertEnter",
    },

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end,
    },

    -- Harpoon (quick file/project nav)
    {
        "ThePrimeagen/harpoon",
        event = "VeryLazy",
        config = function()
            require("harpoon").setup {}
        end,
    },

    -- Trouble (diagnostics quickfix list)
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("trouble").setup {}
        end,
    },

    -- Markdown preview
    {
        "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        build = "cd app && yarn install",
        config = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    },

    -- Session management
    {
        "rmagatti/auto-session",
        lazy = false,
        config = function()
            require("auto-session").setup {
                auto_restore_enabled = false, -- Disable auto-restore on startup
                auto_session_enable_last_session = false,
                auto_save_enabled = false,    -- Optional: disable auto-save
                pre_save_cmds = { "AlphaClose" },
                post_restore_cmds = { "AlphaClose" },
            }
        end,
    },

    -- Startup profiling
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    },

    -- Rust tools
    {
        "simrat39/rust-tools.nvim",
        ft = { "rust" },
        config = function()
            require("rust-tools").setup {}
        end,
    },

    -- TypeScript/JavaScript/React/Next.js tools
    {
        "pmizio/typescript-tools.nvim",
        ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("typescript-tools").setup {}
        end,
    },

    -- DAP UI for debugging
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            require("dapui").setup()
        end,
    },

    -- Auto close/rename HTML/JSX tags
    {
        "windwp/nvim-ts-autotag",
        ft = { "html", "javascriptreact", "typescriptreact", "javascript", "typescript" },
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },

    -- Surround text objects (change tags, quotes, etc)
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup {}
        end,
    },

    -- Spectre: project-wide search/replace
    {
        "nvim-pack/nvim-spectre",
        event = "VeryLazy",
        config = function()
            require('spectre').setup()
        end,
    },

    -- Null-ls for extra lint/format (ESLint, Prettier, Black, etc)
    {
        "nvimtools/none-ls.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("null-ls").setup {
                sources = {
                    require("null-ls").builtins.formatting.prettier,
                    require("null-ls").builtins.formatting.black,
                    require("null-ls").builtins.formatting.stylua,
                },
            }
        end,
    },

})

