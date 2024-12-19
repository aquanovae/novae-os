# ------------------------------------------------------------------------------
# Looking glass configuration
# ------------------------------------------------------------------------------
{ config, lib, username, ... }: {

  config = lib.mkIf config.novaeOs.virtualMachine.enable {

    home-manager.users.${username}.programs.looking-glass-client = {
      enable = true;
      #package = looking-glass-client-experimental;

      # Looking glass app settings
      settings = {
        input = {
          escapeKey = "KEY_INSERT";
          ignoreWindowsKeys = true;
          grabKeyboard = false;
          autoCapture = true;
        };

        egl.vsync = true;
        opengl.vsync = true;
      };
    };

    environment.systemPackages = [
      #looking-glass-kvmfr-experimental
      config.boot.kernelPackages.kvmfr
    ];

    # Give user access to shared memory file
    systemd.tmpfiles.rules = [
      "f /dev/shm/looking-glass 0660 ${username} users -"
    ];
  };
}
