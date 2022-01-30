{ config, lib, pkgs, ...}:
{
  nixpkgs.config = { allowUnfree = true; };

  home.packages = with pkgs; [
    bash
    bat
    coreutils
    delta
    git
    glxinfo
    starship
    thunderbird
    which
  ];
  programs = {
    home-manager.enable = true;
    neovim = {
      enable = true;
      extraConfig = ''
        set number
        set relativenumber
        set mouse=a
        set tabstop=4
        set shiftwidth=4
        set softtabstop=4
        set textwidth=80
        set expandtab
        let g:airline_powerline_fonts = 1
      '';
      plugins = with pkgs.vimPlugins; [
        vim-airline
        vim-airline-themes
        vim-nix
      ];
    };
  };
}

