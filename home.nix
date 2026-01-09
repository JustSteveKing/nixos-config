{ inputs, pkgs, ... }:

{
  imports = [
    # Categories
    ./programs/desktop/default.nix
    ./programs/shell/default.nix
    ./programs/editors/default.nix
    ./programs/dev/default.nix

    # Standalone
    ./programs/agents.nix
    ./programs/browsers.nix
    ./programs/common.nix
    ./programs/obs.nix
    ./programs/scripts.nix
    ./programs/studio-mode.nix
    ./programs/taskwarrior.nix
  ];

  home.sessionVariables = {
    BROWSER = "zen";
    TERMINAL = "ghostty";
    NIXOS_OZONE_WL = "1";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };


  home.stateVersion = "24.05";
}
