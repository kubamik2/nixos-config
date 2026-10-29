{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim-config.url = "github:kubamik2/nixvim-config";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, fenix, ... }@inputs:
    let
      helpers = import ./helpers nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs helpers; };
          modules = [
            ./hosts/desktop/configuration.nix
          ];
        };
      };

      templates.test = {
        path = ./dev;
        description = "test";
      };
      
      devShells."x86_64-linux".rust =
        with pkgs;
        mkShell {
          buildInputs = [
            (
              fenix.packages.${system}.stable.toolchain
            )
          ];
        };
    };
}
