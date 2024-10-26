{ config, lib, pkgs, username, ... }:

let
  cfg = config.ricos.virtualMachine;

  options = [
    "-machine q35,kernel_irqchip=on"
    "-accel kvm"
    "-cpu host,kvm=off"
    "-smp ${cfg.coreCount}"
    "-m ${cfg.memory}"
    "-device virtio-vga,edid=on,xres=1904,yres=1023"
    "-display none"
    "-device ivshmem-plain,memdev=ivshmem,bus=pcie.0"
    "-object memory-backend-file,id=ivshmem,share=on,mem-path=/dev/shm/looking-glass,size=32M"
    "-spice port=5900,disable-ticketing=on"
    "-device virtio-serial"
    "-chardev spicevmc,id=vdagent,debug=0,name=vdagent"
    "-device virtserialport,chardev=vdagent,name=com.redhat.spice.0"
    "-device virtio-mouse-pci"
    "-device virtio-keyboard-pci"
    "-drive if=pflash,format=raw,readonly=on,file=/tmp/OVMF_CODE.fd"
    "-drive if=pflash,format=raw,file=/tmp/OVMF_VARS.ms.fd"

  ] ++ lib.optionals cfg.gpuPassthrough.enable [
    "-device vfio-pci,host=${cfg.gpuPassthrough.gpuPciId}"

  ] ++ lib.optionals cfg.gpuPassthrough.fakeBattery.enable [
    "-acpitable file=/home/rico/vm/battery.dat"
  ];

  qemuOptions = "${lib.strings.concatStringsSep " " options}";

  diskPath = "/home/${username}/vm/win-10";

  launch-script = pkgs.writeShellScriptBin "windows-vm" ''
    qemu-system-x86_64  ${qemuOptions} ${diskPath} &
    sleep 1
    looking-glass-client
  '';
in {

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.OVMFFull
      pkgs.qemu
      launch-script
    ];

    boot = lib.mkIf cfg.gpuPassthrough.enable {
      initrd.kernelModules = [
        "vfio-pci"
        "vfio"
        "vfio_iommu_type1"
      ];
      kernelParams = [
        "vfio-pci.ids=${cfg.gpuPassthrough.gpuId}"
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
