{ pkgs, ... }: {

  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      indent-blankline-nvim
      lsp-zero-nvim
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-treesitter-context
      onedark-nvim
      otter-nvim
      rustaceanvim
      telescope-nvim
    ];

    extraPackages = with pkgs; [
      nixd
      rust-analyzer
    ];

    extraLuaConfig = /*lua*/ ''
      local o = vim.o
      local opt = vim.opt

      opt.syntax = enable
      opt.termguicolors = true

      opt.number = true
      opt.relativenumber = true
      opt.cursorline = true

      opt.tabstop = 2
      opt.shiftwidth = 2
      opt.softtabstop = 2
      opt.expandtab = true
      opt.autoindent = true
      opt.smartindent = true

      opt.hlsearch = false
      opt.incsearch = true

      opt.scrolloff = 13
      opt.wrap = false

      vim.g.mapleader = " "
      vim.keymap.set("n", "<leader>e", vim.cmd.Ex)


      require("onedark").setup {
        style = "darker",
        transparent = true,
        term_colors = false,
      }
      require("onedark").load()

      require("ibl").setup {
        scope = {
          enabled = false,
        },
      }

      require("treesitter-context").setup()
      require("nvim-treesitter.configs").setup {
        auto_install = false,

        highlight = {
          enable = true,
        },
      }

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>s", builtin.find_files, {})

      require("lsp-zero")
      require("lspconfig").nixd.setup {}
      --require("otter").activate("rust", true, true, nil)
    '';

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
