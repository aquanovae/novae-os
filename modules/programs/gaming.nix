{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    lutris
    prismlauncher
  ];

  programs.steam.enable = true;
}
