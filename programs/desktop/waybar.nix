{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        margin-top = 5;
        margin-left = 10;
        margin-right = 10;

        modules-left = [ "custom/nix" "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "pulseaudio#microphone" "pulseaudio" "clock" "tray" ];

        "custom/nix" = {
          format = "  "; # The NixOS Icon (requires Nerd Fonts)
          tooltip = false;
          on-click = "walker"; # Open your new launcher when clicked
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            default = "";
          };
        };

        "pulseaudio#microphone" = {
          format = "{format_source}";
	  format-source = " {volume}%";
	  format-source-muted = " Muted";
	  on-click = "pamixer --default-source -t";
	  on-scroll-up = "pamixer --default-source -i 5";
	  on-scroll-down = "pamixer --default-source -d 5";
	  scroll-step = 5;
	};

	"pulseaudio" = {
          format = "{icon} {volume}%";
	  format-muted = "󰝟";
	  format-icons = {
            default = ["󰕿" "󰖀" "󰕾"];
	  };
	  on-click = "pavucontrol";
	};

        "clock" = {
          format = "{:%H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
      };
    };
    
    # Custom CSS for the "Omarchy" floating glass look
    style = ''

      * {
    border: none;
    font-family: "JetBrainsMono Nerd Font";
    font-weight: bold;
    font-size: 13px;
  }

  window#waybar {
    background: rgba(26, 27, 38, 0); /* Fully transparent outer window */
  }

  /* The container for all modules */
  .modules-left, .modules-center, .modules-right {
    background: rgba(30, 30, 46, 0.7); /* The "Glass" effect */
    border: 1px solid rgba(255, 255, 255, 0.1);
    padding: 2px 10px;
    border-radius: 15px;
    margin: 5px 0;
  }

  #custom-nix {
    color: #89b4fa;
    font-size: 18px;
    padding-right: 12px;
  }

  #workspaces button {
    color: #585b70;
    padding: 0 4px;
  }

  #workspaces button.active {
    color: #f5c2e7;
  }

  #workspaces button.urgent {
    color: #f38ba8;
  }

    '';
  };
}
