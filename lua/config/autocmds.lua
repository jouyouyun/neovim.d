local group = vim.api.nvim_create_augroup('user_config', { clear = true })

vim.api.nvim_create_autocmd('BufReadPost', { group = group, callback = function(args)
  local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
  if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(args.buf) then vim.api.nvim_win_set_cursor(0, mark) end
end })

vim.api.nvim_create_autocmd('FileType', { group = group, pattern = { 'c', 'cpp' }, callback = function() vim.opt_local.expandtab = false; vim.opt_local.tabstop = 8; vim.opt_local.shiftwidth = 8 end })
vim.api.nvim_create_autocmd('FileType', { group = group, pattern = 'go', callback = function() vim.opt_local.expandtab = true; vim.opt_local.tabstop = 8; vim.opt_local.shiftwidth = 8 end })
vim.api.nvim_create_autocmd('FileType', { group = group, pattern = { 'html', 'css', 'javascript', 'typescript', 'vue', 'coffee' }, callback = function() vim.opt_local.expandtab = true; vim.opt_local.tabstop = 2; vim.opt_local.shiftwidth = 2 end })
vim.api.nvim_create_autocmd('FileType', { group = group, pattern = 'python', callback = function() vim.opt_local.expandtab = true; vim.opt_local.tabstop = 4; vim.opt_local.shiftwidth = 4 end })
vim.api.nvim_create_autocmd('FileType', { group = group, pattern = 'text', callback = function() vim.opt_local.expandtab = false; vim.opt_local.tabstop = 4; vim.opt_local.shiftwidth = 4 end })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, { group = group, pattern = { '*.md', '*.MD' }, command = 'setfiletype markdown' })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, { group = group, pattern = '*.qml', command = 'setfiletype qml' })
