{ pkgs, ... }:

{
  home.packages = with pkgs; [
    zip
    unzip
    ripgrep
    jq
    htop
    fastfetch
    jetbrains-mono
    apostrophe
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only

    brightnessctl
    pamixer
    playerctl

    hyprlauncher


    # Generic file manager (Nautilus works fine even without GNOME)
    nautilus

    kdePackages.kdenlive
  ];
}
