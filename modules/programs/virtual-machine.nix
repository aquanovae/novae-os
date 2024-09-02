{ pkgs, ... }: {

  environment.systemPackages = with pkgs; [
    qemu
    (pkgs.writeShellScriptBin "windows-vm" ''
      qemu-system-x86_64 \
        -machine q35 \
        -accel kvm \
        -cpu host,kvm=off \
        -smp 12,sockets=1,cores=6,threads=2 \
        -m 12G \
    '')
  ];
}
