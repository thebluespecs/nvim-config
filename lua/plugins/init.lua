return  {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            vim.cmd("colorscheme rose-pine")
        end
    },
    'numToStr/Comment.nvim',
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "BufReadPost",
        opts = {
            suggestion = {
                enabled = not vim.g.ai_cmp,
                auto_trigger = true,
                hide_during_completion = vim.g.ai_cmp,
                keymap = {
                    accept = "<C-a>", -- ✅ Accept Copilot suggestion with Ctrl + A
                    next = "<M-]>",
                    prev = "<M-[>",
                },
            },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
            },
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy", -- or "BufEnter" if you prefer loading it sooner
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '', right = ''},
                    section_separators = { left = '', right = ''},
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    }
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {'location'},
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {}
            }
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('gitsigns').setup {
                signs = {
                    add          = { text = '+' },
                    change       = { text = '~' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signcolumn = true,
                numhl = false,
                linehl = false,
                word_diff = false,
                watch_gitdir = {
                    interval = 1000,
                    follow_files = true
                },
                attach_to_untracked = true,
                current_line_blame = false,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'eol',
                    delay = 1000,
                    ignore_whitespace = false,
                },
                current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil,
                max_file_length = 40000,
                preview_config = {
                    border = 'single',
                    style = 'minimal',
                    relative = 'cursor',
                    row = 0,
                    col = 1
                },
                yadm = {
                    enable = false
                },
            }
        end
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- optional
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "<C-n>", "<cmd>Neotree toggle<CR>", desc = "Toggle Neo-tree" },
        },
        init = function()
            -- 🔒 Disable netrw at the very start
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            -- 📂 Auto-open Neo-tree if starting with a directory or no file
            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    local args = vim.fn.argv()
                    local is_dir = vim.fn.isdirectory(args[1] or "") == 1
                    if #args == 0 or is_dir then
                        require("neo-tree.command").execute({ action = "show", source = "filesystem", position = "left" })
                    end
                end,
            })
        end,
        config = function()
            require("neo-tree").setup {
                close_if_last_window = true,
                popup_border_style = "rounded",
                enable_git_status = true,
                enable_diagnostics = true,
                default_component_configs = {
                    indent = {
                        with_markers = true,
                        with_expanders = true,
                    },
                    git_status = {
                        symbols = {
                            added = "✚",
                            modified = "",
                            deleted = "✖",
                            renamed = "󰁕",
                            untracked = "",
                            ignored = "",
                            unstaged = "󰄱",
                            staged = "",
                            conflict = "",
                        },
                    },
                },
                window = {
                    position = "left",
                    width = 30,
                },
                filesystem = {
                    filtered_items = {
                        hide_dotfiles = false,
                        hide_gitignored = true,
                        hide_by_name = {
                            "node_modules",
                            "__pycache__",
                        },
                    },
                    follow_current_file = {
                        enabled = true,
                    },
                    use_libuv_file_watcher = true,
                },
            }
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5", -- or the latest stable tag
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "Telescope",
        keys = {
            { "<leader>pf", function() require("telescope.builtin").git_files() end, desc = "Git Files" },
            { "<C-p>", function() require("telescope.builtin").find_files() end, desc = "Find Files" },
            { "<leader>ps", function() require("telescope.builtin").live_grep() end, desc = "Live Grep" },
            -- If you want to use grep_string with input prompt instead:
            -- {
                --   "<leader>ps",
                --   function()
                    --     require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
                    --   end,
                    --   desc = "Grep String"
                    -- },
                },
                config = function()
                    require("telescope").setup {
                        defaults = {
                            layout_config = {
                                prompt_position = "top",
                            },
                            sorting_strategy = "ascending",
                        },
                    }
                end,
            },
            {
                "nvim-treesitter/nvim-treesitter",
                build = ":TSUpdate",
                event = { "BufReadPost", "BufNewFile" },
                config = function()
                    require("nvim-treesitter.configs").setup {
                        ensure_installed = {
                            "javascript",
                            "typescript",
                            "c",
                            "lua",
                            "rust",
                            "go",
                            "dart", -- for Flutter
                        },
                        sync_install = false,
                        auto_install = true,
                        highlight = {
                            enable = true,
                            additional_vim_regex_highlighting = false,
                        },
                    }
                end,
            },
            {
                "VonHeikemen/lsp-zero.nvim",
                branch = "v3.x",
                dependencies = {
                    -- LSP Support
                    "neovim/nvim-lspconfig",

                    -- Autocompletion
                    "hrsh7th/nvim-cmp",
                    "hrsh7th/cmp-nvim-lsp",
                    "hrsh7th/cmp-nvim-lua",
                    "hrsh7th/cmp-path",
                    "L3MON4D3/LuaSnip",
                },
            },
            {
                'nvim-flutter/flutter-tools.nvim',
                lazy = false,
                dependencies = {
                    'nvim-lua/plenary.nvim',
                    'stevearc/dressing.nvim', -- optional for vim.ui.select
                },
                config = true,
            }
        }
