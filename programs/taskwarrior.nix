{ pkgs, ... }:

{
  home.packages = with pkgs; [
    taskwarrior3
  ];

  # Basic configuration via Home Manager module
  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;
    config = {
      # Catppuccin-ish colors for your theme
      color = "on";
      # Setting a specific theme if you like
      # theme.file = "${pkgs.taskwarrior3}/share/doc/task/rc/dark-256.theme";
    };
  };
}
