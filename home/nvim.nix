{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    extraLuaConfig = "${builtins.readfile ./nvim/init.lua}";

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
