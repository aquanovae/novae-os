{ ... }: {

  flake.nixosModules.wireless = { pkgs, ... }: let
    
    wirelessmenu = pkgs.writeShellScript "wirelessmenu" ''
      hyprctl dispatch resizewindowpixel "exact 75% 75%, title:launcher"
      impala
    '';

  in {

    networking.wireless = {
      enable = false;
      iwd.enable = true;
    };

    environment.systemPackages = [ pkgs.impala ];

    programs.otter-launcher.settingsExtra = /*toml*/ ''
      
      [[modules]]
      description = "wireless menu"
      prefix = "wl"
      cmd = "${wirelessmenu}"
    '';
  };
}
