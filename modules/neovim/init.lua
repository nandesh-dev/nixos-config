vim.pack.add({
	"https://github.com/nvim-mini/mini.base16",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/arnamak/stay-centered.nvim",
})

vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.swapfile = false

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("oil").setup({
	default_file_explorer = true,

	columns = { "icon" },

	use_default_keymaps = false,

	keymaps = {
		["-"] = { "actions.parent", mode = "n" },
		["<CR>"] = "actions.select",
		["th"] = { "actions.toggle_hidden", mode = "n" },
		["tp"] = { "actions.open_cwd", mode = "n" },
		["<Esc>"] = { "actions.close", mode = "n" },
	},
})
require("conform").setup({
	formatters_by_ft = {
		nix = { "nixfmt" },
		lua = { "stylua" },
		css = { "stylelint", "prettier" },
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		rust = { "rustfmt" },
		go = { "gofmt" },
		proto = { "buf" },
		python = { "black" },
		ruby = { "prettier" },
		eruby = { "prettier" },
		markdown = { "prettier" },
		json = { "prettier" },
		html = { "prettier" },
		yaml = { "prettier" },
		sass = { "prettier" },
		scss = { "prettier" },
		glsl = { "prettier" },
	},
	format_on_save = function()
		if vim.g.disable_autoformat then
			return
		end
		return { timeout_ms = 5000, lsp_format = "fallback" }
	end,
})
require("harpoon").setup()
require("telescope").setup()
require("stay-centered").setup()

vim.lsp.enable({
	"nil",
	"lua_ls",
	"typescript-language-server",
	"rust-analyzer",
	"gopls",
})

vim.keymap.set("n", "<leader>t", ":Oil<CR>")
vim.keymap.set("n", "ha", function()
	require("harpoon"):list():add()
end)
vim.keymap.set("n", "hw", function()
	require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
end)
vim.keymap.set("n", "h1", function()
	require("harpoon"):list():select(1)
end)
vim.keymap.set("n", "h2", function()
	require("harpoon"):list():select(2)
end)
vim.keymap.set("n", "h3", function()
	require("harpoon"):list():select(3)
end)
vim.keymap.set("n", "h4", function()
	require("harpoon"):list():select(4)
end)
vim.keymap.set("n", "h5", function()
	require("harpoon"):list():select(5)
end)
vim.keymap.set("n", "ff", function()
	require("telescope.builtin").find_files()
end)
vim.keymap.set("n", "ft", function()
	require("telescope.builtin").treesitter()
end)
vim.keymap.set("n", "flr", function()
	require("telescope.builtin").lsp_references()
end)
vim.keymap.set("n", "fld", function()
	require("telescope.builtin").lsp_definitions()
end)
vim.keymap.set("n", "fli", function()
	require("telescope.builtin").lsp_implementations()
end)
vim.keymap.set("n", "flt", function()
	require("telescope.builtin").lsp_type_definitions()
end)
vim.keymap.set("n", "fls", function()
	require("telescope.builtin").lsp_document_symbols()
end)
vim.keymap.set("n", "fg", function()
	require("telescope.builtin").live_grep()
end)
vim.keymap.set("n", "fs", function()
	require("telescope.builtin").grep_string()
end)
vim.keymap.set("n", "fb", function()
	require("telescope.builtin").current_buffer_fuzzy_find()
end)
vim.keymap.set("n", "fd", function()
	require("telescope.builtin").diagnostics()
end)
vim.keymap.set("n", "fq", function()
	require("telescope.builtin").quickfix()
end)
vim.keymap.set("n", "<leader>cd", function()
	vim.g.disable_autoformat = true
end)
vim.keymap.set("n", "<leader>ce", function()
	vim.g.disable_autoformat = false
end)
vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({ async = true })
end)
