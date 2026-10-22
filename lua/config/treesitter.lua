local M = {}

function M.setup()
  local treesitter = require('nvim-treesitter')
  local languages = { 'c', 'cpp', 'css', 'go', 'html', 'javascript', 'json', 'lua', 'markdown', 'markdown_inline', 'python', 'rust', 'tsx', 'typescript', 'vim', 'vue' }
  local filetypes = { 'c', 'cpp', 'css', 'go', 'html', 'javascript', 'javascriptreact', 'json', 'lua', 'markdown', 'python', 'rust', 'typescript', 'typescriptreact', 'vim', 'vue' }
  vim.treesitter.language.register('javascript', 'javascriptreact')
  vim.treesitter.language.register('tsx', 'typescriptreact')
  treesitter.setup()

  local installing = true
  local warned = {}
  local function start(buf)
    if not vim.api.nvim_buf_is_loaded(buf) or not vim.tbl_contains(filetypes, vim.bo[buf].filetype) then return end
    local ok, err = pcall(vim.treesitter.start, buf)
    if ok then
      vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    elseif not installing and not warned[vim.bo[buf].filetype] then
      local ft = vim.bo[buf].filetype
      warned[ft] = true
      vim.notify('Tree-sitter unavailable for ' .. ft .. '; use :TSInstall / :TSLog. ' .. tostring(err), vim.log.levels.WARN)
    end
  end

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('treesitter_start', { clear = true }),
    pattern = filetypes,
    callback = function(args) start(args.buf) end,
  })
  if vim.fn.executable('tree-sitter') ~= 1 then
    installing = false
    vim.schedule(function()
      vim.notify('Tree-sitter CLI is missing: install tree-sitter >= 0.26.1, then restart Neovim to install parsers.', vim.log.levels.WARN)
    end)
    return
  end
  treesitter.install(languages):await(function(err, success)
    vim.schedule(function()
      installing = false
      if err then vim.notify('Tree-sitter installation failed: ' .. tostring(err), vim.log.levels.ERROR) end
      if success == false then vim.notify('Some Tree-sitter parsers failed to install; see :TSLog.', vim.log.levels.WARN) end
      -- FileType may already have fired while parsers were downloading.
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do start(buf) end
    end)
  end)
end

return M
