{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Steve McDougall";
        email = "juststevemcd@gmail.com";
      };
      init.defaultBranch = "main";
    };
  };
}
