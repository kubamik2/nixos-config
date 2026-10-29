{
  description = "Rust dev flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { fenix, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default =
        with pkgs;
        mkShell {
          buildInputs = [
            (
              if builtins.pathExists (builtins.toString ./rust-toolchain.toml) then
                fenix.packages.${system}.fromToolchainFile { dir = ./.; }
              else
                fenix.packages.${system}.minimal.toolchain
            )
          ];
        };
    };
}
