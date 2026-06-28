vim.pack.add { 'https://github.com/lancewilhelm/horizon-extended.nvim' }

local function apply()
  require("horizon-extended").setup({
    style = vim.o.background == "light" and "ray" or "neo",
  })
  vim.cmd.colorscheme 'horizon-extended'
end

apply()

-- re-theme when terminal flips dark/light (nvim sets 'background' via OSC 11)
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = apply,
})
