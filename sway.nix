{ config, lib, pkgs, ...}:
{
  wayland.windowManager.sway = {
    enable = true;
    config.focus.forceWrapping = true;
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
    }
    // builtins.foldl' (a: b: a//b) {} (map (w: {"${mod}+${w}" = "workspace number ${w}";}) workspaces)
    // builtins.foldl' (a: b: a//b) {} (map (w: {"${mod}+Shift+${w}" = "move container to workspace number ${w}";}) workspaces);
    config.input = {
      "*" = { xkb_layout = "no"; };
    };
  };
}
