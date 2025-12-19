{ nixvimLib, ... }: {

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    colorschemes.moonfly.enable = true;

    opts = {
      number = true;
      relativenumber = true;
      cursorline = true;
      signcolumn = "yes";

      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 2;
      expandtab = true;
      autoindent = true;
      smartindent = true;

      hlsearch = false;
      incsearch = true;

      scrolloff = 13;
      wrap = false;

      syntax = "enable";
      termguicolors = true;
    };

    globals = {
      mapleader = " ";
    };

    keymaps = with nixvimLib.nixvim; [
      { key = "<leader>e";
        action = mkRaw "vim.cmd.Ex";
        mode = "n";
      }
    ];

    plugins = {
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
            installRustfmt = false;
          };
          wgsl_analyzer.enable = true;
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          view.docs.auto_open = false;
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
        };
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader>s" = "find_files";
        };
      };

      trouble = {
        enable = true;
        settings = {
          modes.diagnostics.auto_open = true;
          auto_close = true;
        };
      };

      treesitter = {
        enable = true;
        settings.highlight.enable = true;
      };

      treesitter-context = {
        enable = true;
      };

      indent-blankline = {
        enable = true;
        settings = {
          indent.char = "┃";
          scope.enabled = false;
        };
      };

      mini-icons = {
        enable = true;
        mockDevIcons = true;
      };
    };

    dependencies = {
      fd.enable = true;
      gcc.enable = true;
      ripgrep.enable = true;
      tree-sitter.enable = true;
    };
  };
}
