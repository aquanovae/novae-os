{ config, pkgs, ... }: {

  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      nvim-treesitter.withAllGrammars
    ];

    extraLuaConfig = with config.colors; ''
      ${builtins.readFile ./init.lua}
      ${builtins.readFile ./colors.lua}
      ${builtins.readFile ./plugins/telescope.lua}
      ${builtins.readFile ./plugins/treesitter.lua}
    '';

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
