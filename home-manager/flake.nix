{
  description = "Home Manager configuration of mark";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    {
      homeConfigurations = {
        "mark@Marks-MBP" = home-manager.lib.homeManagerConfiguration {
          # pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            config.allowUnfree = true;
          };
          modules = [
            ./home/macbook.nix
            ./home/common.nix
          ];
        };
        "mark@rumfoord" = home-manager.lib.homeManagerConfiguration {
          # pkgs = nixpkgs.legacyPackages.x86_64-linux;
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          modules = [
            ./home/rumfoord.nix
            ./home/common.nix
          ];
        };
      };
    };
}
