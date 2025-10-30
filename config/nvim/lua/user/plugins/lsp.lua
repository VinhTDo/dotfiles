return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
		{
			"saghen/blink.cmp",
			version = "1.*",
			dependencies = {
				{ "L3MON4D3/LuaSnip", version="v2.*" },
				"rafamadriz/friendly-snippets"
			},
			opts = {
				fuzzy = { implementation = "lua" },
				keymap = { preset = "default" },
				appearance = { nerd_font_variant = "mono" },
				completion = {
					trigger = { show_on_keyword = true },
					menu = {
						auto_show = true,
						draw = {
							columns = {
								{ "kind_icon", "label", "label_description", "kind", gap = 1 }
							}
						}
					},
					documentation = {
						auto_show = true,
						auto_show_delay_ms = 500
					},
					ghost_text = { enabled = true },
				},
				sources = {
					default = { "lsp", "path", "snippets", "buffer" }
				},
				snippets = { preset = "luasnip" },
				signature = { enabled = true }
			},
			opts_extend = { "sources.default" },
			config = function(_, opts)
				require("blink.cmp").setup(opts)
			end
		}
	},
	opts = {
		automatic_enable = false,
		ensure_installed = {
			"lua_ls", "rust_analyzer", "clangd", "asm_lsp",
			"csharp_ls", "pylsp", "ts_ls", "cssls",
			"html", "jdtls", "intelephense", "gopls",
			"docker_language_server"
		},
		servers = {
			lua_ls = {
				filetypes = { "lua" },
				settings = {
					Lua = {
						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
						telemetry = { enable = false },
						diagnostics = { globals = { "vim" } }
					}
				}
			},
			rust_analyzer = { filetypes = { "rust" } },
			clangd = { filetypes = { "c", "cpp" } },
			asm_lsp = { filetypes = { "asm", "s" } },
			csharp_ls = { filetypes = { "cs" } },
			pylsp = { filetypes = { "python" } },
			ts_ls = { filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.jsx" } },
			cssls = { filetypes = { "css", "scss", "less" } },
			html = { filetypes = { "html" } },
			jdtls = { filetypes = { "java" } },
			intelephense = { filetypes = { "php" } },
			gopls = { filetypes = { "go" } },
			docker_language_server = { filetypes = { "Dockerfile" } }
		}
	},
	config = function (_, opts)
		local blink = require("blink.cmp")
		require("mason-lspconfig").setup(opts)

		for server, config in pairs(opts.servers) do
			config.capabilities = blink.get_lsp_capabilities(config.capabilities)
			vim.lsp.config(server, config)
			vim.lsp.enable(server)
		end
	end
}
