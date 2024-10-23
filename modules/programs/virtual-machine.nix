{ config, inputs, lib, pkgs, username, ... }:

let
  diskPath = "/home/${username}/vm/win-10";
in {

  config = lib.mkIf config.ricos.programs.virtualisationApps.enable {
    boot = {
      initrd.kernelModules = [
        "vfio-pci"
        "vfio"
        "vfio_iommu_type1"
      ];
      kernelParams = [
        "vfio-pci.ids=10de:25a0"
      ];
    };

    security.pam.loginLimits = [{
      domain = "*";
      type = "-";
      item = "memlock";
      value = "unlimited";
    }];

    systemd.tmpfiles.rules = [
      "C /tmp/OVMF_VARS.ms.fd 0600 rico users - ${pkgs.OVMFFull.fd}/FV/OVMF_VARS.ms.fd"
      "C /tmp/OVMF_CODE.fd 0600 rico users - ${pkgs.OVMFFull.fd}/FV/OVMF_CODE.fd"
      "z /dev/vfio/9 - rico users -"
      "f /dev/shm/looking-glass 0660 rico users -"
    ];

    environment.systemPackages = with pkgs; [
      (linuxKernel.packages.linux_zen.kvmfr.overrideAttrs {
        version = "experimental";
        src = inputs.looking-glass-experimental;
      })
      (looking-glass-client.overrideAttrs {
        version = "experimental";
        src = inputs.looking-glass-experimental;
        patches = [];
      })
      OVMFFull
      qemu
      (writeShellScriptBin "windows-vm" ''
        qemu-system-x86_64 \
          -machine q35,kernel_irqchip=on \
          -accel kvm \
          -cpu host,kvm=off \
          -smp 12 \
          -m 10G \
          -vga virtio \
          -display sdl \
          -device vfio-pci,host=01:00.0 \
          -acpitable file=/home/rico/vm/battery.dat \
          -drive if=pflash,format=raw,readonly=on,file=/tmp/OVMF_CODE.fd \
          -drive if=pflash,format=raw,file=/tmp/OVMF_VARS.ms.fd \
          -device ivshmem-plain,memdev=ivshmem,bus=pcie.0 \
          -object memory-backend-file,id=ivshmem,share=on,mem-path=/dev/shm/looking-glass,size=32M \
          ${diskPath}
      '')
    ];
  };
}
