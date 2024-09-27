{ config, lib, pkgs, ... }: {

  config = lib.mkIf config.ricos.programs.virtualisationApps.enable {
    environment.systemPackages = with pkgs; [
      qemu
      (writeShellScriptBin "windows-vm" ''
        qemu-system-x86_64 \
          -machine q35 \
          -accel kvm \
          -cpu host \
          -smp 12,sockets=1,cores=6,threads=2 \
          -m 12G \
      '')
    ];
  };
}
