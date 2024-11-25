# ------------------------------------------------------------------------------
# Nvidia configuration for laptop
# ------------------------------------------------------------------------------
{ config, lib, ... }: {

  config = lib.mkIf config.ricos.hardware.nvidia.enable {
    hardware.nvidia = {
      # Enable nvidia drivers
      open = true;
      modesetting.enable = true;
      powerManagement.enable = true;
      nvidiaSettings = true;

      # Fix new drivers not building
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "555.58.02";
        sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
        sha256_aarch64 = "sha256-wb20isMrRg8PeQBU96lWJzBMkjfySAUaqt4EgZnhyF8=";
        openSha256 = "sha256-8hyRiGB+m2hL3c9MDA/Pon+Xl6E788MZ50WrrAGUVuY=";
        settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
        persistencedSha256 = "sha256-a1D7ZZmcKFWfPjjH1REqPM5j/YLWKnbkP9qfRyIyxAw=";
      };

      # Use dedicated nvidia GPU for 3D acceleration
      prime = {
        sync.enable = true;
        amdgpuBusId = "PCI:5:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    boot = {
      # Load GPU drivers on boot
      kernelModules = [
        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ];

      kernelParams = [
        "nvidia_drm.modeset=1"
      ];
    };

    # Pass GPU drivers to wayland
    # Confusing naming indeed
    services.xserver.videoDrivers = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];
  };
}
