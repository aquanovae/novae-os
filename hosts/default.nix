# ------------------------------------------------------------------------------
# Import host specific configuration
# ------------------------------------------------------------------------------
{ hostname, ... }: {

  imports = [
    ./${hostname}
  ];

  networking.hostName = "${hostname}";
}
