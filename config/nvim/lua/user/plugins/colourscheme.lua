return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
		style = "storm",
		transparent = true,
		terminal_colors = true,
		styles = {
			comments = { italic = false },
			keywords = { italic = false },
			sidebars = "dark",
			floats = "dark"
		}
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd("colorscheme tokyonight")
	end
}
