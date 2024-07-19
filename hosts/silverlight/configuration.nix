{ inputs, pkgs, ... }: {

  imports = [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
  ];

  home-manager.users.rico = import ./../../modules/home/home.nix;

  environment.systemPackages = with pkgs; [
    alacritty
    firefox
    libsForQt5.qt5.qtwayland
    libsForQt5.qt5ct
    looking-glass-client
    lutris
    openal
    pciutils
    prismlauncher
    qemu_kvm
    spotify
  ];


  programs = {
    coolercontrol.enable = true;
    steam.enable = true;
  };


  hardware = {
    i2c.enable = true;
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };
  };


  boot = {
    kernelModules = [ 
      "amdgpu"
      "i2c-dev"
      "i2c-piix4"
    ];

    #extraModulePackages = with config.boot.kernelPackages; [
      #i2c-tools
    #];

    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "acpi_enforce_resources=lax"
    ];

    initrd = {
      systemd.enable = true;
      verbose = false;
    };
    
    plymouth = {
      enable = true;
      theme = "nixos-bgrt";
      themePackages = [
        pkgs.nixos-bgrt-plymouth
        (pkgs.adi1090x-plymouth-themes.override {
          selected_themes = [ "hexagon_hud" ];
        })
      ];
    };

    consoleLogLevel = 0;
  };


  systemd.services = {
    openrgb = {
      enable = true;
      postStart = ''
        sleep 5
        ${pkgs.openrgb}/bin/openrgb -p /home/rico/.config/OpenRGB/purple.orp
      '';
      preStop = "${pkgs.openrgb}/bin/openrgb -p /home/rico/.config/OpenRGB/off.orp";
    };
  };


  networking.hostName = "silverlight";

  services = {
    hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
      motherboard = "amd";
    };

    udev.packages = [
      pkgs.openrgb-with-all-plugins
    ];

    printing.enable = true;
  };


  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };
  programs.virt-manager.enable = true;


  system.stateVersion = "24.05";
}
