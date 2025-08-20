return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
		{
			"saghen/blink.cmp",
			version = "1.*",
			opts = {
				fuzzy = { implementation = "lua" },
				keymap = { preset = "default" },
				appearance = { nerd_font_variant = "mono" },
				completion = {
					trigger = { show_on_keyword = true },
					menu = { auto_show = true },
					documentation = {
						auto_show = true,
						auto_show_delay_ms = 500
					},
					ghost_text = { enabled = true }
				}
			},
			config = function(_, opts)
				require("blink.cmp").setup(opts)
			end
		},
		"rafamadriz/friendly-snippets"
	},
	opts = {
		automatic_enable = false,
		ensure_installed = { "lua_ls" },
		servers = {
			lua_ls = {
				settings = {
					Lua = {
						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
						telemetry = { enable = false },
						diagnostics = { globals = { "vim" } }
					}
				}
			}
		}
	},
	config = function (_, opts)
		local lspconfig = require("lspconfig")
		local blink = require("blink.cmp")
		require("mason-lspconfig").setup(opts)

		for server, config in pairs(opts.servers) do
			config.capabilities = blink.get_lsp_capabilities(config.capabilities)
			lspconfig[server].setup(config)
		end
	end
}
