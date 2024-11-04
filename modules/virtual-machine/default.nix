# ------------------------------------------------------------------------------
# Virtual machine configuration
# ------------------------------------------------------------------------------
{ config, lib, pkgs, username, ... }:

let
  cfg = config.ricos.virtualMachine;

  qemuOptions = lib.concatStringsSep " " [
    "-machine q35,kernel_irqchip=on"
    "-accel kvm"
    "-cpu host,kvm=off"

    # Vm hardware settings
    "-smp ${cfg.coreCount}"
    "-m ${cfg.memory}"
    "-device virtio-vga,edid=on,xres=1904,yres=1023"
    "-display none"

    # Memory device for looking glass
    "-device ivshmem-plain,memdev=ivshmem,bus=pcie.0"
    "-object memory-backend-file,id=ivshmem,share=on,mem-path=/dev/shm/looking-glass,size=32M"

    # Spice server for passing inputs to looking glass
    "-spice port=5900,disable-ticketing=on"
    "-device virtio-serial"
    "-device virtio-mouse-pci"
    "-device virtio-keyboard-pci"

    # Clipboard sharing through spice
    "-chardev spicevmc,id=vdagent,debug=0,name=vdagent"
    "-device virtserialport,chardev=vdagent,name=com.redhat.spice.0"

    # UEFI boot
    "-drive if=pflash,format=raw,readonly=on,file=/tmp/OVMF_CODE.fd"
    "-drive if=pflash,format=raw,file=/tmp/OVMF_VARS.ms.fd"

    # Host guest file share
    "-nic user,id=nic0,smb=/home/${username}/rstore"

  ] ++ lib.optionals cfg.gpuPassthrough.enable [
    "-device vfio-pci,host=${cfg.gpuPassthrough.gpuPciId}"

  ] ++ lib.optionals cfg.gpuPassthrough.fakeBattery.enable [
    "-acpitable file=/home/${username}/vm/battery.dat"
  ];

  diskPath = "/home/${username}/vm/win-10";

  # Script to launch vm
  vm-launch-script = pkgs.writeShellScriptBin "windows-vm" ''
    qemu-system-x86_64  ${qemuOptions} ${diskPath} &
    sleep 1
    looking-glass-client
  '';

  # Create desktop file for script
  vm-desktop-file = pkgs.makeDesktopItem {
    name = "windows-vm";
    desktopName = "windows-vm";
    type = "Application";
    exec = "${vm-launch-script}/bin/windows-vm";
    terminal = false;
  };
in {

  imports = [
    ./looking-glass.nix
  ];

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.OVMFFull
      (pkgs.qemu.override {
        smbdSupport = true;
      })
      vm-launch-script
      vm-desktop-file
    ];

    # Capture GPU on boot
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

    # Unlock memory limit needed for passthrough
    security.pam.loginLimits = lib.mkIf cfg.gpuPassthrough.enable [{
      domain = "*";
      type = "-";
      item = "memlock";
      value = "unlimited";
    }];

    systemd.tmpfiles.rules = [
      # Create temp files for UEFI boot
      "C /tmp/OVMF_VARS.ms.fd 0600 ${username} users - ${pkgs.OVMFFull.fd}/FV/OVMF_VARS.ms.fd"
      "C /tmp/OVMF_CODE.fd 0600 ${username} users - ${pkgs.OVMFFull.fd}/FV/OVMF_CODE.fd"

    ] ++ lib.optionals cfg.gpuPassthrough.enable [
      # Give user permission to GPU
      "z /dev/vfio/11 - ${username} users -"
    ];

    home-manager.users.${username} = {
      home = lib.mkIf cfg.gpuPassthrough.fakeBattery.enable {
        file."vm/battery.dat".source = ./fake-battery.dat;
      };
    };
  };
}
