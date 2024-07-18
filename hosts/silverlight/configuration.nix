{ inputs, pkgs, ... }: {

  imports = [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    users = {
      "rico" = import ./../../modules/home/home.nix;
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    alacritty
    bemenu
    firefox
    gh
    git
    libsForQt5.qt5.qtwayland
    libsForQt5.qt5ct
    looking-glass-client
    lutris
    neovim
    openal
    pciutils
    prismlauncher
    qemu_kvm
    spotify
    starship
    swaybg
  ];


  programs = {
    coolercontrol.enable = true;
    htop.enable = true;
    hyprland.enable = true;
    steam.enable = true;
    waybar.enable = true;
    xwayland.enable = true;
    zsh.enable = true;
  };


  hardware = {
    graphics.enable = true;
    i2c.enable = true;
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };
  };


  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
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
    
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 1;
      grub = {
        enable = true;
	      efiSupport = true;
	      device = "nodev";
        useOSProber = true;
      };
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
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
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


  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "fr_CH";


  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      displayManager.gdm.enable = true;
    };

    displayManager.autoLogin = {
      enable = true;
      user = "rico";
    };

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


  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [ "JetBrainsMono" ];
    })
  ];


  users.users.rico = {
    isNormalUser = true;
    extraGroups = [ "wheel" "i2c" "libvirtd" ];
    shell = pkgs.zsh;
  };

  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };
  programs.virt-manager.enable = true;


  system.stateVersion = "24.05";
}
