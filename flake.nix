{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";

    # Rust inputs
    rust-overlay.url = "github:oxalica/rust-overlay";
    crane.url = "github:ipetkov/crane";
    crane.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      imports = [
      ];
      perSystem = { config, pkgs, lib, system, ... }:
        let
          src = ./Backend;

          rustToolchain = (pkgs.rust-bin.fromRustupToolchainFile (src + /rust-toolchain.toml)).override {
            extensions = [
              "rust-src"
              "rust-analyzer"
              "clippy"
            ];
          };

          craneLib = (inputs.crane.mkLib pkgs).overrideToolchain rustToolchain;

          rustBuildInputs = [
            pkgs.hasura-cli
          ];

          cargoToml = builtins.fromTOML (builtins.readFile (src + "/Cargo.toml"));

          args = {
            inherit src;
            pname = cargoToml.package.name;
            version = cargoToml.package.version;
            # Non-Rust dependencies
            buildInputs = rustBuildInputs;
            strictDeps = true;
          };

          cargoArtifacts = craneLib.buildDepsOnly args;
          package = craneLib.buildPackage (args // {
            inherit cargoArtifacts;
          });
        in
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              inputs.rust-overlay.overlays.default
            ];
          };

          packages.default = package;

          devShells.default = pkgs.mkShell {
            name = "incluzza-dev";
            nativeBuildInputs = rustBuildInputs ++ [
              pkgs.lazygit
              rustToolchain
            ];
            shellHook = ''
              # For rust-analyzer 'hover' tooltips to work.
              export RUST_SRC_PATH="${rustToolchain}/lib/rustlib/src/rust/library";
            '';
          };
          formatter = pkgs.nixpkgs-fmt; # nix fmt (TODO: replace with treefmt)
        };
    };
}
