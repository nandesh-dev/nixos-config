{ enabledUnits }:
{
  home =
    { pkgs, lib, ... }:
    {
      programs.neovim =
        let
          fromGitHub =
            ref: repo:
            pkgs.vimUtils.buildVimPlugin {
              pname = "${lib.strings.sanitizeDerivationName repo}";
              version = ref;
              src = builtins.fetchGit {
                url = "https://github.com/${repo}.git";
                ref = ref;
              };
            };
          units = [
            {
              name = "options";
              config = ''
                vim.g.mapleader = " "
                vim.g.maplocalleader = " "

                vim.cmd("set expandtab")
                vim.cmd("set tabstop=2")
                vim.cmd("set softtabstop=2")
                vim.cmd("set shiftwidth=2")
                vim.cmd("set relativenumber")

                vim.cmd("syntax enable")
                vim.cmd("filetype plugin indent on")

                vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
                vim.api.nvim_set_keymap("", "<Up>", "<NOP>", { noremap = true, silent = true })
                vim.api.nvim_set_keymap("", "<Down>", "<NOP>", { noremap = true, silent = true })
                vim.api.nvim_set_keymap("", "<Left>", "<NOP>", { noremap = true, silent = true })
                vim.api.nvim_set_keymap("", "<Right>", "<NOP>", { noremap = true, silent = true })
              '';
            }
            {
              name = "stay-centered";
              plugins = [ (fromGitHub "HEAD" "arnamak/stay-centered.nvim") ];
              config = ''
                require("stay-centered").setup()
              '';
            }
            {
              name = "highlight-colors";
              plugins = [ (fromGitHub "HEAD" "brenoprata10/nvim-highlight-colors") ];
              config = ''
                require("nvim-highlight-colors").setup({
                  render = "virtual",
                  virtual_symbol = '⏹',
                  enable_tailwind = true,
                })
              '';
            }
            {
              name = "tailwind-fold";
              plugins = [ (fromGitHub "HEAD" "razak17/tailwind-fold.nvim") ];
              config = ''
                require("tailwind-fold").setup({ ft = { "html", "jsx" } })
              '';
            }
            {
              name = "autoclose";
              plugins = [ pkgs.vimPlugins.autoclose-nvim ];
              config = ''
                require("autoclose").setup({
                  keys = {
                      ["("] = { escape = false, close = true, pair = "()" },
                      ["["] = { escape = false, close = true, pair = "[]" },
                      ["{"] = { escape = false, close = true, pair = "{}" },
                  }
                })
              '';
            }
            {
              name = "telescope";
              plugins = [
                pkgs.vimPlugins.telescope-nvim
                pkgs.vimPlugins.plenary-nvim
              ];
              packages = [ pkgs.ripgrep ];
              config = ''
                local builtin = require("telescope.builtin")
                vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
                vim.keymap.set("n", "<leader>ft", builtin.treesitter, {})
                vim.keymap.set("n", "<leader>flr", builtin.lsp_references, {})
                vim.keymap.set("n", "<leader>fld", builtin.lsp_definitions, {})
                vim.keymap.set("n", "<leader>fli", builtin.lsp_implementations, {})
                vim.keymap.set("n", "<leader>flt", builtin.lsp_type_definitions, {})
                vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
                vim.keymap.set("n", "<leader>fs", builtin.grep_string, {})
                vim.keymap.set("n", "<leader>fb", builtin.current_buffer_fuzzy_find, {})
                vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
              '';
            }
            {
              name = "undotree";
              plugins = [ pkgs.vimPlugins.undotree ];
              config = ''vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle)'';
            }
            {
              name = "tree";
              plugins = [ pkgs.vimPlugins.nvim-tree-lua ];
              packages = [ pkgs.git ];
              config = ''
                local function my_on_attach(bufnr)
                	local api = require("nvim-tree.api")
                	api.config.mappings.default_on_attach(bufnr)
                end

                require("nvim-tree").setup({
                  filters = {
                    enable = false,
                  },
                	on_attach = my_on_attach,
                })
              '';
            }
            {
              name = "gruvbox";
              plugins = [ pkgs.vimPlugins.gruvbox-nvim ];
              config = ''
                require("gruvbox").setup({})

                vim.cmd.colorscheme("gruvbox")
              '';
            }
            {
              name = "conform";
              plugins = [ pkgs.vimPlugins.conform-nvim ];
              packages = with pkgs; [
                stylua
                nixfmt-rfc-style
                stylelint
                nodePackages.prettier
                rustywind
                rustfmt
                buf
                python312Packages.black
              ];
              config = ''
                require("conform").setup({
                	formatters_by_ft = {
                		nix = { "nixfmt" },
                		lua = { "stylua" },
                		css = { "stylelint" },
                		javascript = { "prettier", "rustywind" },
                		javascriptreact = { "prettier", "rustywind" },
                		rust = { "rustfmt" },
                		go = { "gofmt" },
                    proto = { "buf" },
                    python = { "black" },
                	},
                	format_on_save = {
                		timeout_ms = 500,
                		lsp_format = "fallback",
                	},
                })

                vim.keymap.set("n", "<leader>t", vim.cmd.NvimTreeToggle)
              '';
            }
            {
              name = "harpoon";
              plugins = [ pkgs.vimPlugins.harpoon2 ];
              config = ''
                local harpoon = require("harpoon")
                harpoon.setup({})

                vim.keymap.set("n", "<leader>ha", function()
                	harpoon:list():add()
                end)
                vim.keymap.set("n", "<leader>hw", function()
                	harpoon.ui:toggle_quick_menu(harpoon:list())
                end)
                vim.keymap.set("n", "<leader>hd", function()
                	harpoon:list():remove()
                end)

                vim.keymap.set("n", "<leader>h1", function()
                	harpoon:list():select(1)
                end)
                vim.keymap.set("n", "<leader>h2", function()
                	harpoon:list():select(2)
                end)
                vim.keymap.set("n", "<leader>h3", function()
                	harpoon:list():select(3)
                end)
                vim.keymap.set("n", "<leader>h4", function()
                	harpoon:list():select(4)
                end)
                vim.keymap.set("n", "<leader>h5", function()
                	harpoon:list():select(5)
                end)
                vim.keymap.set("n", "<leader>h6", function()
                	harpoon:list():select(6)
                end)
              '';
            }
            {
              name = "lualine";
              plugins = [ pkgs.vimPlugins.lualine-nvim ];
              config = ''
                require("lualine").setup({
                	options = {
                		icons_enabled = true,
                		component_separators = { left = "", right = "" },
                		section_separators = { left = "", right = "" },
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
                		},
                	},
                	sections = {
                		lualine_a = { "mode" },
                		lualine_b = { "branch" },
                		lualine_c = { "filename" },
                		lualine_x = { "filetype" },
                		lualine_y = { "progress" },
                		lualine_z = { "location" },
                	},
                	inactive_sections = {
                		lualine_a = {},
                		lualine_b = {},
                		lualine_c = { "filename" },
                		lualine_x = { "location" },
                		lualine_y = {},
                		lualine_z = {},
                	},
                	tabline = {},
                	winbar = {},
                	inactive_winbar = {},
                	extensions = {},
                })
              '';
            }
            {
              name = "leap";
              plugins = [ pkgs.vimPlugins.leap-nvim ];
              config = ''
                vim.keymap.set("n", "s", "<Plug>(leap)")
                vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
              '';
            }
            {
              name = "surround";
              plugins = [ pkgs.vimPlugins.nvim-surround ];
              config = ''
                require("nvim-surround").setup({})
              '';
            }
            {
              name = "treesitter";
              plugins = [
                (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
                  p.nix
                  p.javascript
                  p.typescript
                  p.python
                  p.lua
                  p.rust
                  p.json
                  p.html
                  p.css
                  p.scss
                  p.go
                ]))
              ];
            }
            {
              name = "cmp";
              plugins = [
                pkgs.vimPlugins.nvim-cmp
                pkgs.vimPlugins.nvim-lspconfig
                pkgs.vimPlugins.cmp-nvim-lsp
                pkgs.vimPlugins.cmp-buffer
                pkgs.vimPlugins.cmp-path
                pkgs.vimPlugins.cmp-cmdline
                pkgs.vimPlugins.cmp-vsnip
                pkgs.vimPlugins.vim-vsnip
              ];
              packages = with pkgs; [
                nodePackages.typescript-language-server
                rust-analyzer
                lua-language-server
                tailwindcss-language-server
                nil
                gopls
                buf-language-server
                pyright
              ];

              config = ''
                local cmp = require("cmp")

                cmp.setup({
                	snippet = {
                		expand = function(args)
                			vim.fn["vsnip#anonymous"](args.body)
                		end,
                	},
                	window = {},
                	mapping = cmp.mapping.preset.insert({
                    ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                		["<C-b>"] = cmp.mapping.scroll_docs(-4),
                		["<C-f>"] = cmp.mapping.scroll_docs(4),
                		["<C-Space>"] = cmp.mapping.complete(),
                		["<C-e>"] = cmp.mapping.abort(),
                		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                	}),
                	sources = cmp.config.sources({
                		{ name = "nvim_lsp" },
                		{ name = "vsnip" }, -- For vsnip users.
                	}, {
                		{ name = "buffer" },
                	}),
                })

                cmp.setup.cmdline({ "/", "?" }, {
                	mapping = cmp.mapping.preset.cmdline(),
                	sources = {
                		{ name = "buffer" },
                	},
                })

                -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
                cmp.setup.cmdline(":", {
                	mapping = cmp.mapping.preset.cmdline(),
                	sources = cmp.config.sources({
                		{ name = "path" },
                	}, {
                		{ name = "cmdline" },
                	}),
                	matching = { disallow_symbol_nonprefix_matching = false },
                })

                -- Set up lspconfig.
                local capabilities = require("cmp_nvim_lsp").default_capabilities()
                require("lspconfig")["tsserver"].setup({
                	capabilities = capabilities,
                })
                require("lspconfig")["rust_analyzer"].setup({
                	capabilities = capabilities,
                })
                require("lspconfig")["lua_ls"].setup({
                	capabilities = capabilities,
                })
                require("lspconfig")["nil_ls"].setup({
                	capabilities = capabilities,
                })
                require("lspconfig")["tailwindcss"].setup({
                	capabilities = capabilities,
                })
                require("lspconfig")["gopls"].setup({
                	capabilities = capabilities,
                })
                require("lspconfig")["bufls"].setup({
                	capabilities = capabilities,
                })
                require("lspconfig")["pyright"].setup({
                	capabilities = capabilities,
                })
              '';
            }
          ];
          activeUnits = builtins.filter (unit: builtins.elem unit.name enabledUnits) units;
          plugins = builtins.concatMap (unit: unit.plugins) (
            builtins.filter (unit: builtins.hasAttr "plugins" unit) activeUnits
          );
          packages = builtins.concatMap (unit: unit.packages) (
            builtins.filter (unit: builtins.hasAttr "packages" unit) activeUnits
          );
          config = ''
            lua << EOF
            ${builtins.concatStringsSep "\n\n" (
              builtins.map (unit: unit.config) (
                builtins.filter (unit: builtins.hasAttr "config" unit) activeUnits
              )
            )}
            EOF
          '';
        in
        {
          enable = true;

          viAlias = true;
          vimAlias = true;

          extraConfig = config;
          plugins = plugins;
          extraPackages = packages;
        };
    };
}
