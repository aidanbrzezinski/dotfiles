vim.pack.add {
  { src = 'https://github.com/coder/claudecode.nvim' },
}

require('claudecode').setup {
  terminal = { provider = 'native' },
}

local map = vim.keymap.set
map('n', '<leader>ac', '<cmd>ClaudeCode<cr>', { desc = 'Toggle Claude' })
map('n', '<leader>af', '<cmd>ClaudeCodeFocus<cr>', { desc = 'Focus Claude' })
map('n', '<leader>ar', '<cmd>ClaudeCode --resume<cr>', { desc = 'Resume session' })
map('n', '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', { desc = 'Add this buffer' })
map('v', '<leader>as', '<cmd>ClaudeCodeSend<cr>', { desc = 'Send selection' })
map('n', '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', { desc = 'Accept diff' })
map('n', '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', { desc = 'Reject diff' })
