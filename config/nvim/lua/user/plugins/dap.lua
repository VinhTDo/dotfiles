return {
	"jay-babu/mason-nvim-dap.nvim",
	dependencies = {
		"mason-org/mason.nvim",
		"mfussenegger/nvim-dap"
	},
	opts = {
		ensure_installed = { "python" },
		automatic_installation = false,
		handlers = {
			function (config)
				require("mason-nvim-dap").default_setup(config)
			end
		},
		daps = {
			python = {
				{
					type = "python",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					pythonPath = function ()
						local cwd = vim.fn.getcwd()
						if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
							return cwd .. "/venv/bin/python"
						elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
							return cwd .. "/.venv/bin/python"
						else
							return "/usr/bin/python"
						end
					end
				}
			}
		}
	},
	config = function (_, opts)
		require("mason").setup({})
		require("mason-nvim-dap").setup(opts)

		local dap = require("dap")
		local widgets = require("dap.ui.widgets")
		local sidebar = widgets.sidebar(
			widgets.scopes,
			{ number = true, wrap = false }
		)
		vim.api.nvim_set_hl(
			0,
			"DapBreakpoint",
			{
				ctermbg = 0,
				fg = "#983939"
			})
		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "", texthl = "DapBreakpoint", numhl = "DapBreakpoint" }
		)
		vim.keymap.set("n", "<leader>b", function ()
			dap.toggle_breakpoint()
		end)
		vim.keymap.set("n", "<leader>sb", function ()
			sidebar.toggle()
		end)
		vim.keymap.set("n", "<F8>", function ()
			dap.step_over()
		end)
		vim.keymap.set("n", "<F9>", function ()
			dap.step_into()
		end)
		vim.keymap.set("n", "<F10>", function ()
			dap.step_out()
		end)
		vim.keymap.set("n", "<F11>", function ()
			dap.continue()
		end)
		vim.keymap.set("n", "<F12>", function ()
			dap.run_last()
		end)

		dap.configurations = opts.daps
	end
}
