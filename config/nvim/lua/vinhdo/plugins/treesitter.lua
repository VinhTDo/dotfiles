return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
		ensure_installed = {
			"lua",
			"bash"
		},
		sync_install = true,
		auto_install = false
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end
}
