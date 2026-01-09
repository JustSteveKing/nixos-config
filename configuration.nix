{ inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./system/boot.nix
    ./system/environment.nix
    ./system/hardware.nix
    ./system/hyprland.nix
    ./system/network.nix
    ./system/nix.nix
    ./system/services.nix
    ./system/users.nix
    ./system/virtualisation.nix
  ];

  home-manager = {
    backupFileExtension = "bak";
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = false;
    useUserPackages = true;
    users.steve = {
      nixpkgs.config.allowUnfree = true;
      imports = [ ./home.nix ];
    };
  };
}
