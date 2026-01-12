{
  description = "PHP 8.4 / Laravel development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          php84
          php84Packages.composer
          nodejs_22 # For Vite/Livewire
          sqlite
        ];

        shellHook = ''
          echo "🐘 Laravel Dev Environment Loaded"
        '';
      };
    };
}
