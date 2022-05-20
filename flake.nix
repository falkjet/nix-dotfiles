{
  description = "A very basic flake";
  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    home-manager.url = "github:nix-community/home-manager";
    wrappers.url = "github:falkjet/nix-wrapper-packages";
  };
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, wrappers }:
  let
    system = "x86_64-linux";
    pkgs = (import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    });
    pkgs-unstable = (import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    });
  in {
    homeConfigurations = {
      falk = home-manager.lib.homeManagerConfiguration {
        inherit system;
        pkgs = pkgs-unstable;
        homeDirectory = "/home/falk";
        username = "falk";
        stateVersion = "22.05";
        configuration = { config, lib, pkgs, ...}:
        {
          imports = [ ./home/home.nix ];
          programs.git.userEmail = "falk@jetlund.com";
          programs.git.userName = "Falk Markus Dursun Jetlund";
          home.packages = [ wrappers.packages.x86_64-linux.neovim ];
        };
      };
    };
    nixosConfigurations.falx-laptop = nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      modules =  [
        ({ pkgs, ... }: {
          imports = [ ./machines/falx-laptop/configuration.nix ];
        })  
      ];
    };
  };
}
