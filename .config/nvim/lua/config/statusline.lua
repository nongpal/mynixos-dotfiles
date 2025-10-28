local function set_statusline_highlights()
  local highlights = {
    Normal = { fg = '#f4f4f4', bg = '#101319' },
    Separator = { fg = '#171b24', bg = '#101319' },
    Separator2 = { fg = '#3a435a', bg = '#171b24' },
    ModeText = { fg = '#956dca', bg = '#171b24' },
    PathText = { fg = '#956dca', bg = '#171b24' },
    FileText = { fg = '#f4f3ee', bg = '#171b24' },
    FileType = { fg = '#e37e4f', bg = '#171b24' },
    BranchName = { fg = '#69bfce', bg = '#171b24' },
    LineText = { fg = '#e34f4f', bg = '#171b24' },
    ColumnText = { fg = '#5679e3', bg = '#171b24' },
    PercentageText = { fg = '#5599e2', bg = '#171b24' },
    TotalLineText = { fg = '#956dca', bg = '#171b24' },
  }

  for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end

  vim.api.nvim_set_hl(0, 'StatusLine', { fg = 'NONE', bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = 'NONE', bg = 'NONE' })

  -- fungsi mode
  _G.RecolorMode = function()
    local mode = vim.fn.mode()
    local color_map = {
      n = { fg = '#5599e2', bg = '#171b24' },
      i = { fg = '#e34f4f', bg = '#171b24' },
      R = { fg = '#69bfce', bg = '#171b24' },
      v = { fg = '#e37e4f', bg = '#171b24' },
      V = { fg = '#e37e4f', bg = '#171b24' },
      [''] = { fg = '#e37e4f', bg = '#171b24' },
      c = { fg = '#5679e3', bg = '#171b24' },
      t = { fg = '#5679e3', bg = '#171b24' },
    }
    local hl = color_map[mode]
    if hl then
      vim.api.nvim_set_hl(0, 'ModeText', hl)
    end
    return ''
  end

  -- fungsi filetype
  _G.SetFiletype = function(filetype)
    return (filetype == nil or filetype == '') and 'unknown' or filetype
  end

  -- fungsi branch name
  _G.GetBranchName = function()
    local dir = vim.fn.expand '%:h'
    if vim.fn.finddir('.git', dir .. ';') == '' then
      return 'no-git'
    end

    local handle = io.popen('git -C ' .. vim.fn.shellescape(dir) .. ' branch --show-current 2>/dev/null')
    local result = handle and handle:read '*a' or ''
    if handle then
      handle:close()
    end

    return vim.trim(result) ~= '' and vim.trim(result) or 'no-branch'
  end

  -- fungsi column gap
  _G.HandleColumnGap = function()
    local col = vim.fn.col '.'
    return col > 9 and '✖ ' or '✖'
  end

  -- definisi statusline
  vim.opt.statusline = table.concat {
    '%{%v:lua.RecolorMode()%}',

    '%#Separator#█',
    '%#ModeText#',
    '%#Separator#██',

    "%#PathText#%{expand('%:p:h:t')}",
    '%#Separator#██',
    '%#FileText#%t',
    '%#Separator#',

    '%=',

    '%#Separator#',
    '%#FileType#%{v:lua.SetFiletype(&filetype)}',
    '%#Separator# ',

    '%#Separator#',
    '%#BranchName#%{v:lua.GetBranchName()}',
    '%#Separator# ',

    '%#Separator#',
    '%#LineText#%2l',
    '%#Separator#█',
    '%#Separator2#%{v:lua.HandleColumnGap()}',
    '%#ColumnText#%2c',

    '%#Separator2#',
    '%#Separator#██',
    '%#PercentageText#%p%%',
    '%#Separator#█',
    '%#Separator2#',
    '%#Separator#█',
    '%#TotalLineText#%L',
    '%#Separator#█',
  }
end

-- panggil sekali saat startup
set_statusline_highlights()

-- panggil ulang setiap ganti colorscheme
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = set_statusline_highlights,
})
