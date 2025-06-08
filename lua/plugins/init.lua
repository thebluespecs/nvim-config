return  {
    {
        'lewis6991/gitsigns.nvim',
        event = { "BufReadPost", "BufNewFile" },
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
        --         signcolumn = true,
        --         numhl = false,
        --         linehl = false,
        --         word_diff = false,
        --         watch_gitdir = {
        --             interval = 1000,
        --             follow_files = true
        --         },
        --         attach_to_untracked = true,
        --         current_line_blame = false,
        --         current_line_blame_opts = {
        --             virt_text = true,
        --             virt_text_pos = 'eol',
        --             delay = 1000,
        --             ignore_whitespace = false,
        --         },
                -- current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        --         sign_priority = 6,
        --         update_debounce = 100,
        --         status_formatter = nil,
        --         max_file_length = 40000,
        --         preview_config = {
        --             border = 'single',
        --             style = 'minimal',
        --             relative = 'cursor',
        --             row = 0,
        --             col = 1
        --         },
        --         yadm = {
        --             enable = false
        --         },
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
                'nvim-flutter/flutter-tools.nvim',
                lazy = false,
                dependencies = {
                    'nvim-lua/plenary.nvim',
                    'stevearc/dressing.nvim', -- optional for vim.ui.select
                },
                config = true,
            }
        }
