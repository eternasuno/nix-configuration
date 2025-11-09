{ pkgs, config, ... }:
let
  noctalia =
    cmd:
    [
      "noctalia-shell"
      "ipc"
      "call"
    ]
    ++ (pkgs.lib.splitString " " cmd);
in
{
  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      spawn-at-startup = [
        { command = [ "noctalia-shell" ]; }
      ];

      binds = with config.lib.niri.actions; {
        "Mod+Space".action.spawn = noctalia "launcher toggle";
        "Mod+S".action.spawn = noctalia "controlCenter toggle";
        "Mod+Comma".action.spawn = noctalia "settings toggle";

        "Mod+V".action.spawn = noctalia "launcher clipboard";
        "Mod+C".action.spawn = noctalia "launcher calculator";
        "Mod+L".action.spawn = noctalia "lockScreen lock";

        "XF86AudioLowerVolume".action.spawn = noctalia "volume decrease";
        "XF86AudioRaiseVolume".action.spawn = noctalia "volume increase";
        "XF86AudioMute".action.spawn = noctalia "volume muteOutput";
        "XF86MonBrightnessUp".action.spawn = noctalia "brightness increase";
        "XF86MonBrightnessDown".action.spawn = noctalia "brightness decrease";

        "Mod+T".action.spawn = "foot";
      };

      environment = {
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        QT_QPA_PLATFORMTHEME = "gtk3";
        QT_ICON_THEME = "Adwaita";
      };
    };
  };
}
