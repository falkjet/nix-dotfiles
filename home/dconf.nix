{ lib, ... }:
let keybindings = {
  browser = {
    binding = "<Super>b";
    command = "brave";
    name = "Browser";
  };
  terminal = {
    binding = "<Super>Return";
    command = "kitty";
    name = "Terminal";
  };
};
in
with lib.hm.gvariant;
{
  dconf.settings = {
    "org/gnome/desktop/wm/keybindings" = {
      switch-applications = [ "<Super>Tab" ];
      switch-applications-backward = [ "<Shift><Super>Tab" ];
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
    };

    "org/gnome/desktop/wm/preferences" = {
      resize-with-right-button = true;
    };
  }
  // (builtins.foldl' (a: b: a//b) {} (
    map
      (keybinding: {
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/${keybinding}" = keybindings."${keybinding}";
      })
      (builtins.attrNames keybindings)
  ))
  // {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = (
        map
          (k:
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/${k}/")
          (builtins.attrNames keybindings)
      );
    };
  };
}
