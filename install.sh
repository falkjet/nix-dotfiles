#!/bin/sh
nix profile remove $(nix profile list | grep home-manager-path | cut -d" " -f1)
nix shell github:nix-community/home-manager#home-manager --no-write-lock-file -c home-manager switch --flake .
