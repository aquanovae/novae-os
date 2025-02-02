# ------------------------------------------------------------------------------
# Neovim configuration
# ------------------------------------------------------------------------------
{ pkgs, username, ... }: {

  home-manager.users.${username}.programs.neovim = {

    enable = true;

    # Install plugins
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
      wgsl-vim
    ];

    # Programs required by plugins
    extraPackages = with pkgs; [
      cargo
      ccls
      nixd
      rustc
      rust-analyzer
      wgsl-analyzer
    ];

    # Nvim config
    extraLuaConfig = /*lua*/ ''

      local o = vim.o
      local opt = vim.opt

      vim.hl = vim.highlight

      -- Syntax
      opt.syntax = enable
      opt.termguicolors = true

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

      -- Theme
      require("onedark").setup {
        style = "darker",
        transparent = true,
        term_colors = false,

        code_style = {
          keywords = "bold",
        },

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
          ["@lsp.type.parameter"] = { fg = "$fg", fmt = "italic" },
          ["@lsp.type.struct"] = { fg = "$fg", fmt = "bold,italic" },
          ["@operator"] = { fg = "$cyan" },
          ["@type"] = { fg = "$fg", fmt = "bold,italic" },
          ["@variable.parameter"] = { fg = "$fg", fmt = "italic" },

          ["@variable.member.nix"] = { fg = "$blue" },
          ["@attribute.wgsl"] = { fg = "$purple" },
        },
      }
      require("onedark").load()

      -- Indentation lines
      require("ibl").setup {
        scope = {
          enabled = false,
        },
      }

      -- Syntax highlighting
      require("treesitter-context").setup()
      require("nvim-treesitter.configs").setup {
        auto_install = false,

        highlight = {
          enable = true,
        },
      }

      -- Fuzzy file finder
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>s", builtin.find_files, {})

      -- LSP
      require("lsp-zero")
      require("lspconfig").ccls.setup {}
      require("lspconfig").nixd.setup {}
      require("lspconfig").wgsl_analyzer.setup {}
    '';

    # Make nvim default
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
