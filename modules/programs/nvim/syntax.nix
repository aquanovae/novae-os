{ username, ... }: {

  home-manager.users.${username}.programs.neovim.extraLuaConfig = /*lua*/ ''
    local opt = vim.opt

    vim.hl = vim.highlight
    opt.syntax = enable
    opt.termguicolors = true

    vim.g.moonflyTransparent = true
    vim.cmd [[ colorscheme moonfly ]]

    require("treesitter-context").setup()
    require("nvim-treesitter.configs").setup {
      auto_install = false,
      highlight = { enable = true },
    }
  '';
}
