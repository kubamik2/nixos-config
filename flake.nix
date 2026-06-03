{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim-config = {
      url = "github:kubamik2/nixvim-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:/nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixvim-config,
    stylix,
    silentSDDM,
    plasma-manager,
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages."${system}";
    HMBackupCommand = "${pkgs.trash-cli}/bin/trash-put";
  in {
    nixosConfigurations = {
      vivobookPro14 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/vivobookPro14/configuration.nix
          silentSDDM.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              backupCommand = HMBackupCommand;
              useGlobalPkgs = true;
              useUserPackages = true;
              users.kubamik2.imports = [
                ./hosts/vivobookPro14/home.nix
                stylix.homeModules.stylix
              ];
            };
          }
        ];
      };
      desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/desktop/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              backupCommand = HMBackupCommand;
              useGlobalPkgs = true;
              useUserPackages = true;
              users.kubamik2.imports = [
                ./hosts/desktop/home.nix
                plasma-manager.homeModules.plasma-manager
              ];
            };
          }
        ];
      };
    };
  };
}
