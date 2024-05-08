{ config, pkgs, ... }: {

  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      indent-blankline-nvim
      lsp-zero-nvim
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-treesitter-context
      onedark-nvim
      telescope-nvim
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./init.lua}
      ${builtins.readFile ./plugins.lua}
    '';

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
