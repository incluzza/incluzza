{ inputs, ... }:

let
  # Project-specific vars
  src = ../Backend;
  # Dependencies for building the Rust package
  rustBuildInputs = pkgs: with pkgs; [
    hasura-cli
  ] ++ lib.optionals pkgs.stdenv.isDarwin (
    with pkgs.darwin.apple_sdk.frameworks; [
      Security
      IOKit
    ]
  );
in
{
  perSystem = { config, pkgs, lib, system, ... }:
    let
      rustToolchain = (pkgs.rust-bin.fromRustupToolchainFile (src + /rust-toolchain.toml)).override {
        extensions = [
          "rust-src"
          "rust-analyzer"
          "clippy"
        ];
      };

      craneLib = (inputs.crane.mkLib pkgs).overrideToolchain rustToolchain;

      cargoToml = builtins.fromTOML (builtins.readFile (src + "/Cargo.toml"));

      args = {
        inherit src;
        pname = cargoToml.package.name;
        version = cargoToml.package.version;
        # Non-Rust dependencies
        buildInputs = rustBuildInputs pkgs;
        strictDeps = true;
      };

      cargoArtifacts = craneLib.buildDepsOnly args;
      package = craneLib.buildPackage (args // {
        inherit cargoArtifacts;
      });
    in
    {
      packages.${cargoToml.package.name} = package;

      devShells.${cargoToml.package.name} = pkgs.mkShell {
        name = "rustdevshell";
        nativeBuildInputs = rustBuildInputs pkgs ++ [
          pkgs.lazygit
          rustToolchain
        ];
        shellHook = ''
          # For rust-analyzer 'hover' tooltips to work.
          export RUST_SRC_PATH="${rustToolchain}/lib/rustlib/src/rust/library";
        '';
      };
    };
}
