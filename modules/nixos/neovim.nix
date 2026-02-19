{ ... }: {

  flake.nixosModules.neovim = { ... }: {

    programs.nixvim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;

      colorschemes.moonfly.enable = true;

      globals = {
        mapleader = " ";
      };

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

      autoCmd = [
        { command = "Neotree show";
          event = "VimEnter";
        }
      ];


      plugins.lsp.enable = true;
      plugins.lsp.servers = {
        nixd.enable = true;
        wgsl_analyzer.enable = true;
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
          installRustfmt = false;
        };
      };


      plugins.cmp = {
        enable = true;
        autoEnableSources = true;
      };
      plugins.cmp.settings.view.docs.auto_open = false;
      plugins.cmp.settings. sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
      ];
      plugins.cmp.settings.mapping = {
        "<S-CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
      };


      plugins.lualine.enable = true;
      plugins.lualine.settings.sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "diagnostics" ];
        lualine_c = [ "filename" ];
        lualine_x = [ "filetype" ];
        lualine_y = [ "lsp_status" ];
        lualine_z = [ "location" ];
      };


      plugins.neo-tree.enable = true;
      plugins.neo-tree.settings = {
        close_if_last_window = true;
        enable_git_status = false;
        window.width = 50;
        filesystem = {
          use_libuv_file_watcher = true;
          follow_current_file.enabled = true;
          follow_current_file.leave_dirs_open = true;
        };
      };


      plugins.toggleterm.enable = true;
      plugins.toggleterm.settings = {
        open_mapping = "[[<C-j>]]";
        direction = "float";
        float_opts.border = "curved";
      };


      plugins.telescope.enable = true;
      plugins.telescope.keymaps = {
        "<leader>s" = "find_files";
      };


      plugins.treesitter.enable = true;
      plugins.treesitter.settings.highlight.enable = true;
      plugins.treesitter-context.enable = true;


      plugins.indent-blankline.enable = true;
      plugins.indent-blankline.settings = {
        indent.char = "┃";
        scope.enabled = false;
      };


      plugins.mini-icons = {
        enable = true;
        mockDevIcons = true;
      };


      plugins.tiny-inline-diagnostic.enable = true;


      dependencies = {
        fd.enable = true;
        gcc.enable = true;
        ripgrep.enable = true;
        tree-sitter.enable = true;
      };
    };
  };
}
