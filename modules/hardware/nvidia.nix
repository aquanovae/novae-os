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
