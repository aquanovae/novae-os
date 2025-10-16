{ config, extraPkgs, lib, pkgs, ... }: let

  cfg = config.novaeOs.programs;

in {

  imports = [
    ./alacritty.nix
    ./coolercontrol.nix
    ./openrgb.nix
    ./nvim
    ./ranger.nix
    ./starship.nix
    ./spotify.nix
    ./zsh.nix
  ];

  environment.systemPackages = with pkgs; [
    extraPkgs.spotify-manager
    jq
    gh
    git
    neofetch
    tree
    unzip
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
    htop.enable = true;
    steam.enable = cfg.steam.enable;
  };
}
