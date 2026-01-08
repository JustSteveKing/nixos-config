{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    
    settings = {
      # Basic Appearance
      font-family = "JetBrains Mono";
      font-size = 12;
      window-decoration = false;

      # Launch Zellij automatically
      command = "${pkgs.zellij}/bin/zellij";

      # Corrected Catppuccin Mocha Colors (Note the '#' and 6-char hex)
      background = "#1e1e2e";
      foreground = "#cdd6f4";
      cursor-color = "#f5e0dc";
      selection-background = "#313244";
      selection-foreground = "#cdd6f4"; # Fixed typo: was "cddd6f4"

      palette = [
        "0=#45475a" "1=#f38ba8" "2=#a6e3a1" "3=#f9e2af"
        "4=#89b4fa" "5=#f5c2e7" "6=#94e2d5" "7=#bac272"
        "8=#585b70" "9=#f38ba8" "10=#a6e3a1" "11=#f9e2af"
        "12=#89b4fa" "13=#f5c2e7" "14=#94e2d5" "15=#a6adc8"
      ];
    };
  };

  home.packages = with pkgs; [
    jetbrains-mono
  ];
}
