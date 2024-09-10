{ ... }: {

  networking.wireless = {
    enable = false;
    iwd.enable = true;
  };
}
