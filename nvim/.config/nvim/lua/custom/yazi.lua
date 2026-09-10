vim.pack.add {
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/mikavilpas/yazi.nvim' },
}

require('yazi').setup {
  open_for_directories = false,
}

vim.keymap.set('n', '<leader>cd', '<cmd>Yazi cwd<cr>', { desc = 'Yazi: browse cwd' })
vim.keymap.set('n', '<leader>cf', '<cmd>Yazi<cr>', { desc = 'Yazi: at current file' })
