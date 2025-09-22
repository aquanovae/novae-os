{ config, inputs, lib, pkgs, username, ... }: {

  config = lib.mkIf config.novaeOs.virtualMachine.enable {
    home-manager.users.${username}.programs.looking-glass-client = {
      enable = true;

      settings = {
        input = {
          escapeKey = "KEY_INSERT";
          ignoreWindowsKeys = true;
          grabKeyboard = false;
          autoCapture = true;
          captureOnFocus = true;
        };

        egl.vsync = true;
        opengl.vsync = true;
      };
    };

    environment.systemPackages = [ config.boot.kernelPackages.kvmfr ];

    # Give user access to shared memory file
    systemd.tmpfiles.rules = [
      "f /dev/shm/looking-glass 0660 ${username} users -"
    ];
  };
}
