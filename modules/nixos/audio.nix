{ ... }: {

  flake.nixosModules.audio = { pkgs, ... }: let

    audiomixer = pkgs.writeShellScript "audiomenu" ''
      hyprctl dispatch resizewindowpixel "exact 75% 75%, title:launcher"
      wiremix
    '';

  in {

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };

    environment.systemPackages = [ pkgs.wiremix ];

    programs.otter-launcher.settingsExtra = /*toml*/ ''
      
      [[modules]]
      description = "audio mixer"
      prefix = "am"
      cmd = "${audiomixer}"
    '';
  };
}
