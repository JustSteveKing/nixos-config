{ pkgs, inputs, ... }:

{
  imports = [ inputs.stylix.homeModules.default ];

  stylix.targets.firefox.profileNames = [ "default" ];
  stylix.targets.mako.enable = true;
  stylix.targets.hyprlock.enable = true;

  stylix = {
    enable = true;
    image = ../assets/bg.png;

    opacity = {
      desktop = 0.8;
    };

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    fonts = {
      monospace = {
        package = pkgs.jetbrains-mono;
	name = "JetBrains Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
	name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
	name = "DevjsVu Serif";
      };
      sizes = {
        applications = 12;
	terminal = 12;
	desktop = 10;
      };
    };

    targets = {
      vscode.enable = true;
      ghostty.enable = true;
      waybar.enable = true;
      hyprland.enable = true;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

  };
}
