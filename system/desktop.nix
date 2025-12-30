{
  inputs,
  vars,
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (vars) username;
in
{
  imports = [
    inputs.dankMaterialShell.nixosModules.default
    inputs.niri.nixosModules.niri
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  programs.dconf.enable = true;

  programs.dankMaterialShell = {
    enable = true;
    niri = {
      enableKeybinds = true;
      enableSpawn = true;
    };
    greeter = {
      enable = true;
      compositor.name = "niri";
      configHome = "/home/${username}";
      logs.save = true;
    };
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      input = {
        touchpad.natural-scroll = false;
        mouse.natural-scroll = false;
      };
      binds = with config.lib.niri.actions; {
        "Mod+B".action = spawn "firefox";
        "Mod+T".action = spawn "foot";
        "Mod+Q".action = close-window;
        "Mod+H".action = focus-column-left;
        "Mod+L".action = focus-column-right;
        "Mod+J".action = focus-window-up;
        "Mod+K".action = focus-window-down;
      };
    };
  };

  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_ICON_THEME = "Adwaita";
  };
}
