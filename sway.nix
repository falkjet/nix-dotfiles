{ config, lib, pkgs, ...}:
{
  wayland.windowManager.sway = {
    enable = true;
    config.focus.forceWrapping = true;
    config.floating.modifier = "Mod4";
    config.window.border = 0;
    config.colors = {
      focused = { border = "#00afff"; childBorder = "#00afff"; background = "#00afff"; text = "#000000"; indicator = "#dddddd"; };
      focusedInactive = { border = "#282a36"; childBorder = "#282a36"; background = "#282a36"; text = "#888888"; indicator = "#292d2e"; };
      unfocused = { border = "#282a36"; childBorder = "#282a36"; background = "#282a36"; text = "#888888"; indicator = "#292d2e"; };
      urgent = { border = "#2f343a"; childBorder = "#2f343a"; background = "#900000"; text = "#ffffff"; indicator = "#900000"; };
    };
    config.keybindings = let
      mod = "Mod4";
      workspaces = ["1" "2" "3" "4" "5" "6" "7" "8" "9" "0"];
    in {
      "${mod}+Return" = "exec kitty";
      "${mod}+Shift+r" = "reload";
      "${mod}+space" = "exec rofi -modi drun -show drun";
      "${mod}+b" = "exec brave";

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
    // builtins.foldl' (a: b: a//b) {} (map (w: {"${mod}+${w}" = "workspace number ${w}";}) workspaces)
    // builtins.foldl' (a: b: a//b) {} (map (w: {"${mod}+Shift+${w}" = "move container to workspace number ${w}";}) workspaces);
    config.input = {
      "*" = { xkb_layout = "no"; };
    };
  };
}
