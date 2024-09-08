{ pkgs, username, ... }: {

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

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      pacakges = [ pkgs.qemu_kvm ];
      ovmf.enable = true;
    };
  };

  programs.virt-manager.enable = true;

  home-manager.users.${username}.dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  users.users.${username}.extraGroups = [ "libvirtd" ];

  environment.systemPackages = with pkgs; [
    pciutils
  ];
}
