{
  description = "Development environment for corriol_app";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      forAllSystems = function:
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (system: function nixpkgs.legacyPackages.${system});
    in {
      formatter = forAllSystems (pkgs: pkgs.alejandra);

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            flutter
            dart
          ];

          shellHook = ''
            echo "=== Development Environment ==="
            echo "Dart version: $(dart --version 2>&1 | head -n1)"
            echo "Flutter version: $(flutter --version | head -n1)"
            echo "Git version: $(git --version)"
            echo "==============================="
          '';
        };
      });
    };
}

