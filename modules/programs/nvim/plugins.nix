{ inputs, pkgs, username, ... }: let 

  moon-fly = pkgs.vimUtils.buildVimPlugin {
    name = "moon-fly";
    src = inputs.moon-fly;
  };

in {

  home-manager.users.${username}.programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      indent-blankline-nvim
      lsp-zero-nvim
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-treesitter-context
      moon-fly
      onedark-nvim
      otter-nvim
      telescope-nvim
      trouble-nvim
      wgsl-vim
    ];

    # Programs required by plugins
    extraPackages = with pkgs; [
      cargo
      ccls
      fd
      nixd
      python313Packages.python-lsp-server
      ripgrep
      rustc
      rust-analyzer
      wgsl-analyzer
    ];

    extraLuaConfig = /*lua*/ ''
      -- Indentation lines
      require("ibl").setup {
        scope = {
          enabled = false,
        },
      }

      -- Fuzzy file finder
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>s", builtin.find_files, {})

      -- LSP
      require("lsp-zero")
      require("lspconfig").ccls.setup {}
      require("lspconfig").nixd.setup {}
      require("lspconfig").pylsp.setup {}
      require("lspconfig").rust_analyzer.setup {}
      require("lspconfig").wgsl_analyzer.setup {}

      require("trouble").setup {}
      vim.keymap.set(
        "n",
        "<leader>t",
        "<cmd>Trouble diagnostics toggle<cr>",
        {}
      )
    '';
  };
}
