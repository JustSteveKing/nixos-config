{ pkgs, ... }:

{
  home.packages = with pkgs; [
    podman-compose
    podman-tui
    dive
  ];

  home.shellAliases = {
    "pc" = "podman-compose";
    "pi" = "podman images";
    "ps" = "podman ps";
  };
}
