{ ... }: {

  networking.wireless.iwd = {
    enable = true;
    settings = {
      Security = {
        PreSharedKey = "1b753ca34af52105bb2454cf997889b639e161dc2d851be0c58b450610e63c4c";
      };

      Settings = {
        AutoConnect = true;
      };
    };
  };
}
