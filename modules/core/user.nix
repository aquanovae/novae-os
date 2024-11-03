# ------------------------------------------------------------------------------
# Create main user
# ------------------------------------------------------------------------------
{ pkgs, username, ... }: {

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };
}
