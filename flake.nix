{
  description = "Framework desktop flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-colors.url = "github:misterio77/nix-colors";
    walker.url = "github:abenz1267/walker";
    stylix.url = "github:danth/stylix";


    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, nix-colors, stylix, home-manager, ... }@inputs: {
    nixosConfigurations.framework = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./configuration.nix

        nixos-hardware.nixosModules.common-cpu-amd
        nixos-hardware.nixosModules.common-pc-ssd

        home-manager.nixosModules.home-manager
      ];
    };
  };
}
