
## Steps for nixifying a new Rust project

1. [x] Add a simple `flake.nix` with a devShell that gets activated *automatically* when you open VSCode.
    - (General step; not rust specific)
1. [x] **Rust dev shell**: Use https://crane.dev/ to provide a Rust dev shell
    - We'll also use https://github.com/oxalica/rust-overlay to get the appropriate Rust version based on toolchain
    - Example, https://github.com/srid/dioxus-desktop-template/blob/master/nix/flake-module.nix
1. [x] **Rust package**: `nix build` should build the packages
1. [ ] Use treefmt and format Rust sources along with Nix.
1. [ ] Re-factor `flake.nix` by moving Rust logic to a new flake module

Stretch,

1. [ ] Direnv + VSCode IDE setup