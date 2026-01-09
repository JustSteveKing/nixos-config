{ pkgs, ... }:

let
  flake-enable = pkgs.writeShellScriptBin "flake-enable" ''
    TYPE=$1
    
    if [ -z "$TYPE" ]; then
      echo "Usage: flake-enable [php|go|ts]"
      exit 1
    fi

    # 1. Create the .envrc for direnv
    echo "use flake" > .envrc
    direnv allow

    # 2. Generate the Flake based on type
    case $TYPE in
      php|laravel)
        cat <<EOF > flake.nix
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.\${pkgs.system};
    in {
      devShells.\${pkgs.system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          php83
          php83Packages.composer
          nodejs_22 # For Vite/Livewire
          sqlite
        ];
        shellHook = "echo '🐘 Laravel Dev Environment Loaded'";
      };
    };
}
EOF
        ;;
      go)
        cat <<EOF > flake.nix
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.\${pkgs.system};
    in {
      devShells.\${pkgs.system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [ go gopls gotools ];
        shellHook = "echo '🐹 Go Dev Environment Loaded'";
      };
    };
}
EOF
        ;;
      ts|typescript)
        cat <<EOF > flake.nix
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.\${pkgs.system};
    in {
      devShells.\${pkgs.system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [ nodejs_22 typescript nodePackages.typescript-language-server ];
        shellHook = "echo '🟦 TypeScript Dev Environment Loaded'";
      };
    };
}
EOF
        ;;
    esac

    echo "✅ Generated flake.nix and enabled direnv for $TYPE"
  '';
in
{
  home.packages = [ flake-enable ];
}
