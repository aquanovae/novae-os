{ config, lib, username, ... }: let

  theme = config.novaeOs.theme;

in {

  config = lib.mkIf config.novaeOs.desktopEnvironment.enable {
    home-manager.users.${username}.programs.waybar.style = /*css*/ ''

      * {
        border-radius: 7px;
      }

      window#waybar {
        font-family: JetBrainsMono Nerd Font;
        font-size: 13px;
        background-color: rgba(0, 0, 0, 0);
        color: #${theme.fg};
      }

      .modules-left {
        border: 2px solid #${theme.gray};
        background-color: #${theme.bg3};
      }

      .modules-right {
        border: 2px solid #${theme.gray};
        background-color: #${theme.bg3};
      }

      #custom-os-icon {
        font-size: 23px;
        padding: 0px 13px 0px 7px;
        border-radius: 5px;
        color: #${theme.bg0};
        background-color: #${theme.blue};
      }

      #workspaces {
        border-radius: 5px;
        background-color: #${theme.bg0};
      }

      #workspaces button {
        margin: 0px;
        padding: 0px 12px 0px 8px;
      }

      #workspaces button label {
        font-size: 19px;
        color: #${theme.fg};
      }

      #workspaces button.active label {
        color: #${theme.blue};
      }

      #workspaces button.special label {
        color: #${theme.yellow};
      }

      #workspaces button:hover {
        background-color: #${theme.blue};
      }

      #workspaces button:hover label {
        color: #${theme.bg0};
      }

      #custom-playerctl-info {
        padding: 0px 11px;
        color: #${theme.fg};
        background-color: alpha(#${theme.bg0}, 0.67);
      }

      #custom-shutdowntime {
        color: #${theme.bg0};
        background-color: #${theme.red};
        min-width: 80px;
      }

      #wireplumber,
      #disk,
      #memory,
      #cpu,
      #battery,
      #custom-gpu-info,
      #clock {
        background-color: #${theme.bg0};
      }

      /* width = (str_length + 1) * 10 */

      #wireplumber,
      #disk,
      #cpu,
      #battery,
      #custom-gpu-info,
      #clock {
        min-width: 70px;
      }

      #memory,
      #clock {
        min-width: 100px;
      }
    '';
  };
}
