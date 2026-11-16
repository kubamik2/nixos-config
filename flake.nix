{
  inputs = {
    nixpkgsPersonal.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgsServer.url = "github:nixos/nixpkgs/nixos-unstable";

    nixvim-config.url = "github:kubamik2/nixvim-config";
    nix-templates.url = "github:kubamik2/nix-templates";

    agenix.url = "github:ryantm/agenix";

    secrets = {
      url = "git+ssh://git@github.com/kubamik2/secrets.git";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgsPersonal,
      nixpkgsServer,
      nixvim-config,
      nix-templates,
      secrets,
      agenix,
    }@inputs:
    let
      agenixRegistry = import "${secrets}/agenixRegistry.nix";
      specialArgsPersonal = {
        inherit inputs agenixRegistry;
        helpers = import ./helpers nixpkgsPersonal.lib;
      };
      specialArgsServer = {
        inherit inputs agenixRegistry;
        helpers = import ./helpers nixpkgsServer.lib;
      };
    in
    {
      nixosConfigurations = {
        desktop = nixpkgsPersonal.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = specialArgsPersonal;
          modules = [
            ./hosts/desktop/configuration.nix
            agenix.nixosModules.default
          ];
        };
        laptop = nixpkgsPersonal.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = specialArgsPersonal;
          modules = [
            ./hosts/laptop/configuration.nix
            agenix.nixosModules.default
          ];
        };
        rpi4 = nixpkgsServer.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = specialArgsServer;
          modules = [
            ./hosts/rpi4/configuration.nix
            agenix.nixosModules.default
          ];
        };
      };
    };
}
