{ config, lib, pkgs, ... }: let

  cfg = config.novaeOs.programs;

in {

  imports = [
    ./alacritty.nix
    ./coolercontrol.nix
    ./openrgb.nix
    ./nvim
    ./ranger.nix
    ./spotify.nix
    ./syncthing
  ];

  environment.systemPackages = with pkgs; [
    jq
    gh
    git
  ] ++ lib.optionals cfg.circuitsApps.enable [
    kicad
    logisim-evolution
  ] ++ lib.optionals cfg.discord.enable [
    discord
  ] ++ lib.optionals cfg.documentEditingApps.enable [
    onlyoffice-desktopeditors
    pdfarranger
  ] ++ lib.optionals cfg.imageEditingApps.enable [
    inkscape
    gimp
  ] ++ lib.optionals cfg.vscode.enable [
    vscode
  ];

  programs = {
    steam.enable = cfg.steam.enable;
  };
}
