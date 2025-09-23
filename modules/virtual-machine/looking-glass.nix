{ config, lib, username, ... }: {

  config = lib.mkIf config.novaeOs.virtualMachine.enable {
    home-manager.users.${username}.programs.looking-glass-client = {
      enable = true;

      settings = {
        input = {
          escapeKey = "KEY_INSERT";
          ignoreWindowsKeys = true;
          grabKeyboard = false;
          captureOnFocus = true;
          rawMouse = false;
        };

        win = {
          title = "windows-vm";
          alerts = false;
          quickSplash = false;
          ignoreQuit = true;
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
