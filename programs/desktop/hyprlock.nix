{ lib, ... }:

{
  programs.hyprlock = {
    enable = true;
    # We use mkForce here to override all of Stylix's generated settings
    settings = lib.mkForce {
      general = {
        disable_loading = true;
        grace = 0;
        hide_cursor = true;
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          outline_thickness = 3;
          dots_size = 0.33;
          dots_spacing = 0.15;
          dots_center = true;
          position = "0, -20";
          halign = "center";
          valign = "center";
          # Stylix would have provided these, so we add them back manually
          # to keep the Catppuccin look
          outer_color = "rgb(180, 190, 254)"; # Lavender
          inner_color = "rgb(30, 30, 46)"; # Base
          font_color = "rgb(205, 214, 244)"; # Text
        }
      ];

      label = [
        {
          text = "$TIME";
          font_size = 64;
          font_family = "JetBrains Mono Nerd Font Bold";
          position = "0, 80";
          halign = "center";
          valign = "center";
          color = "rgb(205, 214, 244)";
        }
      ];
    };
  };
}
