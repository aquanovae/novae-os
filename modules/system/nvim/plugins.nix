{ pkgs, ... }: {

  home-manager.users.rico.programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      indent-blankline-nvim
      lsp-zero-nvim
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-treesitter-context
      onedark-nvim
      rustaceanvim
      telescope-nvim
    ];

    extraPackages = with pkgs; [
      nixd
      rust-analyzer
    ];

    extraLuaConfig = /*lua*/ ''
      vim.opt.termguicolors = true

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
    '';
  };
}
