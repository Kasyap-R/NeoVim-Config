require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"


-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"
vim.opt.number = true
vim.opt.relativenumber = true
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', {noremap = true, silent = true})
vim.cmd [[
  function! DeleteWhitespace()
    if getline('.')[col('.')-1] =~# '\s'
      execute 'normal! "_x'
    else
      execute 'normal! x'
    endif
  endfunction

  function! DeleteLine()
    if getline('.') =~# '^\s*$'
      execute 'normal! "_dd'
    else
      execute 'normal! dd'
    endif
  endfunction

  nnoremap x :call DeleteWhitespace()<CR>
  vnoremap x "_x
  nnoremap dd :call DeleteLine()<CR>
]]


