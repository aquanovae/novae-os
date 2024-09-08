{ pkgs, ... }: {

  boot = {
    initrd.kernelModules = [
      "vfio-pci"
      "vfio"
      "vfio_iommu_type1"
    ];
    kernelParams = [
      "vfio-pci.ids=1002:164e"
    ];
  };

  environment.systemPackages = with pkgs; [
    OVMF
    pciutils
    qemu
    (writeShellScriptBin "windows-vm" ''
      qemu-system-x86_64 \
        -machine q35 \
        -accel kvm \
        -cpu host,topoext,kvm=off \
        -smp 12,sockets=1,cores=6,threads=2 \
        -m 16G \
        -drive file=/dev/nvme1n1,if=virtio
    '')
  ];
}
