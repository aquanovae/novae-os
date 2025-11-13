{ pkgs, ... }: {

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    neofetch
    tree
    unzip
  ];

  programs = {
    ssh.startAgent = true;
    htop.enable = true;
  };
}
