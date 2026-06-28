vim.pack.add { 'https://github.com/lancewilhelm/horizon-extended.nvim' }
require("horizon-extended").setup({
  style = "ray",
})
vim.cmd.colorscheme 'horizon-extended'

