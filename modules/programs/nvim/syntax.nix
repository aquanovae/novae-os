{ username, ... }: {

  home-manager.users.${username}.programs.neovim.extraLuaConfig = /*lua*/ ''
    local opt = vim.opt

    vim.hl = vim.highlight
    opt.syntax = enable
    opt.termguicolors = true

    require("treesitter-context").setup()
    require("nvim-treesitter.configs").setup {
      auto_install = false,
      highlight = { enable = true },
    }

    require("onedark").setup {
      style = "darker",
      transparent = true,
      term_colors = false,

      code_style = { keywords = "bold" },

      highlights = {
        ["@keyword"] = { fg = "$red", fmt = "bold" },
        ["@keyword.import"] = { fg = "$red", fmt = "bold" },
        ["@keyword.function"] = { fg = "$red", fmt = "bold" },
        ["@keyword.modifier"] = { fg = "$red", fmt = "bold" },
        ["@keyword.type"] = { fg = "$red", fmt = "bold" },
        ["@lsp.mod.attribute"] = { fg = "$purple" },
        ["@lsp.mod.crateRoot"] = { fg = "$yellow" },
        ["@lsp.type.enum"] = { fg = "$fg", fmt = "bold,italic" },
        ["@lsp.type.enumMember"] = { fg = "$light_grey" },
        ["@lsp.typemod.keyword.constant"] = { fg = "$red", fmt = "bold" },
        ["@lsp.type.parameter"] = { fg = "$fg", fmt = "italic" },
        ["@lsp.type.struct"] = { fg = "$fg", fmt = "bold,italic" },
        ["@operator"] = { fg = "$cyan" },
        ["@type"] = { fg = "$fg", fmt = "bold,italic" },
        ["@variable.builtin"] = { fg = "$yellow", fmt = "italic" },
        ["@variable.parameter"] = { fg = "$fg", fmt = "italic" },

        ["@function.builtin.bash"] = { fg = "$yellow" },
        ["@function.call.bash"] = { fg = "$yellow" },
        ["@function.bash"] = { fg = "$yellow" },

        ["@variable.member.nix"] = { fg = "$blue" },
        ["@variable.nix"] = { fg = "$fg", fmt = "italic" },

        ["@attribute.wgsl"] = { fg = "$purple" },
      },
    }
    require("onedark").load()
  '';
}
