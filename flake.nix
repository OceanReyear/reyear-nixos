{
  description = "reyear-nixos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.reyear-nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/reyear-nixos/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.reyear = { config, pkgs, inputs, ... }: {
              imports = [
                inputs.plasma-manager.homeModules.plasma-manager
                ./hosts/reyear-nixos/home.nix
              ];
            };
          }
        ];
      };
    };
}
