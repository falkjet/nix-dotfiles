{ config, lib, pkgs, ...}:
{
  imports = [
    ./sway.nix
    ./neovim.nix
    ./dconf.nix
  ];
  nixpkgs.config = { allowUnfree = true; };
  nixpkgs.overlays = [
    (self: super: {
      nerdfonts = super.nerdfonts.override {
        fonts = [ "JetBrainsMono" ];
      };
    })
  ];

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
    evince
    atool
    highlight
    mediainfo
    glow
  ];
  fonts.fontconfig.enable = true;
  programs.bash = {
    enable = true;
    initExtra = ''
      source <(zoxide init bash --cmd c)
      source <(starship init bash --print-full-init)
      export EDITOR=nvim
      export LS_COLORS="di=38;5;39:ex=31:ln=34" 
      export LF_COLORS="di=38;5;39:ex=31:ln=34" 
      export LF_ICONS="di=:fi=:ln=:or=:ex=:\
      *.vimrc=:*.viminfo=:*.gitignore=:*.c=:*.cc=:*.clj=:*.coffee=:\
      *.cpp=:*.css=:*.d=:*.dart=:*.erl=:*.exs=:*.fs=:*.go=:*.h=:*.hh=:*.hpp=:*.hs=:*.html=:*.java=:\
      *.jl=:*.js=:*.json=:*.lua=:*.md=:*.php=:*.pl=:*.pro=:*.py=:*.rb=:*.rs=:*.scala=:*.ts=:*.vim=:\
      *.cmd=:*.ps1=:*.sh=:*.bash=:*.zsh=:*.fish=:*.tar=:*.tgz=:*.arc=:*.arj=:*.taz=:*.lha=:*.lz4=:*.lzh=:\
      *.lzma=:*.tlz=:*.txz=:*.tzo=:*.t7z=:*.zip=:*.z=:*.dz=:*.gz=:*.lrz=:*.lz=:*.lzo=:*.xz=:*.zst=:\
      *.tzst=:*.bz2=:*.bz=:*.tbz=:*.tbz2=:*.tz=:*.deb=:*.rpm=:*.jar=:*.war=:*.ear=:*.sar=:\
      *.rar=:*.alz=:*.ace=:*.zoo=:*.cpio=:*.7z=:*.rz=:*.cab=:*.wim=:*.swm=:*.dwm=:*.esd=:\
      *.jpg=:*.jpeg=:*.mjpg=:*.mjpeg=:*.gif=:*.bmp=:*.pbm=:*.pgm=:*.ppm=:*.tga=:*.xbm=:*.xpm=:\
      *.tif=:*.tiff=:*.png=:*.svg=:*.svgz=:*.mng=:*.pcx=:*.mov=:*.mpg=:*.mpeg=:*.m2v=:*.mkv=:\
      *.webm=:*.ogm=:*.mp4=:*.m4v=:*.mp4v=:*.vob=:*.qt=:*.nuv=:*.wmv=:*.asf=:*.rm=:*.rmvb=:\
      *.flc=:*.avi=:*.fli=:*.flv=:*.gl=:*.dl=:*.xcf=:*.xwd=:*.yuv=:*.cgm=:*.emf=:*.ogv=:\
      *.ogx=:*.aac=:*.au=:*.flac=:*.m4a=:*.mid=:*.midi=:*.mka=:*.mp3=:*.mpc=:*.ogg=:*.ra=:\
      *.wav=:*.oga=:*.opus=:*.spx=:*.xspf=:*.pdf=:*.nix="
    '';
  };
  programs.kitty = {
    extraConfig = ''
      window_margin_width 5
      background_opacity 0.7
      font_family JetBrainsMono Nerd Font
      wayland_titlebar_color #23252e
      hide_window_decorations yes
    '';
    enable = true;
  };
  programs.rofi = {
    enable = true;
    theme = "sidebar";
  };
  programs.home-manager.enable = true;
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
      "editor.fontFamily" = "JetBrainsMono Nerd Font Mono";
      "editor.fontLigatures" = true;
      "terminal.integrated.allowChords" = false;
      "terminal.integrated.commandsToSkipShell" = [ "-workbench.action.quickOpen" ];
      "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font Mono";
      "[javascript][typescript][javascriptreact][typescriptreact]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
    };
  };
  programs.git = {
    enable = true;
    delta.enable = true;
  };
  programs.lf = {
    enable = true;
    settings = {
      shell = "bash";
      shellopts = "-eu";
      ifs = "\\n";
      drawbox = true;
      icons = true;
      scrolloff = 10;
      promptfmt = " \\033[38;5;39m%w";
    };
    keybindings = {
      "." = "set hidden!";
      "d" = "";
      "dd" = "delete";

      "m" = "";
      "md" = "mkdir";
      "mf" = "touch";
      "ms" = "mkscript";
      "ml" = "mktexproject";
      "<c-c>" = "copy";
      "<c-x>" = "cut";
      "<c-v>" = "paste";
      "<esc>" = "clear";
      "<enter>" = "shell";
      "x" = "$$f";
      "X" = "!$f";
      "a" = "";
      "at" = "tar";
      "ax" = "extract";
    };
    commands = {
      "open" = ''
        ${"$"}{{
            test -L $f && f=$(readlink -f $f)
            case $(file --mime-type $f -b) in
                text/*) $EDITOR $fx;;
                *) for f in $fx; do setsid $OPENER $f > /dev/null 2> /dev/null & done;;
            esac
        }}
      '';
      "delete" = "$rm -rf $fx";
      "mkdir" = ''
        %{{
            echo -n "Enter directory name: "
            read fn
            mkdir -p "$fn"
        }}
      '';
      "touch" = ''
        %{{
            echo -n "Enter file name: "
            read fn
            touch "$fn"
        }}
      '';
      "mkscript" = ''
        %{{
            echo -n "Enter script name: "
            read fn
            echo "#!/bin/sh" >> "$fn"
            chmod +x "$fn"
        }}
      '';
      "mktexproject" = ''
        %{{
            echo -n "Enter project name: "
            read pn
            mkdir "$pn"
            fn="$pn/$(basename "$pn").tex"
            name="$(getent passwd "$(whoami)" | cut -d: -f5)"
            echo '\documentclass{article}' > "$fn"
            echo "" >> "$fn"
            echo "\\title{$(basename "$pn")}" >> "$fn"
            echo "\\author{$name}" >> "$fn"
            echo '\date{\today}' >> "$fn"
            echo "" >> "$fn"
            echo '\begin{document}' >> "$fn"
            echo '    \maketitle' >> "$fn"
            echo '\end{document}' >> "$fn"
        }}
      '';
      "extract" = "$aunpack $f";
      "tar" = ''%tar -caf "$(basename $f)".tar.gz "$(basename $f)"'';
    };
    previewer.source = pkgs.writeShellScript "preview" ''
      case "$1" in 
          *.png|*.jpg|*.jpeg|*.mkv|*.mp4) mediainfo "$1";;
          *.zip|*.tar|*.tar.gz|*.tar.bz2|*.tar.xz) als "$1";;
          *.md) glow -s dark "$1";;
          *.json) cat "$1" | jq -C;;
          *) bat -f --style=plain "$1";;
      esac
    '';
  };
}

