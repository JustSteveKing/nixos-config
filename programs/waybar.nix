{ ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "network" "cpu" "memory" "battery" "tray" ];

        "hyprland/workspaces" = {
          format = "{name}";
          on-click = "activate";
        };

        "clock" = {
          format = "{:%H:%M}  ";
          format-alt = "{:%A, %B %d, %Y}  ";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-icons = ["" "" "" "" ""];
        };

        "network" = {
          format-wifi = "{essid} ";
          format-ethernet = "Connected ";
          format-disconnected = "Disconnected ⚠";
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrains Mono", "Symbols Nerd Font";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background-color: #1e1e2e; /* Catppuccin Mocha Base */
        color: #cdd6f4;           /* Catppuccin Mocha Text */
        transition-property: background-color;
        transition-duration: .5s;
        border-bottom: 2px solid #313244;
      }

      #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: #cdd6f4;
      }

      #workspaces button.active {
        color: #89b4fa; /* Blue */
        border-bottom: 2px solid #89b4fa;
      }

      #workspaces button:hover {
        background: rgba(0, 0, 0, 0.2);
        box-shadow: inherit;
        text-shadow: inherit;
      }

      #clock, #battery, #cpu, #memory, #network, #tray {
        padding: 0 10px;
        color: #cdd6f4;
      }

      #battery.charging {
        color: #a6e3a1; /* Green */
      }

      #battery.warning:not(.charging) {
        color: #f9e2af; /* Yellow */
      }

      #battery.critical:not(.charging) {
        color: #f38ba8; /* Red */
      }
    '';
  };
}
