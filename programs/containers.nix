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

  home.sessionVariables = {
    DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock";
  };
}
