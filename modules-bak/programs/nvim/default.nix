{ username, ... }: {

  imports = [
    ./plugins.nix
    ./syntax.nix
  ];

  home-manager.users.${username}.programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = /*lua*/ ''
      local o = vim.o
      local opt = vim.opt

      -- Current line information
      opt.number = true
      opt.relativenumber = true
      opt.cursorline = true

      -- Indentation
      opt.tabstop = 2
      opt.shiftwidth = 2
      opt.softtabstop = 2
      opt.expandtab = true
      opt.autoindent = true
      opt.smartindent = true

      -- Search highlight
      opt.hlsearch = false
      opt.incsearch = true

      -- Layout
      opt.scrolloff = 13
      opt.wrap = false

      -- Key bindings
      vim.g.mapleader = " "
      vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
    '';
  };
}
