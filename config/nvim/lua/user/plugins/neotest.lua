return {
	"nvim-neotest/neotest",
  dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python"
	},
	config = function ()
		local neotest = require("neotest")
		local adapters = {
			require("neotest-python")({
				dap = { justMyCode = false },
				args = { "--quiet" },
				runner = "unittest",
				python = ".venv/bin/python",
				pytest_discover_instances = false
			})
		}
		neotest.setup({ adapters = adapters })

		vim.keymap.set("n", "<leader>tc", function ()
			neotest.run.run()
		end)
		vim.keymap.set("n", "<leader>ts", function ()
			neotest.run.stop()
		end)
		vim.keymap.set("n", "<leader>tf", function ()
			neotest.run.run(vim.fn.expand("%"))
		end)
		vim.keymap.set("n", "<leader>tw", function ()
			neotest.watch.toggle(vim.fn.expand("%"))
		end)
		vim.keymap.set("n", "<leader>tt", function ()
			neotest.summary.toggle()
		end)
		vim.keymap.set("n", "<leader>ta", function ()
			neotest.run.attach()
		end)
		vim.keymap.set("n", "<leader>to", function ()
			neotest.output_panel.toggle()
		end)
	end
}
