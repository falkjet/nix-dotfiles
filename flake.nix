{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    wrappers.url = "github:falkjet/nix-wrapper-packages";
  };
  outputs = { self, ... }@inputs: {
    homeConfigurations = {
      falk = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/falk";
        username = "falk";
        stateVersion = "22.05";
        configuration = { config, lib, pkgs, ...}:
        {
          imports = [ ./home/home.nix ];
          programs.git.userEmail = "falk@jetlund.com";
          programs.git.userName = "Falk Markus Dursun Jetlund";
          home.packages = [ inputs.wrappers.packages.x86_64-linux.neovim ];
        };
      };
    };
    nixosConfigurations.falx-laptop = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =  [
        ({ pkgs, ... }: {
          imports = [ ./machines/falx-laptop/configuration.nix ];
        })  
      ];
    };
  };
}
