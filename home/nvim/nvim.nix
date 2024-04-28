{ config, pkgs, ... }: {

  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      onedark-nvim
      nvim-treesitter.withAllGrammars
      telescope-nvim
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./init.lua}
      ${builtins.readFile ./plugins/onedark.lua}
      ${builtins.readFile ./plugins/treesitter.lua}
      ${builtins.readFile ./plugins/telescope.lua}
    '';

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
