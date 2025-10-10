{ extraPkgs, pkgs, username, ... }: {

  config = {
    environment.systemPackages = with pkgs; with extraPkgs; [
      freerdp
      winboat
    ];

    virtualisation.docker.enable = true;

    users.users.${username}.extraGroups = [ "docker" ];
  };
}
