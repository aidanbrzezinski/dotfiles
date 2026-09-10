local gdb_cmd = vim.fn.executable('arm-none-eabi-gdb') == 1
    and 'arm-none-eabi-gdb' or 'gdb-multiarch'

dap.adapters.gdb = {
  type = 'executable',
  command = gdb_cmd,
  args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
}
