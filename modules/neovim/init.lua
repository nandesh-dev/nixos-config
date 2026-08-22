vim.pack.add({
	"https://github.com/nvim-mini/mini.base16",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/arnamak/stay-centered.nvim",
	"https://github.com/kylechui/nvim-surround",
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/akinsho/toggleterm.nvim",
})

local plugin = {
	oil = require("oil"),
	conform = require("conform"),
	harpoon = require("harpoon"),
	telescope = require("telescope"),
	telescopebuiltin = require("telescope.builtin"),
	staycentered = require("stay-centered"),
	cmp = require("cmp"),
	cmplsp = require("cmp_nvim_lsp"),
	surround = require("nvim-surround"),
	toggleterm = require("toggleterm"),
	toggletermterminal = require("toggleterm.terminal"),
}

vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.swapfile = false
vim.o.winborder = "rounded"
vim.o.clipboard = "unnamedplus"

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

plugin.harpoon.setup()
plugin.conform.setup()
plugin.staycentered.setup()
plugin.surround.setup()

plugin.oil.setup({
	default_file_explorer = true,

	columns = { "icon" },

	use_default_keymaps = false,

	keymaps = {
		["-"] = { "actions.parent", mode = "n" },
		["<CR>"] = "actions.select",
		["hh"] = { "actions.toggle_hidden", mode = "n" },
		["p"] = { "actions.open_cwd", mode = "n" },
		["<Esc>"] = { "actions.close", mode = "n" },
	},
})

plugin.conform.setup({
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
		return { timeout_ms = 3000, lsp_format = "fallback" }
	end,
})

vim.diagnostic.config({
	virtual_text = {
		severity = nil,
	},
	update_in_insert = true,
	severity_sort = true,
})

vim.lsp.enable({
	"basedpyright",
	"nil",
	"lua_ls",
	"ts_ls",
	"rust_analyzer",
	"gopls",
})

local capabilities = plugin.cmplsp.default_capabilities()
vim.lsp.config("*", {
	capabilities = capabilities,
})

plugin.cmp.setup({
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},
	window = {
		completion = plugin.cmp.config.window.bordered(),
		documentation = plugin.cmp.config.window.bordered(),
	},
	mapping = plugin.cmp.mapping.preset.insert({
		["<C-j>"] = plugin.cmp.mapping.select_next_item(),
		["<C-k>"] = plugin.cmp.mapping.select_prev_item(),
		["<C-i>"] = plugin.cmp.mapping.scroll_docs(-4),
		["<C-o>"] = plugin.cmp.mapping.scroll_docs(4),
		["<C-Space>"] = plugin.cmp.mapping.complete(),
		["<C-e>"] = plugin.cmp.mapping.abort(),
		["<CR>"] = plugin.cmp.mapping.confirm({ select = true }),
	}),
	sources = plugin.cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "path" },
	}, {
		{ name = "buffer" },
	}),
})

plugin.toggleterm.setup({
	size = 15,
	open_mapping = nil,
	shade_terminals = false,
	direction = "horizontal",
	persist_size = true,
	persist_mode = true,
})

local Terminal = plugin.toggletermterminal.Terminal
local terminals = {
	Terminal:new({ hidden = true }),
	Terminal:new({ hidden = true }),
	Terminal:new({ hidden = true }),
	Terminal:new({ hidden = true }),
}

vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		for _, term in ipairs(terminals) do
			if term.job_id then
				vim.fn.jobstop(term.job_id)
			end
		end
	end,
})

local map = vim.keymap.set

for i, term in ipairs(terminals) do
	map("n", "<leader>" .. i, function()
		term:toggle()
	end, { desc = "Toggle terminal " .. i })
end
map("t", "<Esc><Esc>", [[<C-\><C-n>]], {})

map("n", "<leader>t", ":Oil<CR>")
map("n", "ha", function()
	plugin.harpoon:list():add()
end)
map("n", "hw", function()
	plugin.harpoon.ui:toggle_quick_menu(plugin.harpoon:list())
end)
map("n", "h1", function()
	plugin.harpoon:list():select(1)
end)
map("n", "h2", function()
	plugin.harpoon:list():select(2)
end)
map("n", "h3", function()
	plugin.harpoon:list():select(3)
end)
map("n", "h4", function()
	plugin.harpoon:list():select(4)
end)
map("n", "h5", function()
	plugin.harpoon:list():select(5)
end)
map("n", "ff", function()
	plugin.telescopebuiltin.find_files()
end)
map("n", "ft", function()
	plugin.telescopebuiltin.treesitter()
end)
map("n", "flr", function()
	plugin.telescopebuiltin.lsp_references()
end)
map("n", "fld", function()
	plugin.telescopebuiltin.lsp_definitions()
end)
map("n", "fli", function()
	plugin.telescopebuiltin.lsp_implementations()
end)
map("n", "flt", function()
	plugin.telescopebuiltin.lsp_type_definitions()
end)
map("n", "fls", function()
	plugin.telescopebuiltin.lsp_document_symbols()
end)
map("n", "fg", function()
	plugin.telescopebuiltin.live_grep()
end)
map("n", "fs", function()
	plugin.telescopebuiltin.grep_string()
end)
map("n", "fb", function()
	plugin.telescopebuiltin.current_buffer_fuzzy_find()
end)
map("n", "fd", function()
	plugin.telescopebuiltin.diagnostics()
end)
map("n", "fq", function()
	plugin.telescopebuiltin.quickfix()
end)
map("n", "<leader>cd", function()
	vim.g.disable_autoformat = true
end)
map("n", "<leader>ce", function()
	vim.g.disable_autoformat = false
end)
map("n", "<leader>cf", function()
	plugin.conform.format({ async = true })
end)
map("n", "<leader>e", vim.diagnostic.open_float)
