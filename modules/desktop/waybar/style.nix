{ config, ... }: 

let
  theme = config.ricos.theme;
in {

  home-manager.users.rico.programs.waybar.style = /*css*/ ''
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
      padding: 0px 8px;
    }

    #workspaces button label {
      font-size: 19px;
      color: #${theme.fg};
    }

    #workspaces button.active label {
      color: #${theme.blue};
    }

    #workspaces button:hover {
      background-color: #${theme.blue};
    }

    #workspaces button:hover label {
      color: #${theme.bg0};
    }

    #submap {
      padding: 0px 5px;
      color: #${theme.red};
      background-color: #${theme.bg0};
    }

    #pulseaudio, #disk, #memory, #cpu, #battery, #clock {
      background-color: #${theme.bg0};
    }

    #pulseaudio, #disk, #cpu, #battery, #clock {
      min-width: 65px;
    }

    #memory {
      min-width: 95px;
    }

    #custom-shutdowntime {
      color: #${theme.bg0};
      background-color: #${theme.red};
      min-width: 75px;
    }
  '';
}
