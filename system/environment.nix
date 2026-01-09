{ pkgs, ... }:

{
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    tuigreet
    keymapp # For your Moonlander
  ];

  system.stateVersion = "24.11";
}
