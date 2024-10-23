{ config, lib, pkgs, username, ... }:

let
  diskPath = "/home/${username}/vm/win-10";

  launch-script = pkgs.writeShellScriptBin "windows-vm" ''
    qemu-system-x86_64 \
      -machine q35,kernel_irqchip=on \
      -accel kvm \
      -cpu host,kvm=off \
      -smp 12 \
      -m 10G \
      -vga virtio \
      -display none \
      -device vfio-pci,host=01:00.0 \
      -acpitable file=/home/rico/vm/battery.dat \
      -device ivshmem-plain,memdev=ivshmem,bus=pcie.0 \
      -object memory-backend-file,id=ivshmem,share=on,mem-path=/dev/shm/looking-glass,size=32M \
      -spice port=5900,disable-ticketing=on \
      -device virtio-serial \
      -chardev spicevmc,id=vdagent,debug=0,name=vdagent \
      -device virtserialport,chardev=vdagent,name=com.redhat.spice.0 \
      -device virtio-mouse-pci \
      -device virtio-keyboard-pci \
      -drive if=pflash,format=raw,readonly=on,file=/tmp/OVMF_CODE.fd \
      -drive if=pflash,format=raw,file=/tmp/OVMF_VARS.ms.fd \
      ${diskPath} &

    sleep 1
    looking-glass-client
  '';
in {

  imports = [
    ./looking-glass.nix
  ];

  config = lib.mkIf config.ricos.programs.virtualisationApps.enable {
    environment.systemPackages = [
      pkgs.OVMFFull
      pkgs.qemu
      launch-script
    ];

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
      "C /tmp/OVMF_VARS.ms.fd 0600 ${username} users - ${pkgs.OVMFFull.fd}/FV/OVMF_VARS.ms.fd"
      "C /tmp/OVMF_CODE.fd 0600 ${username} users - ${pkgs.OVMFFull.fd}/FV/OVMF_CODE.fd"
      "z /dev/vfio/11 - ${username} users -"
    ];
  };
}
