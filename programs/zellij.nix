{ pkgs, ... }:

{
  programs.zellij = {
    enable = true;
    enableBashIntegration = true; # Automatically starts or integrates with Bash
    settings = {
      default_layout = "compact";
      pane_frames = false;
    };
  };
}
