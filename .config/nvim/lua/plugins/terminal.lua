return {
  'nvzone/floaterm',
  dependencies = 'nvzone/volt',
  opts = {},
  cmd = 'FloatermToggle',

  vim.keymap.set('n', '<C-p>', ':FloatermToggle<CR>', { silent = true }),
}
