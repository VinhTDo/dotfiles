return {
	"jay-babu/mason-nvim-dap.nvim",
	dependencies = {
		"mason-org/mason.nvim",
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio"
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
						local target_path = cwd .. "/.venv/bin/python"
						if vim.fn.executable(target_path) == 1 then
							return target_path
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
		local dap_ui = require("dapui")
		dap_ui.setup({
			controls = {
				enabled = false
			}
		})
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
		vim.keymap.set("n", "<leader>bb", function ()
			dap.toggle_breakpoint()
		end)
		vim.keymap.set("n", "<leader>bu", function ()
			dap_ui.toggle()
		end)
		vim.keymap.set("n", "<leader>be", function ()
			dap_ui.eval()
		end)
		vim.keymap.set("n", "<F10>", function ()
			dap.step_over()
		end)
		vim.keymap.set("n", "<F11>", function ()
			dap.step_into()
		end)
		vim.keymap.set("n", "<F12>", function ()
			dap.step_out()
		end)
		vim.keymap.set("n", "<F5>", function ()
			dap.continue()
		end)

		dap.configurations = opts.daps
	end
}
