{
  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";

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
      nixpkgs-unstable,
      nixpkgs-stable,
      nixvim-config,
      nix-templates,
      secrets,
      agenix,
    }@inputs:
    let
      agenixRegistry = import "${secrets}/agenixRegistry.nix";
      specialArgsUnstable = {
        inherit inputs agenixRegistry;
        helpers = import ./helpers nixpkgs-unstable.lib;
      };
      specialArgsStable = {
        inherit inputs agenixRegistry;
        helpers = import ./helpers nixpkgs-stable.lib;
      };
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs-unstable.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = specialArgsUnstable;
          modules = [
            ./hosts/desktop/configuration.nix
            agenix.nixosModules.default
          ];
        };
        laptop = nixpkgs-unstable.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = specialArgsUnstable;
          modules = [
            ./hosts/laptop/configuration.nix
          ];
        };
        rpi4 = nixpkgs-stable.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = specialArgsStable;
          modules = [
            ./hosts/rpi4/configuration.nix
          ];
        };
      };
    };
}
