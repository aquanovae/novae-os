local theme = {
    CurSearch = { bg = "${yellow}", fg = "${bg0}" },
    Cursor = { bg = "${fg}", fg = "${bg0}" },
    CursorLine = { bg = "${bg1}" },
    Directrory = { fg = "${blue}" },
    EndOfBuffer = { fg = "${bg1}" },
    ErrorMsg = { fg = "${red}" },
    WinSeparator = { bg = "${bg2}", fg = "${bg2}" },
    SignColumn = { bg = "${bg0}" },
    IncSearch = { bg = "${yellow}", fg = "${bg0}" },
    Substitute = { bg = "${yellow}", fg = "${bg0}" },
    LineNr = { bg = "${bg1}", fg = "${fg}" },
    CursorLineNr = { bg = "${bg0}", fg = "${fg}", bold = true },
    MatchParen = { bg = "${yellow}", fg = "${bg0}", bold = true },
    ModeMsg = { fg = "${fg}", bold = true },
    Pmenu = { bg = "${bg1}" , fg = "${fg}" },
    PmenuSel = { bg = "${bg2}", fg = "${fg}", bold = true },
    PmenuSbar = { bg = "${bg2}" },
    PmenuThumb = { bg = "${white}" },
    StatusLine = { bg = "${bg1}", fg = "${blue}", bold = true},
    StatusLineNC = { bg = "${bg1}", fg = "${bg2}" },
    TabLine = { bg = "${bg1}" },
    TabLineFill = { bg = "${bg0}" },
    TabLineSel = { bg = "${blue}", fg = "${bg0}", bold = true },
    Visual = { bg = "${bg2}" },
    WarningMsg = { fg = "${yellow}" },
}

local syntax = {
    Comment = { fg = "${gray}" },
    Constant = { fg = "${yellow}" },
    String = { fg = "${green}" },
    Identifier = { fg = "${fg}" },
    Function = { fg = "${blue}" },
    Statement = { fg = "${red}", bold = true },
    Conditional = { fg = "${magenta}", bold = true },
    Repeat = { fg = "${magenta}", bold = true },
    Label = { fg = "${magenta}", bold = true },
    Operator = { fg = "${cyan}" },
    PreProc = { fg = "${magenta}", bold = true },
    Type = { fg = "${magenta}" },
    StorageClass = { fg = "${red}" },
    Structure = { fg = "${red}" },
    Typedef = { fg = "${red}" },
    Special = { fg = "${cyan}" },
    Delimiter = { fg = "${fg}" },
}

function highlight(groups)
    for group, hl in pairs(groups) do
        vim.api.nvim_set_hl(0, group, hl)
    end
end

vim.opt.termguicolors = true

highlight(theme)
highlight(syntax)
