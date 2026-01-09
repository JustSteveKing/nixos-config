{ inputs, pkgs, ... }:

{
  imports = [
    ./programs/agents.nix
    ./programs/aliases.nix
    ./programs/browsers.nix
    ./programs/editors.nix
    ./programs/containers.nix
    ./programs/launcher.nix
    ./programs/common.nix
    ./programs/languages.nix
    ./programs/obs.nix
    ./programs/git.nix
    ./programs/ghostty.nix
    ./programs/hyprland.nix
    ./programs/waybar.nix
    ./programs/zellij.nix
    ./programs/taskwarrior.nix
    ./programs/scripts.nix
    ./programs/theme.nix
    ./programs/mako.nix
    ./programs/hyprlock.nix
    ./programs/studio-mode.nix

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
