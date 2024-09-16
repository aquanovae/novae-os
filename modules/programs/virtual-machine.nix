{ config, lib, username, ... }: {

  config = lib.mkIf config.ricos.programs.virtualisationApps.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        ovmf.enable = true;
      };
    };

    programs.virt-manager.enable = true;

    home-manager.users.${username}.dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };

    users.users.${username}.extraGroups = [ "libvirtd" ];
  };
}
