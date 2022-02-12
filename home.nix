{ config, lib, pkgs, ...}:
{
  imports = [ ./sway.nix ];
  nixpkgs.config = { allowUnfree = true; };

  gtk = {
    enable = true;
    iconTheme.package = pkgs.flat-remix-icon-theme;
    iconTheme.name = "Flat-Remix-Green-Dark";
    theme.package = pkgs.flat-remix-gtk;
    theme.name = "Flat-Remix-GTK-Green-Dark-Solid";
  };

  home.packages = with pkgs; [
    brave
    teams
    nerdfonts
    bat
    coreutils
    tree
    delta
    git
    glxinfo
    zoxide
    starship
    thunderbird
    which
  ];
  fonts.fontconfig.enable = true;
  programs.bash = {
    enable = true;
    initExtra = ''
      source <(zoxide init bash --cmd c)
      source <(starship init bash --print-full-init)
    '';
  };
  programs.kitty = {
    extraConfig = ''
      window_margin_width 5
      background_opacity 0.6
    '';
    enable = true;
  };
  programs.rofi = {
    enable = true;
    theme = "sidebar";
  };
  programs.home-manager.enable = true;
  programs.neovim = {
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
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      bungcip.better-toml
      ms-vscode.cpptools
      graphql.vscode-graphql
      ms-toolsai.jupyter
      james-yu.latex-workshop
      pkief.material-icon-theme
      bbenoist.nix
      esbenp.prettier-vscode
    ];
    userSettings = {
      "workbench.colorTheme" = "Dracula";
      "workbench.iconTheme" = "material-icon-theme";
      "editor.formatOnSave" = true;
      "terminal.integrated.allowChords" = false;
      "terminal.integrated.commandsToSkipShell" = [ "-workbench.action.quickOpen" ];
      "terminal.integrated.fontFamily" = "TerminessTTF Nerd Font";
      "[javascript][typescript][javascriptreact][typescriptreact]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
    };
  };
  programs.git = {
    enable = true;
    delta.enable = true;
  };
}

