{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim_config.url = "github:kubamik2/nixvim_config";
    stylix = {
      url = "github:/nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixvim_config,
    stylix,
    silentSDDM
  } @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      vivobookPro14 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./modules/hosts/vivobookPro14/configuration.nix
          # stylix.nixosModules.stylix
          silentSDDM.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              # users.kubamik2 = import ./modules/hosts/vivobookPro14/home.nix;
              users.kubamik2.imports = [
                ./modules/hosts/vivobookPro14/home.nix
                stylix.homeModules.stylix
              ];
            };
          }
        ];
      };
    };
  };
}
