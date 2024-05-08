{ config, lib, pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
  ];


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    alacritty
    bemenu
    firefox
    gh
    git
    imagemagick
    neovim
    starship
    swaybg
    wget
    zsh
  ];


  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      nvidiaSettings = true;
      prime = {
        sync.enable = true;
        amdgpuBusId = "PCI:5:0:0";
	      nvidiaBusId = "PCI:1:0:0";
      };
    };
  };


  fileSystems = let options = {
    options = [ "noatime" "ssd" "discard" ];
  }; in {
    "/" = options;
    "/nix" = options;
    "/home" = options;
    "/home/rico/rstore" = options;
  };


  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [
      "amdgpu"
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "nvidia_drm.modeset=1"
    ];

    initrd = {
      systemd.enable = true;
      luks.devices."root".allowDiscards = true;
      supportedFilesystems = [ "btrfs" ];
      verbose = false;
    };
    
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 1;
      grub = {
        enable = true;
	      efiSupport = true;
	      device = "nodev";
        font = "${pkgs.nerdfonts}/share/fonts/truetype/NerdFonts/JetBrainsMonoNerdFont-Regular.ttf";
        splashImage = /home/rico/rstore/ricos/home/theme/grub-background.png;
      };
    };

    plymouth = {
      enable = true;
      font = "${pkgs.nerdfonts}/share/fonts/truetype/NerdFonts/JetBrainsMonoNerdFont-Regular.ttf";
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
  };


  networking = {
    hostName = "zenblade";
    wireless.iwd.enable = true;
  };


  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "fr_CH";


  services = {
    xserver = {
      enable = true;
      videoDrivers = [
        "amdgpu"
	      "nvidia"
	      "nvidia_modeset"
	      "nvidia_uvm"
	      "nvidia_drm"
      ];

      displayManager.gdm.enable = true;
    };

    displayManager.autoLogin = {
      enable = true;
      user = "rico";
    };

    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
	      support32Bit = true;
      };
    };

    printing.enable = true;
  };


  programs = {
    hyprland.enable = true;
    zsh.enable = true;
  };


  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [ "JetBrainsMono" ];
    })
  ];


  users.users.rico = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };


  system.stateVersion = "23.11";
}

