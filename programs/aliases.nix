{ pkgs, ... }:

{
  home.shellAliases = {

    ll = "ls -l";
    ".." = "cd ..";


    flake = "nvim ~/nixos-config";
    rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#framework";

    t = "task next";
    t-add = "task add";
    t-done = "task done";

  };

  programs.bash.enable = true;
}
