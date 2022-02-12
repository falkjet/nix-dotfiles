{ config, lib, pkgs, ...}:
{
  home.packages = with pkgs; [
    grim
    wl-clipboard
    slurp
    pulseaudio
  ];
  wayland.windowManager.sway = {
    enable = true;
    config.focus.forceWrapping = true;
    config.floating.modifier = "Mod4";
    config.window.border = 0;
    config.colors = {
      focused = { border = "#06ab8b"; childBorder = "#06ab8b"; background = "#06ab8b"; text = "#ffffff"; indicator = "#dddddd"; };
      focusedInactive = { border = "#282a36"; childBorder = "#282a36"; background = "#282a36"; text = "#888888"; indicator = "#292d2e"; };
      unfocused = { border = "#282a36"; childBorder = "#282a36"; background = "#282a36"; text = "#888888"; indicator = "#292d2e"; };
      urgent = { border = "#2f343a"; childBorder = "#2f343a"; background = "#900000"; text = "#ffffff"; indicator = "#900000"; };
    };
    config.bars = [{command = "waybar"; }];
    config.keybindings = let
      mod = "Mod4";
      workspaces = ["1" "2" "3" "4" "5" "6" "7" "8" "9" "10"];
    in {
      "${mod}+Return" = "exec kitty";
      "${mod}+Shift+r" = "reload";
      "${mod}+space" = "exec rofi -modi drun -show drun";
      "${mod}+b" = "exec brave";

      "Print" = ''exec grim -t png - | wl-copy -t image/png'';
      "Shift+Print" = ''exec grim -t png -g "$(slurp -d)" - | wl-copy -t image/png'';

      XF86AudioRaiseVolume = "exec pactl set-sink-volume @DEFAULT_SINK@ +10%";
      XF86AudioLowerVolume = "exec pactl set-sink-volume @DEFAULT_SINK@ -10%";
      XF86AudioMute = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
      XF86AudioMicMute = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";

      "Mod1+Tab" = "focus next";
      "${mod}+h" = "focus left";
      "${mod}+j" = "focus down";
      "${mod}+k" = "focus up";
      "${mod}+l" = "focus right";
      "${mod}+Left" = "focus left";
      "${mod}+Down" = "focus down";
      "${mod}+Up" = "focus up";
      "${mod}+Right" = "focus right";

      "${mod}+Shift+h" = "move left";
      "${mod}+Shift+j" = "move down";
      "${mod}+Shift+k" = "move up";
      "${mod}+Shift+l" = "move right";
      "${mod}+Shift+Left" = "move left";
      "${mod}+Shift+Down" = "move down";
      "${mod}+Shift+Up" = "move up";
      "${mod}+Shift+Right" = "move right";


      "${mod}+v" = "split v";
      "${mod}+f" = "fullscreen toggle";
      "${mod}+s" = "layout stacking";
      "${mod}+w" = "layout tabbed";
      "${mod}+e" = "layout toggle split";
      "${mod}+Shift+space" = "floating toggle";
      "${mod}+a" = "focus parent";
      "${mod}+d" = "focus child";
      "${mod}+q" = "kill";
      "Mod1+f4" = "kill";
      "${mod}+Shift+e" = ''exec "swaynag -m 'do you want to exit sway' -z 'exit sway' 'swaymsg exit' -s cancel"'';
    }
    // builtins.foldl' (a: b: a//b) {} (
      map (w: {"${mod}+${if w == "10" then "0" else w}" = "workspace number ${w}";}) workspaces
    )
    // builtins.foldl' (a: b: a//b) {} (
      map (w: {"${mod}+Shift+${if w == "10" then "0" else w}" = "move container to workspace number ${w}";}) workspaces
    );
    config.input = {
      "*" = { xkb_layout = "no"; };
    };
  };
  
  programs.waybar = {
    enable = true;
    settings.mainbar = {
      position = "bottom";
      height = 30;
      modules-left = ["sway/workspaces" "sway/mode"];
      modules-center = ["sway/window"];
      modules-right = [
        "idle_inhibitor"
        "pulseaudio"
        "cpu"
        "memory"
        "temperature"
        "backlight"
        "battery"
        "clock"
        "tray"
      ];

      "sway/mode" = {
        "format" = "<span style=\"italic\">{}</span>";
      };
      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
      };
      tray = {
        spacing = 10;
      };
      clock = {
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        format-alt = "{:%Y-%m-%d}";
      };
      cpu = {
        format = "{usage}% ";
        tooltip = false;
      };
      memory = {
        format = "{}% ";
      };
      temperature = {
        critical-threshold = 80;
        format = "{temperatureC}°C {icon}";
        format-icons = ["" "" ""];
      };
      "backlight" = {
        format = "{percent}% {icon}";
        format-icons = ["" ""];
      };
      "battery" = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{capacity}% {icon}";
        format-charging = "{capacity}% ";
        format-plugged = "{capacity}% ";
        format-alt = "{time} {icon}";
        format-icons = ["" "" "" "" ""];
      };
      pulseaudio = {
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-muted = " {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = ["" "" ""];
        };
        on-click = "pavucontrol";
      };
    };
    style = builtins.readFile ./waybar.css;
  };
}
