{ pkgs, ... }:

{
  programs.firefox.enable = true;

  programs.zen-browser = {
    enable = true;
  };

  home.packages = with pkgs; [

  ];
}
