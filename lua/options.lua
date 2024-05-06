require "nvchad.options"

-- add yours here!
-- Auto close the tree when closing the last buffer
vim.cmd([[
  autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'nvimtree') | q | endif
]])
--
-- vim.cmd([[
--   autocmd BufDelete * NvimTreeClose
-- ]])

-- Return to the last edit position
vim.cmd([[
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])

-- nnoremap <Leader>q" ciw""<Esc>P
vim.api.nvim_set_keymap('n', '<Leader>q"', 'ciw""<Esc>P', { noremap = true })

-- nnoremap <Leader>q' ciw''<Esc>P
vim.api.nvim_set_keymap('n', '<Leader>q\'', 'ciw\'\'<Esc>P', { noremap = true })

-- nnoremap <Leader>j gv'><Esc>
vim.api.nvim_set_keymap('n', '<Leader>j', 'gv\'\'<Esc>', { noremap = true })


vim.api.nvim_buf_set_keymap(0, 'i', '<C-f>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {noremap = true, silent = true})
vim.api.nvim_buf_set_keymap(0, 'i', '<C-b>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {noremap = true, silent = true})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-- At the end of init.lua
-- Define a function that checks if a file was opened and places the cursor accordingly
-- vim.cmd([[
-- function! StartCursor()
--     if argc() == 0
--         " Open NvimTree and leave the cursor there if no file was opened
--         bd # | NvimTreeOpen
--     else
--         " Open NvimTree and move the cursor to the main window if a file was opened
--         NvimTreeOpen
--         wincmd l
--     endif
-- endfunction
-- ]])
--
-- -- Call the function when Neovim starts
-- vim.cmd('autocmd VimEnter * call StartCursor()')


-- let vim.g.NvimTreeAutoOpen = 0


-- vim.cmd([[
-- function! StartCursor()
--     if argc() == 0
--         " Open NvimTree
--         NvimTreeOpen
--
--         " Wait a bit for NvimTree to fully open
--         sleep 50m
--
--         " Delete the first buffer, which is the default empty one
--         execute '1bd'
--     else
--         " Open NvimTree and move the cursor to the main window if a file was opened
--         NvimTreeOpen
--         wincmd l
--     endif
-- endfunction
-- ]])
--
-- vim.cmd('autocmd VimEnter * call StartCursor()')
--
--
vim.opt.equalalways = false

vim.api.nvim_create_augroup("FixedTerminalHeight", { clear = true })
vim.api.nvim_create_autocmd({ "VimResized", "VimLeavePre", "VimEnter" }, {
    group = "FixedTerminalHeight",
    callback = function()
        vim.cmd("resize 80")  -- Set your desired terminal split height
    end,
})

-- Set absolute line numbers by default
vim.opt.number = true
vim.opt.relativenumber = true  -- Set to true if you want relative line numbers by default

-- vim.api.nvim_set_hl(0, "pythonString", { fg = "#d0a9e5" })
-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
