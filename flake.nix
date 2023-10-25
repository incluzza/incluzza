{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
  };
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      imports = [
      ];
      perSystem = { config, pkgs, lib, ... }: {
        devShells.default = pkgs.mkShell {
          name = "incluzza-dev";
          nativeBuildInputs = with pkgs; [
            lazygit
          ];
        };
        formatter = pkgs.nixpkgs-fmt; # nix fmt
      };
    };
}
