return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = {
		{ "saghen/blink.cmp", version = "1.*" },
		"nvim-treesitter/nvim-treesitter"
	},
	opts = {
		completions = { blink = { enabled = true } }
	},
	config = function(_, opts)
		local markdown = require("render-markdown")
		markdown.setup(opts)

		vim.keymap.set("n", "<leader>mm", function()
			markdown.toggle()
		end)
	end
}
