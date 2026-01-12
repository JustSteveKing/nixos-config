{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nix-init

    go
    gopls

    php84
    php84Packages.composer

    nodejs_22
    typescript
    pnpm

  ];
}
