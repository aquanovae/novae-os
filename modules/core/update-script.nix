{ pkgs, username, ... }: let

  updateScript = pkgs.writeShellScriptBin "update-script" ''
    cd /home/${username}/novae-os && \
    echo -e "\e[1;32m-> \e[37mFetching git\e[0m" && \
    git fetch && \
    git pull --rebase && \
    echo -e "\e[1;32m-> \e[37mUpdating flake\e[0m" && \
    nix flake update --flake . 2>&1 | grep "Updated" | sed -e "s/• //" -e "s/://" && \
    echo -e "\n\e[1;32m-> \e[37mBuilding configuration\e[0m" && \
    sudo nixos-rebuild switch --impure --flake . --log-format bar && \
    echo -e "\n\e[1;32m-> \e[37mCleaning store\e[0m" && \
    echo -e "\e[1mSystem space:\e[0m" && \
    sudo nix-collect-garbage --delete-older-than 3d 2>&1 | grep "store paths deleted" && \
    echo -e "\n\e[1mUser space:\e[0m" && \
    nix-collect-garbage --delete-older-than 3d 2>&1 | grep "store paths deleted" && \
    echo -e "\n\e[1;32m-> \e[37mOptimising store\e[0m" && \
    nix-store --optimize
  '';

in {

  environment.systemPackages = [ updateScript ];
}
