{ ... }: {

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    colorschemes.moonfly.enable = true;

    autoCmd = [
      { command = "Neotree show";
        event = "VimEnter";
      }
    ];

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
          mapping = {
            "<S-CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
        };
      };

      lualine = {
        enable = true;
        settings.sections = {
          lualine_a = [ "mode" ];
          lualine_b = [ "diagnostics" ];
          lualine_c = [ "filename" ];
          lualine_x = [ "filetype" ];
          lualine_y = [ "lsp_status" ];
          lualine_z = [ "location" ];
        };
      };

      neo-tree = {
        enable = true;
        settings = {
          close_if_last_window = true;
          enable_git_status = false;
          window.width = 50;
          filesystem = {
            use_libuv_file_watcher = true;
            follow_current_file = {
              enabled = true;
              leave_dirs_open = true;
            };
          };
        };
      };

      toggleterm = {
        enable = true;
        settings = {
          open_mapping = "[[<C-j>]]";
          direction = "float";
          float_opts.border = "curved";
        };
      };

      tiny-inline-diagnostic.enable = true;

      telescope = {
        enable = true;
        keymaps = {
          "<leader>s" = "find_files";
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
